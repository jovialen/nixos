{lib, ...}: {
  imports = [
    ./programs/nh.nix
    ./programs/stylix.nix
    ./services/op.nix
    ./services/plymouth.nix
  ];

  libgaard = {
    nh.enable = lib.mkDefault true;
    nh.flake = lib.mkDefault "/etc/nixos";
    stylix.enable = lib.mkDefault true;
    plymouth.enable = lib.mkDefault true;
  };
}
