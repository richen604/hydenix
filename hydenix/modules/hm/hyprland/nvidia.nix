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
  config = lib.mkIf (cfg.enable && cfg.nvidia.enable) {
    home.file = {
      ".config/hypr/nvidia.conf" =
        if cfg.nvidia.overrideConfig != null then
          {
            text = cfg.nvidia.overrideConfig;
            force = true;
          }
        else
          {
            text = ''
              ${lib.readFile "${pkgs.hydenix.hyde}/Configs/.config/hypr/nvidia.conf"}
              ${cfg.nvidia.extraConfig}
            '';
            force = true;
          };
    };
  };
}
