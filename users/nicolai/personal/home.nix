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
    # Games
    steam
    openttd
    # Minecraft. Regular launcher is marked as broken
    lunar-client

    # IDEs
    jetbrains.pycharm-community
    jetbrains.idea-community

    # Emulator
    virtualbox
  ];

  # -------------------------------------------------------
  # |  Dotfiles and configuration                         |
  # -------------------------------------------------------

  home.file = { };

  home.sessionVariables = { };
}
