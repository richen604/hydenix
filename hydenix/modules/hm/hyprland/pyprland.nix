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
  config = lib.mkIf (cfg.enable && cfg.pyprland.enable) {
    home.file = {
      ".config/hypr/pyprland.toml" =
        if cfg.pyprland.overrideConfig != null then
          {
            text = cfg.pyprland.overrideConfig;
            force = true;
          }
        else
          {
            text = ''
              ${lib.readFile "${pkgs.hyde}/Configs/.config/hypr/pyprland.toml"}
              ${cfg.pyprland.extraConfig}
            '';
            force = true;
          };
    };
  };
}
