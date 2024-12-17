{ config, lib, pkgs, ... }:

let
  cfg = config.jovial.helix;
in
{
  options.jovial.helix = {
    enable = lib.mkEnableOption "enable helix module";
  };

  config.programs.helix = lib.mkIf cfg.enable {
    enable = true;
    settings = {
    };
    ignores = [
      "node_modules"
      "build"
      "bin"
      "!.gitignore"
    ];
  };
}
