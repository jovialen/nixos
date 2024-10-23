{ pkgs, ... }:

{
  users.users.nicolai-ntnu = {
    isNormalUser = true;
    description = "Nicolai NTNU";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$y$j9T$c91LFsWm9vPmhQeePZ7jb1$0R/l75X.jRTZ6DcCpDnaW.MI0nKkhgZDj6mMPBWRmTD";
  };

  programs.fish.enable = true;
}
