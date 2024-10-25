{ inputs, ... }:

{
  # -------------------------------------------------------
  # |  Modules                                            |
  # -------------------------------------------------------

  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./nix-helper.nix
  ];

  # -------------------------------------------------------
  # |  Configuration                                      |
  # -------------------------------------------------------

  config = {
    # Allow unfree software
    nixpkgs.config.allowUnfree = true;

    # Patch ld
    programs.nix-ld.enable = true;

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
