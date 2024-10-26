{ pkgs, ... }:

{
  imports = [
    ../common/home-manager.nix
  ];

  # -------------------------------------------------------
  # |  User                                               |
  # -------------------------------------------------------

  home.username = "nicolai";
  home.homeDirectory = "/home/nicolai";

  # -------------------------------------------------------
  # |  Modules                                            |
  # -------------------------------------------------------

  jovial.git.email = "nicolai.frigaard@gmail.com";

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
