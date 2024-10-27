{ config, lib, pkgs, ... }:

let
  cfg = config.jovial.nerdfonts;
in
{
  options.jovial.nerdfonts = {
    prefered = lib.mkOption {
      description = "Prefered nerd font";
      default = "JetBrainsMono";
    };
    fonts = lib.mkOption {
      description = "What fonts to include";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config.fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = (lib.singleton cfg.prefered ++ cfg.fonts); })
  ];
}
