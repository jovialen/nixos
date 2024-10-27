{ ... }:

{
  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Enable fish since I use it as my shell
  programs.fish.enable = true;

  # GNOME
  jovial.gnome.extensions = [
    "blur-my-shell"
    "caffeine"
    "removable-drive-menu"
    "appindicator"
    "vitals"
    "just-perfection"
    "dash-to-dock"
  ];
}
