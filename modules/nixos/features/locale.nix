{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.libgaard.locale;

  xkbEnable = config.libgaard.gnome.enable;
in {
  options.libgaard.locale = {
    enable = lib.mkEnableOption "locale";

    locale = lib.mkOption {
      type = lib.types.str;
      default = "en_UK";
      example = "nb_NO";
      description = "Global system locale";
    };
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/Oslo";
      example = "Europe/Berlin";
      description = "System time zone";
    };

    keyMap = lib.mkOption {
      type = lib.types.str;
      default = "en";
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
    i18n = {
      defaultLocale = "${cfg.locale}.UTF-8";

      extraLocaleSettings = {
        LC_ADDRESS = "${cfg.locale}.UTF-8";
        LC_IDENTIFICATION = "${cfg.locale}.UTF-8";
        LC_MEASUREMENT = "${cfg.locale}.UTF-8";
        LC_MONETARY = "${cfg.locale}.UTF-8";
        LC_NAME = "${cfg.locale}.UTF-8";
        LC_NUMERIC = "${cfg.locale}.UTF-8";
        LC_PAPER = "${cfg.locale}.UTF-8";
        LC_TELEPHONE = "${cfg.locale}.UTF-8";
        LC_TIME = "${cfg.locale}.UTF-8";
      };
    };

    # Set your time zone.
    time.timeZone = cfg.timeZone;

    # Configure key map
    console.keyMap = cfg.keyMap;

    # Configure keymap in X11
    services.xserver.xkb = lib.mkIf xkbEnable {
      layout = cfg.keyMap;
      variant = cfg.variant;
    };
  };
}
