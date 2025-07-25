{ pkgs, ... }: let
  user = "cris";
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
        "/home/${user}/.config/homeassistant:/config"
        "/run/dbus:/run/dbus:ro"
      ];

      environment = {
        TZ = "Europe/Berlin";
      };

      networks = [ "host" ];
    };
  };

  services.linkman = rec {
    targets = {
      homeassistant = "~/.config/homeassistant";
    };

    links = with targets; [
      # Home assistant
      {
        source = "/home/${user}/nixpi/homeassistant/configuration.yaml";
        target = "${homeassistant}/configuration.yaml";
      }
      {
        source = "/home/${user}/nixpi/homeassistant/scenes.yaml";
        target = "${homeassistant}/scenes.yaml";
      }
    ];
  };
}
