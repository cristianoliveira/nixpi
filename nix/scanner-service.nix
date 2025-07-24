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

  virtualisation.oci-containers = {
    containers.sane-web = {
      autoStart    = true;
      privileged   = true;
      image        = "sbs20/scanservjs:latest";
      ports        = [ "8054:8080" ];
      volumes      = [ "/var/run/dbus:/var/run/dbus" ];
    };
  };
}
