{ config, nixConfig, lib, pkgs, ... }:

let
  cfg = config.jovial.vscode;
  themeEnabled = nixConfig.jovial.catppuccin.enable;
  themeFlavor = nixConfig.jovial.catppuccin.flavor;

  themeExtensions = if themeEnabled then with pkgs.vscode-extensions.catppuccin; [ catppuccin-vsc catppuccin-vsc-icons ] else [];
in
{
  options.jovial.vscode = {
    enable = lib.mkEnableOption "enable vscode module";
    autosave = lib.mkOption {
      description = "If autosaving should be enabled";
      default = false;
    };
    autosavedelay = lib.mkOption {
      description = "Delay before autosaving";
      default = 500;
    };
  };

  config.programs.vscode = lib.mkIf cfg.enable {
    enable = true;
    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions; [
      # For Nix
      jnoortheen.nix-ide

      # Git
      eamodio.gitlens
      codezombiech.gitignore

      # Must have theming
      aaron-bond.better-comments
      johnpapa.vscode-peacock

      # Highlight errors
      usernamehw.errorlens

      # Spell check
      streetsidesoftware.code-spell-checker
    ] ++ themeExtensions;

    userSettings = {
      "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
      "nix.enableLanguageServer" = true;
      "nix.formatterPath" = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";

      "files.autoSave" = if cfg.autosave then "afterDelay" else "off";
      "files.autoSaveDelay" = cfg.autosavedelay;
    };

    userSettings."workbench.colorTheme" = lib.mkIf themeEnabled "Catppuccin ${themeFlavor}";
    userSettings."workbench.iconTheme" = lib.mkIf themeEnabled "catppuccin-${lib.strings.toLower themeFlavor}";
  };
}
