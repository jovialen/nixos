{
  self,
  nixpkgs,
  home-manager,
  ...
} @ inputs: hostname: system: {users}: let
  inherit (self) outputs;

  mapAllUsers = op: nixpkgs.lib.map op users;
  forAllUsers = nixpkgs.lib.genAttrs users;

  hostConfiguration = ../hosts/${hostname}/configuration.nix;
  userConfigurations = mapAllUsers (user: ../users/${user}/nixos.nix);
  homeConfigurations = forAllUsers (user: ../users/${user}/home.nix);
in
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs outputs;};
    modules =
      [
        {
          # Set system hostname to match configuration name
          networking.hostName = "${hostname}";

          # Enable flakes for the configuration
          nix.settings.experimental-features = ["nix-command" "flakes"];
        }
        home-manager.nixosModules.default
        hostConfiguration
      ]
      # Add users
      ++ userConfigurations
      ++ [
        {
          home-manager.users = homeConfigurations;
        }
      ];
  }
