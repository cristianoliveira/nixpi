{ pkgs }: {
  services.pihole = {
    enable = true;
  };

  # FIXME do not expose the password
  systemd.services.pihole = {
    description = "Pi-hole Docker Container";
    after = [ "network.target" "docker.service" ];
    wants = [ "docker.service" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.docker}/bin/docker run \
          --rm \
          --name pihole \
          -p 53:53/tcp \
          -p 53:53/udp \
          -p 80:80/tcp \
          -p 443:443/tcp \
          -e TZ=Europe/London \
          -e FTLCONF_webserver_api_password='guest'\
          -e FTLCONF_dns_listeningMode=all \
          -v /var/lib/pihole/etc-pihole:/etc/pihole \
          -v /var/lib/pihole/etc-dnsmasq.d:/etc/dnsmasq.d \
          --cap-add=NET_ADMIN \
          --restart=unless-stopped \
          pihole/pihole:latest
      '';
      ExecStop = "${pkgs.docker}/bin/docker stop pihole";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # Ensure Docker is installed and enabled
  virtualisation.docker.enable = true;

  # Create necessary folders
  systemd.tmpfiles.rules = [
    "d /var/lib/pihole/etc-pihole 0755 root root"
    "d /var/lib/pihole/etc-dnsmasq.d 0755 root root"
  ];

  # Open firewall ports if needed
  networking.firewall.allowedTCPPorts = [ 53 80 443 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}
