{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.lockscreen;
in
{
  options.hydenix.hm.lockscreen = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable lockscreen module";
    };

    hyprlock = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable hyprlock lockscreen";
    };

    swaylock = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable swaylock lockscreen";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (lib.mkIf cfg.hyprlock hyprlock)
      (lib.mkIf cfg.swaylock swaylock)
    ];

    home.file = {
      # Hyprlock configs
      ".config/hypr/hyprlock.conf" = lib.mkIf cfg.hyprlock ({
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hyprlock.conf";
        force = true;
      });
      ".config/hypr/hyprlock/Anurati.conf" = lib.mkIf cfg.hyprlock ({
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hyprlock/Anurati.conf";
      });
      ".config/hypr/hyprlock/Arfan on Clouds.conf" = lib.mkIf cfg.hyprlock ({
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hyprlock/Arfan on Clouds.conf";
      });
      ".config/hypr/hyprlock/IBM Plex.conf" = lib.mkIf cfg.hyprlock ({
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hyprlock/IBM Plex.conf";
      });
      ".config/hypr/hyprlock/SF Pro.conf" = lib.mkIf cfg.hyprlock ({
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hyprlock/SF Pro.conf";
      });
      ".config/hypr/hyprlock/theme.conf" = lib.mkIf cfg.hyprlock ({
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hyprlock/theme.conf";
        force = true;
      });

      # Swaylock config
      ".config/swaylock/config" = lib.mkIf cfg.swaylock ({
        source = "${pkgs.hydenix.hyde}/Configs/.config/swaylock/config";
      });
    };
  };
}
