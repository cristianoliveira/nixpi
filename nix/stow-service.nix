{ pkgs ? import <nixpkgs> {}, ... }: let 
in {
  # Run stow on login to apply symlinks
  systemd.services.stow = {
    description = "...";

    script = ''
      ${pkgs.stow}/bin/stow -d /home/cris/nixpi/stow -t $HOME
    '';

    wantedBy = [ "multi-user.target" ]; # starts after login
  };
}
