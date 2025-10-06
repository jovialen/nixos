{lib, ...}: {
  imports = [
    ./programs/nh.nix
    ./programs/stylix.nix
    ./services/op.nix
    ./services/plymouth.nix
    ./services/ssh.nix
    ./services/networkmanager.nix
  ];

  libgaard = {
    # Tools
    nh.enable = lib.mkDefault true;
    nh.flake = lib.mkDefault "/etc/nixos";

    # Theming
    stylix.enable = lib.mkDefault true;

    # Networking
    networks.enable = lib.mkDefault true;
    networks.firewall.enable = lib.mkDefault true;
  };
}
