{
  description = "Nix flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    utils.url = "github:numtide/flake-utils";
    # Required for making sure that Pi-hole continues running if the executing user has no active session.
    linger = {
      url = "github:mindsbackyard/linger-flake";
      inputs.flake-utils.follows = "flake-utils";
    };

    pihole = {
      url = "github:mindsbackyard/pihole-flake";

      nixpkgs.follow = "nixpkgs";
      flake-utils.follows = "flake-utils";
      linger.follows = "linger";
    };
  };
  outputs = { nixpkgs, linger, pihole, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
      system = "aarch64-linux";
      modules = [
        ./nix/configuration.nix

	linger.nixosModules."${system}".default
        pihole.nixosModules."${system}".default 
        ./nix/pihole.nix
      ];
    };
  };
}
