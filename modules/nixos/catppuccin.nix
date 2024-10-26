{ config, inputs, lib, ... }:

let
  cfg = config.jovial.catppuccin;
in
{
  options.jovial.catppuccin = {
    enable = lib.mkEnableOption "enable catppuccin styling module";
    flavor = lib.mkOption {
      description = "Catppuccin theme flavor";
      default = "mocha";
    };
    accent = lib.mkOption {
      description = "What catppucin accent to use";
      default = "rosewater";
    };
  };

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  config = lib.mkIf cfg.enable {
    catppuccin = {
      enable = true;
      flavor = cfg.flavor;
      accent = cfg.accent;
    };
  };
}
