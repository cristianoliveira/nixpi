{ pkgs ? import <nixpkgs> {}, ... }: {

  # Run stow on login to apply symlinks

  systemd.services.stow = {
    description = "Stow Configuration Service";

    script = ''
>>>>>>> 03e0797 (fix: correct stow command)
    '';

    wantedBy = [ "multi-user.target" ]; # starts after login
  };
}
