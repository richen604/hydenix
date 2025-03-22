{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.gaming;
in
{
  options.hydenix.hm.gaming = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable gaming module";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gamescope # Micro-compositor for Steam and other games
      mangohud # Performance monitoring overlay for games
      steam # Gaming platform and store
      lutris # Game manager for Linux
    ];

    home.file = {
      ".config/MangoHud/MangoHud.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/MangoHud/MangoHud.conf";
      };
    };
  };
}
