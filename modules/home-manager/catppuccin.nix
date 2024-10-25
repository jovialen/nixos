{ config, inputs, lib, ... }:

{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];
}