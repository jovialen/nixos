{ config, lib, ... }:

let
  cfg = config.jovial.git;
in
{
  options.jovial.git = {
    enable = lib.mkEnableOption "enable git module";
    name = lib.mkOption {
      type = lib.types.str;
      description = "Name to sign git commits with";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "Email to sign git commits with";
    };
    mainBranchName = lib.mkOption {
      type = lib.types.str;
      description = "Name of initial branch created with new repos";
      default = "main";
    };
  };

  config.programs.git = lib.mkIf cfg.enable {
    enable = true;
    lfs.enable = true;

    userName = cfg.name;
    userEmail = cfg.email;

    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };

    extraConfig = {
      branch.autosetuprebase = "always";
      push.autoSetupRemote = true;

      color.ui = true;

      init.defaultBranch = cfg.mainBranchName;
    };
  };
}
