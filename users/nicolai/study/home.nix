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
  # |  Modules                                            |
  # -------------------------------------------------------

  jovial.git.email = "nicolfri@stud.ntno.no";
  jovial.git.mainBranchName = "master";

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
