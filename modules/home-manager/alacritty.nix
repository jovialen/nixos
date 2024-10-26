{ config, lib, pkgs, outputs, ... }:

let
  cfg = config.jovial.alacritty;
  tmuxEnabled = config.jovial.tmux.enable;
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
    };

    settings.shell = lib.mkIf tmuxEnabled {
      program = "${pkgs.tmux}/bin/tmux";
    };
  };
}
