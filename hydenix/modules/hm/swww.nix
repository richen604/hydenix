{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.swww;
in
{
  options.hydenix.hm.swww = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable swww wallpaper daemon";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (lib.mkIf cfg.enable swww) # wallpaper daemon for wayland
    ];
  };
}
