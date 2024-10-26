{ config, lib, pkgs, ... }:

let
  cfg = config.jovial.tmux;

  mkPlugin = pluginName: pkgs.tmuxPlugins.${pluginName};
in
{
  options.jovial.tmux = {
    enable = lib.mkEnableOption "enable tmux module";
    shortcut = lib.mkOption {
      description = "Action key for tmux";
      type = lib.types.str;
      default = "a";
    };
    plugins = lib.mkOption {
      description = "Tmux plugins";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    mouseIntegration = lib.mkOption {
      description = "Configure tmux for use with a mouse";
      type = lib.types.bool;
      default = true;
    };
    viMode = lib.mkOption {
      description = "Configure tmux for vim compatability";
      type = lib.types.bool;
      default = true;
    };
  };

  config.programs.tmux = lib.mkIf cfg.enable {
    enable = true;
    package = pkgs.tmux;

    shortcut = cfg.shortcut;
    newSession = true;
    escapeTime = 0;
    clock24 = true;

    plugins = (map mkPlugin cfg.plugins)
      ++ lib.optional cfg.mouseIntegration pkgs.tmuxPlugins.better-mouse-mode
      ++ lib.optionals cfg.viMode (with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      vim-tmux-focus-events
    ] ++ (with pkgs.tmuxPlugins; [
      sensible
      yank
    ]));

    extraConfig = lib.strings.concatMapStrings (x: "\n" + x)
      (lib.singleton ''
        # Fix colors
        set-option -sa terminal-overrides ",xterm*:Tc"

        # Index windows and panes at 1
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        # Pane bindings
        bind h split-window -h -c "#{pane_current_path}"
        bind v split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
      ''
      ++ lib.optional cfg.viMode ''
        set-window-option -g mode-keys vi

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-selection
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      ''
      ++ lib.optional cfg.mouseIntegration ''
        set-option -g mouse on
      '');
  };
}
