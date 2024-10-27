{ config, libs, pkgs, ... }:

let
  cfg = config.jovial.nerdfonts;
in
{
  options.jovial.nerdfonts = {
    prefered = lib.mkOption {
      description = "Prefered nerd font";
      type = libs.types.str;
      default = null;
    };
    fonts = lib.mkOption {
      description = "What fonts to include";
      type = libs.types.listOf libs.types.str;
      default = [ ];
    };
  };

  config.fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = (libs.optional (cfg.prefered != null) cfg.prefered ++ cfg.fonts); })
  ];
}
