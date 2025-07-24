_: {
  # Manage dotfiles using linkman
  services.linkman = {
    enable = true;

    links = [
      { 
        source = ../dotfiles/.bashrc;
        target = "./.bashrc";
      }
      {
        source = ../dotfiles/.bash_profile;
        target = "./.bash_profile";
      }
      {
        source = ../dotfiles/.vimrc;
        target = "./.vimrc";
      }
      {
        source = ../dotfiles/.gitconfig;
        target = "./.gitconfig";
      }
      {
        source = ../dotfiles/.config/htop;
        target = "./.config/htop";
      }
    ];

    user = "cris";
    group = "users";
  };
}
