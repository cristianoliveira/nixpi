{ pkgs, ... }: {
  # Ensure Docker is installed and enabled
  virtualisation.docker.enable = true;

  # Add your user to docker group (replace 'username' with your actual username)
  # FIXME: change this to the correct user
  users.users."cris".extraGroups = [ "docker" ];

  # FIXME do not expose the password
  systemd.services.homeassist = {
    enable = true;

    description = "Home assistant service";
    after = [ "network.target" "docker.service" ];
    wants = [ "docker.service" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      Environment="PATH=${pkgs.docker}/bin:$PATH";

      ExecStart = "/home/cris/homeassitant/service.sh";
      ExecStop = "docker stop homeassist";
      ExecStopPost = "docker rm homeassist";

      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
