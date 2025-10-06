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

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Open the firewall for SSH";
    };

    ports = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [22];
      example = [32152];
      description = "What port to run the SSH server on";
    };

    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["loki"];
      description = "Users to allow ssh authentication into";
    };
    allowPasswordAuthentication = lib.mkEnableOption "ssh password authentication";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      inherit (cfg) ports;
      enable = true;
      openFirewall = cfg.openFirewall;

      settings = {
        PasswordAuthentication = cfg.allowPasswordAuthentication;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = cfg.users;
      };
    };
  };
}
