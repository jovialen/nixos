{ lib, nixConfig, inputs, ... }:

let
  # Defer to the system configuration
  cfg = nixConfig.jovial.nixos.catppuccin;
in
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  config = lib.mkIf cfg.enable {
    catppuccin = {
      enable = true;
      flavor = cfg.flavor;
      accent = cfg.accent;

      pointerCursor = {
        enable = true;
        accent = "dark";
      };
    };
  };
}
