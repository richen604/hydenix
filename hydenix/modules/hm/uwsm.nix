{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.uwsm;
in
{
  options.hydenix.hm.uwsm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable uwsm module";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/uwsm/env" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/uwsm/env";
      };
      ".config/uwsm/env.d/00-hyde.sh" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/uwsm/env.d/00-hyde.sh";
      };
      ".config/uwsm/env.d/01-gpu.sh" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/uwsm/env.d/01-gpu.sh";
      };
      ".config/uwsm/env-hyprland" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/uwsm/env-hyprland";
      };
      ".config/uwsm/env-hyprland.d/00-hyde.sh" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/uwsm/env-hyprland.d/00-hyde.sh";
      };
    };
  };
}
