{ pkgs ? import <nixpkgs> {}, ... }: let 
  hosts = [
    { 
      subdomain = "pihole"; 
      port = "8053";
    }
  ];
in {
  services.caddy = {
    enable = true;

    # map reduce the hosts
    virtualHosts = builtins.listToAttrs(pkgs.lib.map ({ subdomain, port }: {
      name = "pihole.nixpi.lab";
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
