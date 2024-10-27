{ config, lib, pkgs, ... }:

let
  cfg = config.jovial.gnome;

  basePackages = with pkgs; [
    baobab # Disk analyser

    gnome-system-monitor
    gnome-usage

    gnome-calculator
    gnome-keyring
    seahorse # Password and key manager

    gnome-clocks
    gnome-photos
  ];

  officePackages = with pkgs; [
    geary # Email
    gnome-calendar
    gnome-contacts
    gnome-maps
    gnome-text-editor
    gnome-weather
    evince # Document viewer
  ];

  terminalPackages = with pkgs; [
    gnome-console
    gnome-terminal
  ];

  browserPackages = with pkgs; [
    epiphany
  ];

  gamePackages = with pkgs; [
    atomix
    tali
    iagno
    hitori
    totem
  ];

  mkOptionalPackage = name: lib.mkOption {
    description = "Enable gnome ${name} packages";
    type = lib.types.bool;
    default = false;
  };
in
{
  options.jovial.gnome = {
    enable = lib.mkEnableOption "enable gnome desktop module";
    basePackages = lib.mkOption {
      description = "Enable base gnome packages";
      type = lib.types.bool;
      default = true;
    };
    officePackages = mkOptionalPackage "office";
    terminalPackages = mkOptionalPackage "terminal";
    browserPackages = mkOptionalPackage "browser";
    gamePackages = mkOptionalPackage "game";
    packages = lib.mkOption {
      description = "Extra packages to add";
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable XServer for GNOME
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      excludePackages = with pkgs; [ xterm ];
    };

    # Exclude bloat packages
    environment.gnome.excludePackages = (with pkgs; [
      # Always exclude these

      cheese # Camera
      gedit
      gnome-characters
      gnome-connections
      gnome-music
      gnome-tour
      yelp
    ])
    ++ (lib.optionals (!cfg.basePackages) basePackages)
    ++ (lib.optionals (!cfg.officePackages) officePackages)
    ++ (lib.optionals (!cfg.terminalPackages) terminalPackages)
    ++ (lib.optionals (!cfg.browserPackages) browserPackages)
    ++ (lib.optionals (!cfg.gamePackages) gamePackages);

    environment.systemPackages = (with pkgs; [
      # Make sure we can kill what we need to (mohahaha!)
      xorg.xkill

      # Gnome settings is not enough!
      gnome-tweaks
      gnome-extension-manager
    ])
    ++ cfg.packages;
  };
}
