{ pkgs, ... }: {
  ## === Printer ===
  services = { 
    printing = {
      enable = true;
      listenAddresses = [ "*:631" ];
      allowFrom = [ "all" ];
      browsing = true;
      defaultShared = true;
      openFirewall = true;
      extraConf = "ServerAlias printers.nixpi.lab";

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
