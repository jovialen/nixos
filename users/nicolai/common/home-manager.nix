{ nixConfig, pkgs, outputs, ... }:

{
  # -------------------------------------------------------
  # |  Modules                                            |
  # -------------------------------------------------------

  # Development
  jovial.git.enable = true;
  jovial.git.name = "Nicolai Frigaard";

  jovial.vscode.enable = true;
  jovial.vscode.autosave = true;

  # Terminal and console
  jovial.alacritty = {
    enable = true;
    opacity = 0.95;
    blur = true;
  };

  jovial.fish.enable = true;
  jovial.fish.plugins = [
    "plugin-git"
    "puffer"
    "done"
    "colored-man-pages"
    "fish-you-should-use"
    "autopair"
    "tide"
    "bass"
  ];

  jovial.shellAliases = {
    nsh = "nix-shell";
    nedit = "nix-shell ${nixConfig.jovial.nh.flake}";
    nos = "nh os switch -a";
  };

  jovial.tmux.enable = true;
  jovial.tmux.plugins = [
  ];

  programs.zoxide.enable = true;
  programs.zoxide.options = [ "--cmd cd" ];

  # -------------------------------------------------------
  # |  Packages                                           |
  # -------------------------------------------------------

  home.packages = with pkgs; [
    # Utilities
    bitwarden-cli
    gh

    # Applications
    firefox
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
