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
  config = lib.mkIf (cfg.enable && cfg.keybindings.enable) {
    home.file = {
      ".config/hypr/keybindings.conf" =
        if cfg.keybindings.overrideConfig != null then
          {
            text = cfg.keybindings.overrideConfig;
            force = true;
          }
        else
          {
            text = ''
              ${lib.readFile "${pkgs.hyde}/Configs/.config/hypr/keybindings.conf"}
              ${cfg.keybindings.extraConfig}
            '';
            force = true;
          };
    };
  };
}
