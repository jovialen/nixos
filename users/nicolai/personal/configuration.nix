{ pkgs, ... }:

{
  imports = [
    ../common/nixos.nix
  ];

  users.users.nicolai = {
    isNormalUser = true;
    description = "Nicolai";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$6$RUYNH2/.zKvsbMj2$sTGtNYcWRAkb7Pk5fHca3uAe4KOkhxHORcsTbiGmKyVC/W/8WisTZ9E61EwbK93YkcMr1ebAluiXl463zFWqQ.";
  };

  home-manager.users.nicolai = ./home.nix;
}
