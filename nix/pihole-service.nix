{ pkgs }: {
  # Ensure Docker is installed and enabled
  virtualisation.docker.enable = true;

  # Add your user to docker group (replace 'username' with your actual username)
  # FIXME: change this to the correct user
  users.users."cris".extraGroups = [ "docker" ];

  # Optional: Disable systemd-resolved to avoid port 53 conflicts
  services.resolved.enable = false;

  virtualisation.oci-containers.containers.pihole = {
    autoStart   = true;
    image       = "pihole/pihole:latest";

    ports       = [
      "53:53/tcp"
      "53:53/udp"
      "8053:80/tcp"
    ];

    environment = {
      TZ                             = "Europe/Berlin";
      # read WEBPASS from your build‐env; you can also hard‑code or use environmentFiles
      FTLCONF_webserver_api_password = builtins.getEnv "WEBPASS";
      FTLCONF_dns_listeningMode      = "all";
    };

    volumes = [
      "/etc/pihole:/etc/pihole"
      "/etc/dnsmasq.d:/etc/dnsmasq.d"
    ];

    extraOptions = [
      "--dns=127.0.0.1"
      "--dns=1.1.1.1"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/pihole/etc-pihole 0755 root root"
    "d /var/lib/pihole/etc-dnsmasq.d 0755 root root"
  ];

  ## Cron that updates pihole with 'pihole -g' every day
  systemd.services.pihole-update = {
    description = "Update Pi-hole gravity";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.docker}/bin/docker exec pihole pihole -g";
      RemainAfterExit = true;
    };
    timerConfig = {
      OnCalendar = "*-*-* 02:00:00"; # Every day at 2 AM
      Persistent = true;
    };
  };
}
