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
      mkUser = import ./lib/mkuser.nix;
    in
    {
      nixosConfigurations = {
        vm = mkSystem "vm" { };
        vm2 = mkSystem "vm" {
          users = [
            (mkUser "nicolai")
            (mkUser "nicolai-ntnu")
          ];
        };
      };
    };
}
