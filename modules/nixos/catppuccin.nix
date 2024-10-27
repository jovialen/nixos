{ config, inputs, lib, pkgs, ... }:

let
  cfg = config.jovial.catppuccin;
  preferedFont = config.jovial.nerdfonts.prefered;
  gnomeEnabled = config.jovial.gnome.enable;
in
{
  options.jovial.catppuccin = {
    enable = lib.mkEnableOption "enable catppuccin styling module";
    flavor = lib.mkOption {
      description = "Catppuccin theme flavor";
      type = lib.types.str;
      default = "Mocha";
    };
    accent = lib.mkOption {
      description = "What catppucin accent to use";
      type = lib.types.str;
      default = "Mauve";
    };
  };

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  config.catppuccin = lib.mkIf cfg.enable {
    enable = true;
    flavor = lib.strings.toLower cfg.flavor;
    accent = lib.strings.toLower cfg.accent;
  };
}
