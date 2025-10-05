{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.libgaard.starship;

  enableFishIntegration = config.libgaard.fish.enable;
in {
  options.libgaard.starship = {
    enable = lib.mkEnableOption "starship";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;

      enableBashIntegration = true;
      inherit enableFishIntegration;

      enableTransience = true;
      settings = {
      };
    };
  };
}
