{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.hyprland;
in
{
  config = lib.mkIf (cfg.enable && cfg.monitors.enable) {
    home.file = {
      ".config/hypr/monitors.conf" =
        if cfg.monitors.overrideConfig != null then
          {
            text = cfg.monitors.overrideConfig;
            force = true;
            mutable = true;
          }
        else
          {
            source = "${pkgs.hyde}/Configs/.config/hypr/monitors.conf";
            force = true;
            mutable = true;
          };
    };
  };
}
