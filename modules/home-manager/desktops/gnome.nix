{ nixConfig, lib, pkgs, ... }:

let
  nixCfg = nixConfig.jovial.gnome;

  defaultExtensions = [
    "user-themes"
  ];

  mkExtension = extensionName: pkgs.gnomeExtensions.${extensionName}.extensionUuid;
in
{
  config.dconf = lib.mkIf nixCfg.enable {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = (map mkExtension defaultExtensions)
        ++ (map mkExtension nixCfg.extensions);
    };
  };
}
