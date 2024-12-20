{ lib, config, nixConfig, inputs, pkgs, ... }:

let
  # Defer to the system configuration
  cfg = nixConfig.jovial.catppuccin;
  font = nixConfig.jovial.nerdfonts;
  gnomeEnabled = nixConfig.jovial.gnome.enable;
in
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  config = lib.mkIf cfg.enable {
    catppuccin = {
      enable = true;
      flavor = lib.strings.toLower cfg.flavor;
      accent = lib.strings.toLower cfg.accent;

      # Dont really like the look of the Catppuccin cursor
      pointerCursor.enable = false;
    };

    home.packages = with pkgs; [
      capitaine-cursors
    ];

    # I'll use my favorite instead
    home.pointerCursor = {
      name = "Capitaine Cursors";
      package = pkgs.capitaine-cursors;
    };

    gtk = lib.mkIf gnomeEnabled {
      enable = true;
      theme = {
        name = "Catppuccin-${lib.toLower cfg.flavor}-compact-${lib.toLower cfg.accent}-dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ (lib.toLower cfg.accent) ];
          size = "compact";
          tweaks = [ "rimless" "black" ];
          variant = lib.toLower cfg.flavor;
        };
      };
    };

    xdg.configFile = lib.mkIf gnomeEnabled {
      "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };
  };
}
