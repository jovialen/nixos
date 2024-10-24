{ ... }:

{
  # -------------------------------------------------------
  # |  Modules                                            |
  # -------------------------------------------------------

  imports = [
    ./nix-helper.nix
  ];

  # -------------------------------------------------------
  # |  Configuration                                      |
  # -------------------------------------------------------

  config = {
    # Allow unfree software
    nixpkgs.config.allowUnfree = true;

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
