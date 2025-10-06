{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.libgaard.alacritty;
in {
  options.libgaard.alacritty = {
    enable = lib.mkEnableOption "alacritty";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = lib.mkForce {
        window = {
          opacity = 0.98;
          blur = true;
        };

        mouse.hide_when_typing = true;
      };
    };
  };
}
