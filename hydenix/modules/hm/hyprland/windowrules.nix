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
  config = lib.mkIf (cfg.enable && cfg.windowrules.enable) {
    home.file = {
      ".config/hypr/windowrules.conf" =
        if cfg.windowrules.overrideConfig != null then
          {
            text = cfg.windowrules.overrideConfig;
            force = true;
          }
        else
          {
            text = ''
              ${lib.readFile "${pkgs.hyde}/Configs/.config/hypr/windowrules.conf"}
              ${cfg.windowrules.extraConfig}
            '';
            force = true;
          };
    };
  };
}
