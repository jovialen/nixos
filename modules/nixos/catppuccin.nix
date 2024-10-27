{ config, inputs, lib, pkgs, ... }:

let
  cfg = config.jovial.catppuccin;
  preferedFont = config.jovial.nerdfonts.prefered;
  gnomeEnabled = config.jovial.gnome.enable;
in
{
  options.jovial.catppuccin = {
    enable = lib.mkEnableOption "enable catppuccin styling module";
    flavor = lib.mkOption {
      description = "Catppuccin theme flavor";
      type = lib.types.str;
      default = "Mocha";
    };
    accent = lib.mkOption {
      description = "What catppucin accent to use";
      type = lib.types.str;
      default = "Mauve";
    };
  };

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  config = lib.mkIf cfg.enable {
    environment.systemPackages = (lib.optional gnomeEnabled
      (
        pkgs.catppuccin-sddm.override {
          flavor = lib.toLower cfg.flavor;
          font = "Noto Sans";
          fontSize = "9";
          loginBackground = false;
        }
      )
    );

    catppuccin = {
      enable = true;
      flavor = lib.strings.toLower cfg.flavor;
      accent = lib.strings.toLower cfg.accent;
    };

    services.displayManager.sddm = lib.mkIf gnomeEnabled {
      theme = "catppuccin-${lib.toLower cfg.flavor}";
    };
  };
}
