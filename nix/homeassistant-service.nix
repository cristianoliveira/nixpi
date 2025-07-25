let
  user = "cris";

  targets = {
    home_config = "/home/${user}/.config";
  };
in {
  users.users."${user}".extraGroups = [ "docker" ];

  virtualisation.docker.enable = true;
  virtualisation.oci-containers = {
    backend = "docker";

    containers.homeassistant = {
      autoStart  = true;
      privileged = true;

      image = "ghcr.io/home-assistant/home-assistant:stable";
      volumes = [
        "${targets.home_config}/homeassistant:/config"
        "/run/dbus:/run/dbus:ro"
      ];

      environment = {
        TZ = "Europe/Berlin";
      };

      networks = [ "host" ];
    };
  };

  services.linkman = rec {
    copies = with targets; [
      # Home assistant
      {
        source = "/home/${user}/nixpi/homeassistant";
        target = "${home_config}";
        recursive = true;
      }
    ];
  };
}
