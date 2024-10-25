{ lib, config, ... }:

let
  cfg = config.jovial.nix.nh;
in
{
  options.jovial.nix.nh = {
    enable = lib.mkEnableOption "enable nix-helper module";
    flake = lib.mkOption {
      default = "/etc/nixos";
      description = "Path to flake";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep 5 --keep-since 3d";
      flake = cfg.flake;
    };
  };
}
