{ nixpkgs, inputs }:
let
  outputs = inputs.self.outputs;
in

name:
system:

let
  systemConfiguration = ../systems/${system}/configuration.nix;
  hardwareConfiguration = ../systems/${system}/hardware-configuration.nix;
  systemUserConfigurations = ../systems/${system}/users.nix;
in
nixpkgs.lib.nixosSystem {
  specialArgs = { inherit inputs outputs; };
  modules = [
    { networking.hostName = name; }

    systemConfiguration
    hardwareConfiguration
    systemUserConfigurations

    outputs.nixosModules.default
  ];
}
