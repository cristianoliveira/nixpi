{ pkgs ? import <nixpkgs> {}, ... }: let 
  hosts = [
    { 
      subdomain = "pihole"; 
      port = "8053";
    }
    { 
      subdomain = "printers"; 
      port = "631";
    }
    { 
      subdomain = "scanner"; 
      port = "8054";
    }
    { 
      subdomain = "ha"; 
      port = "8123";
    }
  ];
in {
  services.caddy = {
    enable = true;

    # map reduce the hosts
    virtualHosts = builtins.listToAttrs(pkgs.lib.map ({ subdomain, port }: {
      name = "${subdomain}.nixpi.lab";
      value = {
        useACMEHost = null;  # disables Let's Encrypt/ACME
        
        extraConfig = ''
          tls internal

          reverse_proxy 127.0.0.1:${port}
        '';
      };
    }) hosts);
  };
}
