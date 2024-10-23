{ nixpkgs, inputs }:

host:
{ users ? [ (import ./mkuser.nix "nicolai") ]
}:

let
  hostConfig = ../hosts/${host}/configuration.nix;
  hardwareConfig = ../hosts/${host}/hardware-configuration.nix;
in
nixpkgs.lib.nixosSystem {
  specialArgs = { inherit inputs; };
  modules = [
    { nixpkgs.config.allowUnfree = true; }

    hostConfig
    hardwareConfig

    inputs.home-manager.nixosModules.default
  ] ++ users;
}
