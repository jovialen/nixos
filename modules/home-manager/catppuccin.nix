{ lib, nixConfig, inputs, ... }:

let
  # Defer to the system configuration
  cfg = nixConfig.jovial.catppuccin;
in
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  config.catppuccin = lib.mkIf cfg.enable {
    enable = true;
    flavor = lib.strings.toLower cfg.flavor;
    accent = lib.strings.toLower cfg.accent;

    # Dont really like the look of the Catppuccin cursor
    pointerCursor.enable = false;
  };
}
