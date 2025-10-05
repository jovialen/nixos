{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.libgaard.stylix;
in {
  options.libgaard.stylix = {
    enable = lib.mkEnableOption "stylix";
    theme = lib.mkOption {
      type = lib.types.str;
      default = "gruvbox-dark-medium";
      example = "gruvbox-dark-soft";
      description = "Name of the theme to apply";
    };
    wallpaper = lib.mkOption {
      type = lib.types.str;
      default = "gruvbox_nixos.png";
      description = "Filename of the wallpaper to use";
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.theme}.yaml";
      image = ../../../assets/wallpapers/${cfg.wallpaper};
      polarity = "dark";

      cursor = {
        name = "Capitaine Cursors (Gruvbox)";
        package = pkgs.capitaine-cursors-themed;
        size = 10;
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };

        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = config.stylix.fonts.monospace;
      };
    };
  };
}
