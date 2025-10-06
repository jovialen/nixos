{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.libgaard.gnome;
  consoleKeymap = config.console.keyMap;
in {
  options.libgaard.gnome = {
    enable = lib.mkEnableOption "gnome";

    keymap = lib.mkOption {
      type = lib.types.str;
      default = consoleKeymap;
      example = "no";
      description = "Gnome keymap";
    };
    variant = lib.mkOption {
      type = lib.types.str;
      default = "";
      example = "nodeadkeys";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = cfg.keymap;
      variant = cfg.variant;
    };
  };
}
