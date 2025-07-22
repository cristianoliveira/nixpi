{ pkgs, ... } : {
  environment.systemPackages = with pkgs; [
    htop # For checking system health

    lsof # Checking port bindings
  ];
}
