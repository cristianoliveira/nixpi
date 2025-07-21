# Allow a selected list of unfree packages 
{ lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkgs: builtins.elem (lib.getName pkgs) [
    # ./nix/printer-scanner.nix
    "canon-cups-ufr2"
    "gutenprint"
  ];
}
