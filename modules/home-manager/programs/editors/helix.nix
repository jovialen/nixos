{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.libgaard.helix;
in {
  options.libgaard.helix = {
    enable = lib.mkEnableOption "helix";
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
        }
        {
          name = "markdown";
          auto-format = true;
          formatter.command = "${pkgs.deno}/bin/deno fmt - --ext md";
        }
      ];
    };
  };
}
