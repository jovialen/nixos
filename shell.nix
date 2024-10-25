{pkgs ? (import ./nixpkgs.nix) {}}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      # Nix
      nix
      nixpkgs-fmt
      nixd
      home-manager
      nh

      # Git
      git
      gh

      # Editors
      vim
      neovim
    ];
  };
}