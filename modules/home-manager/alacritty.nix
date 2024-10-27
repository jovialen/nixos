{ config, nixConfig, lib, pkgs, outputs, ... }:

let
  cfg = config.jovial.alacritty;
  tmuxEnabled = config.jovial.tmux.enable;
  preferedFont = nixConfig.jovial.nerdfonts.prefered;
in
{
  options.jovial.alacritty = {
    enable = lib.mkEnableOption "enable alacritty module";
    opacity = lib.mkOption {
      description = "Opacity of the window";
      default = 1.0;
    };
    blur = lib.mkOption {
      description = "Blur the window";
      default = false;
    };
  };

  config.programs.alacritty = lib.mkIf cfg.enable {
    enable = true;

    settings = {
      window = {
        resize_increments = true;
        opacity = cfg.opacity;
        blur = cfg.blur;
      };

      mouse.hide_when_typing = false;

      font.normal.family = lib.concatStrings [ preferedFont " Nerd Font" ];
    };

    settings.shell = lib.mkIf tmuxEnabled {
      program = "${pkgs.tmux}/bin/tmux";
    };
  };
}
