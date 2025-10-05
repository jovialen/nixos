{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.libgaard.ssh.server;
in {
  options.libgaard.ssh.server = {
    enable = lib.mkEnableOption "ssh";
    ports = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [22];
      example = [32152];
      description = "What port to run the SSH server on";
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      inherit (cfg) ports;
      enable = true;

      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = ["myUser"];
      };
    };
  };
}
