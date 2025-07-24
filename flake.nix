{
  description = "Nix flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    utils.url = "github:numtide/flake-utils";
    linkman = {
      url = "github:cristianoliveira/nix-linkman";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, linkman, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        # Linkman
        linkman.nixosModules.linkman

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
      ];
    };
  };
}
