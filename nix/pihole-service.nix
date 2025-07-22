{ pkgs, ... }: {
  # Ensure Docker is installed and enabled
  virtualisation.docker.enable = true;

  # Add your user to docker group (replace 'username' with your actual username)
  # FIXME: change this to the correct user
  users.users."cris".extraGroups = [ "docker" ];

  # Optional: Disable systemd-resolved to avoid port 53 conflicts
  services.resolved.enable = false;
	
  # FIXME do not expose the password
  systemd.services.pihole = {
    enable = true;

    description = "Pi-hole Docker Container";
    after = [ "network.target" "docker.service" ];
    wants = [ "docker.service" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      Environment="PATH=${pkgs.docker}/bin:$PATH";
      EnvironmentFile="/etc/pihole/environment";

      ExecStart = "/opt/pihole/scripts/start.sh";
      ExecStop = "docker stop pihole";
      ExecStopPost = "/opt/pihole/scripts/stop.sh";

      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # Create necessary folders
  systemd.tmpfiles.rules = [
    "d /var/lib/pihole/etc-pihole 0755 root root"
    "d /var/lib/pihole/etc-dnsmasq.d 0755 root root"
  ];
}
