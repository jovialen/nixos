{ config, lib, ... }:

let
  cfg = config.jovial.alacritty;
in
{
  options.jovial.alacritty = {
    enable = lib.mkEnableOption "enable alacritty module";
  };

  config.programs.alacritty = lib.mkIf cfg.enable {
    enable = true;
  };
}
