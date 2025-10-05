{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }@inputs: 
  let
    inherit (self) outputs;

    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages."${system}".alejandra);

    nixosConfigurations.loki = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs; };
      system = "x86_64-linux";
      modules = [ 
        {
          # Set system hostname to match configuration name
          networking.hostName = "loki";

          # Enable flakes for the configuration
          nix.settings.experimental-features = [ "nix-command" "flakes" ];
        }
        ./configuration.nix
      ];
    };

  };
}
