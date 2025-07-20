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
        ./nix/developer-tools.nix

        ./nix/pihole-service.nix
      ];
    };
  };
}
