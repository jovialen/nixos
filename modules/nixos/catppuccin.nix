{ config, inputs, lib, ... }:

let
  cfg = config.jovial.catppuccin;
in
{
  options.jovial.catppuccin = {
    enable = lib.mkEnableOption "enable catppuccin styling module";
    flavor = lib.mkOption {
      description = "Catppuccin theme flavor";
      type = lib.types.str;
      default = "mocha";
    };
    accent = lib.mkOption {
      description = "What catppucin accent to use";
      type = lib.types.str;
      default = "mauve";
    };
  };

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  config.catppuccin = lib.mkIf cfg.enable {
    enable = true;
    flavor = cfg.flavor;
    accent = cfg.accent;
  };
}
