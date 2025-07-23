{ pkgs ? import <nixpkgs> {}, ... }: {

  # Run stow on login to apply symlinks

  systemd.services.stow = {
    description = "Stow Configuration Service";

    script = ''
      ${pkgs.stow}/bin/stow -d /home/cris/nixpi/stow -t /home/cris
    '';

    wantedBy = [ "multi-user.target" ]; # starts after login
  };
}
