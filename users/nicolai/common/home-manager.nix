{ pkgs, outputs, ... }:

{
  imports = [
    outputs.homeManagerModules.default
  ];

  # -------------------------------------------------------
  # |  Packages                                           |
  # -------------------------------------------------------

  home.packages = with pkgs; [
    # Utilities
    htop
    fzf
    fd
    eza
    tree
    bitwarden-cli
    gh

    # Applications
    firefox
    vscode
  ];

  # -------------------------------------------------------
  # |  Dotfiles and configuration                         |
  # -------------------------------------------------------

  home.file = { };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # -------------------------------------------------------
  # |  Home manager                                       |
  # -------------------------------------------------------

  # ! DO NOT TOUCH ! DO NOT TOUCH ! DO NOT TOUCH !

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
