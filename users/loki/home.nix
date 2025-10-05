{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./../../modules/home-manager
  ];

  home.username = "loki";
  home.homeDirectory = "/home/loki";

  # Terminal
  libgaard.alacritty.enable = true;
  libgaard.fish.enable = true;
  libgaard.starship.enable = true;
  libgaard.tmux.enable = true;

  # Git
  libgaard.git.enable = true;

  # Packages
  home.packages = with pkgs; [
    cowsay
  ];

  home.file = {};

  # Environment variables
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
