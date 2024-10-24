{ nixpkgs, inputs }:

name:
{ host ? name
, users ? [ (import ./mkuser.nix "nicolai") ]
}:

let
  hostConfig = ../hosts/${host}/configuration.nix;
  hardwareConfig = ../hosts/${host}/hardware-configuration.nix;
  outputs = inputs.self.outputs;
in
nixpkgs.lib.nixosSystem {
  specialArgs = { inherit inputs; };
  modules = [
    { networking.hostName = name; }

    hostConfig
    hardwareConfig

    outputs.nixosModules.default
    outputs.homeManagerModules.default
  ] ++ users;
}
