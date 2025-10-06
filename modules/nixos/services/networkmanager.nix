{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.libgaard.networks;
in {
  options.libgaard.networks = {
    enable = lib.mkEnableOption "networkmanager";
    wireless.enable = lib.mkEnableOption "wireless";
    powersave = lib.mkEnableOption "wifi power saver";

    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["loki"];
      description = "Users to add to the networkmanager group";
    };

    dns = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["9.9.9.9"];
      example = ["8.8.8.8"];
      description = "Domain name servers to use";
    };

    firewall = {
      enable = lib.mkEnableOption "firewall";
    };
  };

  config = lib.mkIf cfg.enable {
    networking = {
      # Enable networking
      networkmanager.enable = true;
      wireless.enable = cfg.wireless.enable;

      # Firewall
      firewall.enable = cfg.firewall.enable;

      # Save power
      networkmanager.wifi.powersave = cfg.powersave;

      # Configure dns
      networkmanager.dns = "none";

      useDHCP = false;
      dhcpcd.enable = false;

      nameservers = cfg.dns;
    };

    users.users = lib.genAttrs cfg.users (user: {extraGroups = ["networkmanager"];});
  };
}
