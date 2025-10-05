{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.libgaard.ssh;
in {
  options.libgaard.ssh = {
    enable = lib.mkEnableOption "ssh";
    opasswordEnable = lib.mkEnableOption "1password integration";
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;

      extraConfig = lib.strings.optionalString cfg.opasswordEnable ''
        Host *
            IdentityAgent ~/.1password/agent.sock
      '';
    };
  };
}
