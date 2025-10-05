{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.libgaard.opassword;
in {
  options.libgaard.opassword = {
    enable = lib.mkEnableOption "1password";
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["loki"];
      description = "Users to enable 1Password authentication for";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable the unfree 1Password packages
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "1password-gui"
        "1password"
      ];

    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      # Certain features, including CLI integration and system authentication support,
      # require enabling PolKit integration on some desktop environments (e.g. Plasma).
      polkitPolicyOwners = cfg.users;
    };

    environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          vivaldi-bin
          wavebox
        '';
        mode = "0755";
      };
    };
  };
}
