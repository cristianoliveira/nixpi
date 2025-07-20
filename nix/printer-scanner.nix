{ pkgs, ... }: let
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

  ## === Printer ===
  services = { 
    printing = {
      enable = true;
      listenAddresses = [ "*:631" ];
      allowFrom = [ "all" ];
      browsing = true;
      defaultShared = true;
      openFirewall = true;
    };
  };

  # Define the printer configuration
  hardware.printers = {
    ensurePrinters = [
      {
        name = "MG2500-series";
        location = "Home";
        deviceUri = "usb://Canon/MG2500%20series?serial=BFC106&interface=1";
        model = "generic";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "MG2500-series";
  };
}
