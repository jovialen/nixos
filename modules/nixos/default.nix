{ config, inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ] ++ [
    ./desktops/gnome.nix

    ./catppuccin.nix
    ./nerdfonts.nix
    ./nh.nix
    ./plymouth.nix
  ];

  config = {
    # Configure nix
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    programs.nix-ld.enable = true;
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
