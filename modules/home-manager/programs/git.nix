{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.libgaard.git;
in {
  options.libgaard.git = {
    enable = lib.mkEnableOption "git";
    name = lib.mkOption {
      type = lib.types.str;
      default = "Nicolai Frigaard";
      example = "John Doe";
      description = "Name to sign commits with";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "46283121+jovialen@users.noreply.github.com";
      example = "john.doe@example.com";
      description = "Email to sign commits with";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userEmail = cfg.email;
      userName = cfg.name;
      delta.enable = true;
      lfs.enable = true;
      extraConfig.init.defaultBranch = "main";
    };
  };
}
