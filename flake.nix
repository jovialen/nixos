{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-25.05";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
    mkSystem = import ./lib/mksystem.nix inputs;
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages."${system}".alejandra);

    nixosConfigurations.loki = mkSystem "loki" "x86_64-linux" {
      users = ["loki"];
    };

    nixosModules.default = ./modules/nixos;
    homeManagerModules.default = ./modules/home-manager;
  };
}
