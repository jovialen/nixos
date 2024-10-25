{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  config = {
    # Configure nix
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    # Configure home manager
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}