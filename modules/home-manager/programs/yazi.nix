{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.libgaard.yazi;

  enableFishIntegration = config.libgaard.fish.enable;
in {
  options.libgaard.yazi = {
    enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;

      enableBashIntegration = true;
      inherit enableFishIntegration;
    };
  };
}
