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
  };

  config = lib.mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };
}
