{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.libgaard.ssh;

  opEnabled = inputs.config.libgaard.opassword.enabled;
in {
  options.libgaard.ssh = {
    enable = lib.mkEnableOption "ssh";
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;

      extraConfig = ''
        Host *
            IdentityAgent ~/.1password/agent.sock
      '';
    };
  };
}
