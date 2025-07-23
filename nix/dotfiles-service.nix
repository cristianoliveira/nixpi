{ pkgs ? import <nixpkgs> {}, ... }: let
  dotfilesDir = ../dotfiles; # This path is moved to the nix store
in {

  # Run dotfiles on login to apply symlinks

  systemd.services.dotfiles = {
    description = "Configuration Service";

    script = ''
      for file in $(ls -A ${dotfilesDir} | grep -v '*.sh'); do
        echo "Creating symlink for $file"
        ln -sf ${dotfilesDir}/$file $HOME/$file
      done
    '';

    wantedBy = [ "multi-user.target" ]; # starts after login
    serviceConfig = {
      User = "cris";
      Group = "users";
      Type = "simple";
      Restart = "always";
      RestartSec = "60m";
    };
  };
}
