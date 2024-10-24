{ nixpkgs, inputs }:

name:
{ host ? name
, users ? [ (import ./mkuser.nix "nicolai") ]
}:

let
  hostConfig = ../hosts/${host}/configuration.nix;
  hardwareConfig = ../hosts/${host}/hardware-configuration.nix;
in
nixpkgs.lib.nixosSystem {
  specialArgs = { inherit inputs; };
  modules = [
    { nixpkgs.config.allowUnfree = true; }

    { networking.hostName = name; }

    hostConfig
    hardwareConfig

    inputs.home-manager.nixosModules.default
  ] ++ users;
}
