{ pkgs ? import <nixpkgs> {}, ... }: let 
  scannerScript = pkgs.writeShellScriptBin "scanner" ''
  #!${pkgs.runtimeShell}
  NEW_IMAGE=$HOME/inbox-scanner/scan-$(date +%Y-%m-%d-%H-%M-%S).png

  scanimage --format=png --resolution=300 --mode=color > $NEW_IMAGE
  echo "Scanned image saved to $NEW_IMAGE"
 '';
in {
  environment.systemPackages = [
    scannerScript
  ];

  ## === Scanner ===
  hardware.sane.enable = true;

  ## === Sane Web UI ===
  systemd.services.sane-web = {
    description = "Sane Web UI";
    after = [ "network.target" ];
    wants = [ "network.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.docker}/bin/docker run \
          --publish 8054:8080 \
          --volume /var/run/dbus:/var/run/dbus \
          --restart unless-stopped \
          --name sane-web \
          --privileged sbs20/scanservjs:latest
      '';
      Restart = "always";
    };

    wantedBy = [ "multi-user.target" ];
  };
}
