{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.libgaard.tmux;
in {
  options.libgaard.tmux = {
    enable = lib.mkEnableOption "tmux";
    baseIndex = lib.mkOption {
      type = lib.types.int;
      default = 1;
      example = 0;
      description = "What index to start indexing the windows at";
    };
    prefix = lib.mkOption {
      type = lib.types.str;
      default = "C-a";
      example = "C-b";
      description = "Prefix key to do special actions";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      inherit (cfg) baseIndex prefix;
      enable = true;
      clock24 = true;
      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
        tmux-fzf
        sensible
      ];
    };
  };
}
