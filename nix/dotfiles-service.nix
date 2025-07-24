_: let
  targets = {
    "home" = "~/";
    "home_config" = "~/.config";
  };
 in {
  # Manage dotfiles using linkman
  services.linkman = rec {
    enable = true;

    inherit targets;

    links = [
      { 
        source = ../dotfiles/.bashrc;
        target = "${targets.home}.bashrc";
      }
      {
        source = ../dotfiles/.bash_profile;
        target = "${targets.home}.bash_profile";
      }
      {
        source = ../dotfiles/.vimrc;
        target = "${targets.home}.vimrc"; 
      }
      {
        source = ../dotfiles/.gitconfig;
        target = "${targets.home}.gitconfig"; 
      }
      {
        source = ../dotfiles/.config/htop;
        target = "${targets.home_config}/htop";
      }
    ];

    user = "cris";
    group = "users";
  };
}
