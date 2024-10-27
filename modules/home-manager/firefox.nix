{ inputs, config, lib, pkgs, ... }:

let
  cfg = config.jovial.firefox;

  mkExtension = extensionName: inputs.firefox-addons.packages."x86_64-linux".${extensionName};
in
{
  options.jovial.firefox = {
    enable = lib.mkEnableOption "enable firefox module";
    extensions = lib.mkOption {
      description = "Firefox extensions";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    searchEngine = lib.mkOption {
      description = "What search engine to use";
      type = lib.types.str;
      default = "DuckDuckGo";
    };
  };

  config.programs.firefox = lib.mkIf cfg.enable {
    enable = true;

    profiles.default = {
      isDefault = true;

      search = {
        default = cfg.searchEngine;
        privateDefault = cfg.searchEngine;
        force = true;

        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
        };
      };

      settings = {
        "dom.security.https_only_mode" = true;
      };

      extensions = (map mkExtension cfg.extensions);
    };
  };
}
