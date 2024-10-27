{ config, inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ] ++ [
    ./catppuccin.nix
    ./nerdfonts.nix
    ./nh.nix
    ./plymouth.nix
  ];

  config = {
    # Configure nix
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    # Configure home manager
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      sharedModules = [
        outputs.homeManagerModules.default
      ];
      extraSpecialArgs = { inherit inputs outputs; nixConfig = config; };
    };
  };
}
