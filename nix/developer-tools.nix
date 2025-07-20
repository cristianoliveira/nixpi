{ pkgs, ... } : {

  environment.systemPackages = with pkgs; [
    # Editing
    vim
    
    # Version Control
    git

    # Core utils enhanced
    diff-so-fancy
    ripgrep
    jq
  ];
  
}
