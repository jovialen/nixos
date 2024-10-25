{ config, inputs, lib, ... }:

let
  cfg = config.jovial.nixos.catppuccin;
in
{
  options.jovial.nixos.catppuccin = {
    enable = lib.mkEnableOption "enable catppuccin styling module";
  };

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  config.catppuccin = lib.mkIf cfg.enable {
    enable = true;
    flavor = "mocha";
  };
}