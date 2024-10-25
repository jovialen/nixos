{ nixpkgs, inputs }:
let
  outputs = inputs.self.outputs;
in

name:
{ host ? name
, users ? [ (import ./mkuser.nix "nicolai") ]
}:

let
  hostConfig = ../hosts/${host}/configuration.nix;
  hardwareConfig = ../hosts/${host}/hardware-configuration.nix;
in
nixpkgs.lib.nixosSystem {
  specialArgs = { inherit inputs outputs; };
  modules = [
    { networking.hostName = name; }

    hostConfig
    hardwareConfig

    outputs.nixosModules.default
  ] ++ users;
}
