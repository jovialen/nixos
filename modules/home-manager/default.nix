{ inputs, ... }:

{
  imports = [
    # Enable home manager
    inputs.home-manager.nixosModules.default
  ] ++ [
    # Modules
  ];
}
