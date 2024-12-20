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
  system = "x86_64-linux";
  specialArgs = { inherit inputs outputs; };
  modules = [
    { networking.hostName = name; }
    ../systems/common.nix

    systemConfiguration
    hardwareConfiguration
    systemUserConfigurations

    outputs.nixosModules.default
  ];
}
