{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hardware;
in
{
  options.hydenix.hardware = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.enable;
      description = "Enable hardware module";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [

      brightnessctl # screen brightness control
      udiskie # manage removable media
      ntfs3g # ntfs support
      exfat # exFAT support
      libinput-gestures # actions touchpad gestures using libinput
      libinput # libinput library
      lm_sensors # system sensors
      pciutils # pci utils
    ];
  };
}
