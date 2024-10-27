{ config, nixConfig, lib, pkgs, ... }:

let
  cfg = config.jovial.gnome;
  nixCfg = nixConfig.jovial.gnome;

  mkExtension = extensionName: pkgs.gnomeExtensions.${extensionName}.extensionUuid;
in
{
  options.jovial.gnome = {
    extensions = lib.mkOption {
      description = "Extensions to enable";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config.dconf = lib.mkIf nixCfg.enable {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = (with pkgs.gnomeExtensions; [
        user-themes.extensionUuid
      ])
      ++ map mkExtension cfg.extensions;
    };
  };
}
