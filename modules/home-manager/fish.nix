{ config, lib, pkgs, ... }:

let
  globals = config.jovial;
  cfg = config.jovial.fish;

  mkPlugin = pluginName: { name = pluginName; src = pkgs.fishPlugins.${pluginName}.src; };
in
{
  options.jovial.fish = {
    enable = lib.mkEnableOption "enable fish module";
    plugins = lib.mkOption {
      description = "Plugins to add to fish";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      any-nix-shell
    ];

    programs.fish = {
      enable = true;

      shellAliases = globals.shellAliases;

      interactiveShellInit = ''
        # Extend nix-shell with fish
        any-nix-shell fish --info-right | source # Use fish for nix-shell

        # Keybindings
        fish_vi_key_bindings
        
        # Configure prompt
        set fish_greeting
        tide configure --auto --style=Lean --prompt_colors='True color' --show_time='24-hour format' --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Few icons' --transient=Yes
      '';

      plugins = map mkPlugin cfg.plugins;
    };
  };
}
