{ pkgs, ... }:

{
  imports = [
    ../common/home-manager.nix
  ];

  # -------------------------------------------------------
  # |  User                                               |
  # -------------------------------------------------------

  home.username = "nicolai-ntnu";
  home.homeDirectory = "/home/nicolai-ntnu";

  # -------------------------------------------------------
  # |  Packages                                           |
  # -------------------------------------------------------

  home.packages = with pkgs; [
  ];

  # -------------------------------------------------------
  # |  Dotfiles and configuration                         |
  # -------------------------------------------------------

  home.file = { };

  home.sessionVariables = { };
}
