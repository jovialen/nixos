{lib, ...}: {
  imports = [
    ./programs/terminal/alacritty.nix
    ./programs/terminal/fish.nix
    ./programs/terminal/starship.nix
    ./programs/terminal/tmux.nix
    ./programs/editors/helix.nix
    ./programs/git.nix
    ./programs/yazi.nix
    ./services/ssh.nix
  ];

  libgaard.ssh.enable = lib.mkDefault true;
}
