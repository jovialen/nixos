{ outputs, pkgs, ... }:

{
  imports = [
    outputs.nixosModules.default
  ];

  config = {
    # Packages shared between all devices
    environment.systemPackages = with pkgs; [
      git
      wget
      vim
      neovim
      neofetch
    ];

    # Disable mutable users (force to match nixos config)
    users.mutableUsers = false;

    # Modules
    jovial.nixos.catppuccin.enable = true;

    # -----------------------------------------------------
    # |  Nix configuration                                |
    # -----------------------------------------------------

    # ! DO NOT TOUCH ! DO NOT TOUCH ! DO NOT TOUCH !

    # This value determines the NixOS release from which
    # the default settings for stateful data, like file
    # locations and database versions on your system were
    # taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first
    # install of this system. Before changing this value
    # read the documentation for this option (e.g. man
    # configuration.nix or on
    # https://nixos.org/nixos/options.html).

    system.stateVersion = "24.05"; # Did you read the comment?
  };
}