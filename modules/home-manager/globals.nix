{ config, lib, ... }:

let
  cfg = config.jovial;
in
{
  options.jovial = {
    shellAliases = lib.mkOption {
      description = "Global shell aliases";
      default = { };
    };
  };
}
