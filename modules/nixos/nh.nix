{ config, lib, ... }:

let
  cfg = config.jovial.nh;
in
{
  options.jovial.nh = {
    enable = lib.mkEnableOption "enable nix-helper module";
    flake = lib.mkOption {
      description = "absolute path to flake";
      default = ./../..;
    };
  };

  config.programs.nh = lib.mkIf cfg.enable {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = cfg.flake;
  };
}
