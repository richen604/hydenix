{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.audio;
in
{
  options.hydenix.audio = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.enable;
      description = "Enable audio module";
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
        wireplumber.enable = true;
      };
      blueman.enable = true;
    };

    environment.systemPackages = with pkgs; [
      bluez
      bluez-tools
      blueman
      pipewire
      wireplumber
      pavucontrol
      pamixer
      playerctl
    ];
  };
}
