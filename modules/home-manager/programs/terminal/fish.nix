{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.libgaard.fish;

  genPlugins = map (plugin: {
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
      '';

      plugins = genPlugins [
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
        "async-prompt"
      ];
    };

    home.packages = with pkgs; [
      grc
      fzf
    ];
  };
}
