{ config, nixConfig, lib, pkgs, outputs, ... }:

let
  cfg = config.jovial.alacritty;
  tmuxEnabled = config.jovial.tmux.enable;
  preferedFont = nixConfig.jovial.nerdfonts.prefered;
in
{
  options.jovial.alacritty = {
    enable = lib.mkEnableOption "enable alacritty module";
  };

  config.programs.alacritty = lib.mkIf cfg.enable {
    enable = true;

    settings = {
      window.resize_increments = true;
      mouse.hide_when_typing = true;

      font.normal.family = lib.concatStrings [ preferedFont " Nerd Font" ];
    };

    settings.shell = lib.mkIf tmuxEnabled {
      program = "${pkgs.tmux}/bin/tmux";
    };
  };
}
