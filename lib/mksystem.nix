{ nixpkgs, inputs }:

name:
{ host ? "vm"
, users ? { nicolai = import ../users/nicolai/personal.nix; }
, hardware ? { }
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
    hardware

    inputs.home-manager.nixosModules.default
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
        users = users;
      };
    }
  ];
}
