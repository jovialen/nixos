{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.libgaard.fish;

  mkPlugins = map (plugin: {
    name = "${plugin}";
    src = pkgs.fishPlugins.${plugin}.src;
  });
in {
  options.libgaard.fish = {
    enable = lib.mkEnableOption "fish";
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting  # Disable greeting

        fish_vi_key_bindings
        fish_vi_cursor
      '';

      plugins = mkPlugins [
        "z"
        "grc"
        "sponge"
        "puffer"
        "plugin-git"
        "pisces"
        "fzf-fish"
        "forgit"
        "fish-you-should-use"
        "done"
        "colored-man-pages"
        "bass"
      ];
    };

    home.packages = with pkgs; [
      grc
      fzf
      fd
      python3
    ];
  };
}
