{ pkgs, config, lib, ... }:

let
  cfg = config.jovial.plymouth;

  enableSilentBoot = cfg.enable && cfg.silentBoot;
in
{
  options.jovial.plymouth = {
    enable = lib.mkEnableOption "enable plymouth module";
    silentBoot = lib.mkOption {
      description = "Enable silent booting";
      type = lib.types.bool;
      default = true;
    };
  };

  config.boot = lib.mkIf cfg.enable {
    # Enable plymouth
    plymouth.enable = true;
  } // lib.mkIf enableSilentBoot {
    # Hide the OS choice.
    # It is still possible to open the bootloader by
    # pressing any key during boot.
    loader.timeout = 0;

    # Actually silence the boot
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}