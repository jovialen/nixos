{ ... }:

{
  imports = [
    ./globals.nix

    ./desktops/gnome.nix

    ./alacritty.nix
    ./catppuccin.nix
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./tmux.nix
    ./vscode.nix
  ];
}
