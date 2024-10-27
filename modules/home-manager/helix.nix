{ config, lib, pkgs, ... }:

let
  cfg = config.jovial.helix;
in
{
  options.jovial.helix = {
    enable = lib.mkEnableOption "enable helix module";
  };

  config.programs.helix = lib.mkIf cfg.enable {
    enable = true;
    settings = {
      editor = {
        line-numer = "relative";
        lsp.display-messages = true;
      };
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":wq";
        esc = [ "collapse_selection" "keep_primary_selecton" ];
      };
    };
    ignores = [
      "node_modules"
      "!.gitignore"
    ];
  };
}
