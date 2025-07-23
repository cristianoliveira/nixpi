{
  description = "Nix flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        # System
        ./nix/configuration.nix
        ./nix/networking.nix

        # Packages
        ./nix/unfree.nix
        ./nix/sysadmin.nix
        ./nix/developer-tools.nix

        # Services
        ./nix/reverse-proxy.nix
        ./nix/dotfiles-service.nix
        ./nix/pihole-service.nix
        ./nix/printer-service.nix
        ./nix/scanner-service.nix
        # Share home storage via NFS
        ./nix/nfs-share.nix
      ];
    };
  };
}
