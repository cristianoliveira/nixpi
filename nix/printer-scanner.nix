{ pkgs, ... }: let
  scannerScript = pkgs.writeShellScriptBin "scanner" ''
  #!${pkgs.runtimeShell}
  NEW_IMAGE=$HOME/inbox-scanner/scan-$(date +%Y-%m-%d-%H-%M-%S).png

  scanimage --format=png --resolution=300 --mode=color > $NEW_IMAGE
  echo "Scanned image saved to $NEW_IMAGE"
 '';
in {
  environment.systemPackages = with pkgs; [
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

      drivers = [ pkgs.gutenprint ];
    };
  };

  # Define the printer configuration
  hardware.printers = {
    ensurePrinters = [
      {
        name = "MG2500-series";
        location = "Home";
        deviceUri = "usb://Canon/MG2500%20series?serial=BFC106&interface=1";
        # HOW TO FIND THIS???
        #  - Open cups in the browser http://nixserver-ip:631
        #  - Start the process to add a printer
        #  - When selecting the driver options inspect html for the option and get the value #hackerman
        model = "gutenprint.5.3://bjc-MG2500-series/expert";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "MG2500-series";
  };
}
