username:
{ profile ? "."
}:

{ inputs, ... }:

let
  nixUser = ../users/${username}/${profile}/nixos.nix;
  homeUser = ../users/${username}/${profile}/home.nix;
in
{
  imports = [
    nixUser
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.${username} = import homeUser;
  };
}
