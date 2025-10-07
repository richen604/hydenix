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
  config = lib.mkIf (cfg.enable && cfg.hypridle.enable) {
    home.file = {
      ".config/hypr/hypridle.conf" =
        if cfg.hypridle.overrideConfig != null then
          {
            text = cfg.hypridle.overrideConfig;
            force = true;
          }
        else
          {
            text = ''
              ${lib.readFile "${pkgs.hyde}/Configs/.config/hypr/hypridle.conf"}
              ${cfg.hypridle.extraConfig}
            '';
            force = true;
          };
    };
  };
}
