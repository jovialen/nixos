{lib, ...}: {
  imports = [
    ./programs/nh.nix
    ./programs/stylix.nix
    ./services/op.nix
    ./services/plymouth.nix
    ./services/ssh.nix
  ];

  libgaard = {
    nh.enable = lib.mkDefault true;
    nh.flake = lib.mkDefault "/etc/nixos";
    stylix.enable = lib.mkDefault true;
  };
}
