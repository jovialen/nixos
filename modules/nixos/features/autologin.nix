{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.libgaard.autologin;
in {
  options.libgaard.autologin = {
    enable = lib.mkEnableOption "autologin";
    user = lib.mkOption {
      type = lib.types.str;
      example = "loki";
      description = "User to automatically log into";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable automatic login for the user.
    services.displayManager.autoLogin = {
      enable = true;
      user = cfg.user;
    };

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
  };
}
