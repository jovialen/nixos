{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.libgaard.nh;
in {
  options.libgaard.nh = {
    enable = lib.mkEnableOption "nix helper";
    flake = lib.mkOption {
      type = lib.types.path;
      example = /home/user/.config/nixos;
      description = "Path to OS flake";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      inherit (cfg) flake;
    };
  };
}
