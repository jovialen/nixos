{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.libgaard.printing;
in {
  options.libgaard.printing = {
    enable = lib.mkEnableOption "printing";
  };

  config = lib.mkIf cfg.enable {
    services.printing.enable = true;
  };
}
