{
  description = "Jovialens NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    mkSystem = import ./lib/mksystem.nix { inherit nixpkgs inputs; };
  in
  {
      # ---------------------------------------------------
      # |  Systems                                        |
      # ---------------------------------------------------

      nixosConfigurations = {
        vm1 = mkSystem "vm1" "vm";
        vm2 = mkSystem "vm2" "vm";
      };

      # ---------------------------------------------------
      # |  Modules                                        |
      # --------------------------------------------------- 

      nixosModules.default = ./modules/nixos;
      homeManagerModules.default = ./modules/home-manager;
  };
}
