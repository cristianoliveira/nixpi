{
  description = "Nix flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, utils, ... }: 
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
          inherit system;
          modules = [
            ./nix/configuration.nix
          ];
        };
      });
}
