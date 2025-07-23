{
  description = "Nix flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
      system = "aarch64-linux";
      modules = [
        ./nix/configuration.nix
        ./nix/unfree.nix

        ./nix/networking.nix
        ./nix/reverse-proxy.nix

        ./nix/sysadmin.nix
        ./nix/developer-tools.nix

        ./nix/dotfiles-service.nix
        ./nix/pihole-service.nix
        ./nix/printer-service.nix
        ./nix/scanner-service.nix
      ];
    };
  };
}
