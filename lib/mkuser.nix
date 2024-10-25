username:

{ inputs, ... }:

let
  nixUser = ../users/${username}/nixos.nix;
  homeUser = ../users/${username}/home.nix;
in
{
  imports = [
    nixUser
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.${username} = homeUser;
  };
}
