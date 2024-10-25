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
    hashedPassword = "$y$j9T$c91LFsWm9vPmhQeePZ7jb1$0R/l75X.jRTZ6DcCpDnaW.MI0nKkhgZDj6mMPBWRmTD";
  };

  home-manager.users.nicolai = ./home.nix;
}
