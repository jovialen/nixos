{
  self,
  nixpkgs,
  ...
} @ inputs: hostname: system: {users}: let
  inherit (self) outputs;

  forAllUsers = op: nixpkgs.lib.map op users;

  hostConfiguration = ../hosts/${hostname}/configuration.nix;
  userConfigurations = forAllUsers (user: ../users/${user}/nixos.nix);
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
        hostConfiguration
      ]
      ++ userConfigurations;
  }
