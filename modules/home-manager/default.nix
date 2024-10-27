{ ... }:

{
  imports = [
    ./globals.nix

    ./desktops/gnome.nix

    ./alacritty.nix
    ./catppuccin.nix
    ./fish.nix
    ./git.nix
    ./tmux.nix
    ./vscode.nix
  ];
}
