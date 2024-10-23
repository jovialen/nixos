{ lib, pkgs, ... }:

{
  # -------------------------------------------------------
  # |  User                                               |
  # -------------------------------------------------------

  home.username = "nicolai";
  home.homeDirectory = "/home/nicolai";

  # -------------------------------------------------------
  # |  Packages                                           |
  # -------------------------------------------------------

  home.packages = with pkgs; [
    firefox
    vscode
  ];

  # -------------------------------------------------------
  # |  Dotfiles and configuration                         |
  # -------------------------------------------------------

  home.file = { };

  home.sessionVariables = { };

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
