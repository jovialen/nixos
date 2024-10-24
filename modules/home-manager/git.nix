{ config, lib, ... }:

let
  cfg = config.jovial.git;
in
{
  options.jovial.git = {
    enable = lib.mkEnableOption "enable git module";
    name = lib.mkOption {
      description = "Name to sign the git commits with";
    };
    email = lib.mkOption {
      description = "Email to sign the git commits with";
    };
    defaultBranch = lib.mkOption {
      description = "Default git branch in new repositories";
      default = "main";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;

      userName = cfg.name;
      userEmail = cfg.email;

      extraConfig = {
        branch.autosetuprebase = "always";
        push.autoSetupRemote = true;
        color.ui = true;
        init.defaultBranch = cfg.defaultBranch;
      };
    };
  };
}
