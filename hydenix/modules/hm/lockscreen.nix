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

    home.file = lib.mkMerge [
      # Hyprlock configs
      (lib.mkIf cfg.hyprlock {
        ".config/hypr/hyprlock.conf" = {
          source = "${pkgs.hyde}/Configs/.config/hypr/hyprlock.conf";
        };
        ".config/hypr/hyprlock/theme.conf" = {
          source = "${pkgs.hyde}/Configs/.config/hypr/hyprlock/theme.conf";
          mutable = true;
          force = true;
        };
        ".config/hypr/hyprlock/greetd-wallbash.conf" = {
          source = "${pkgs.hyde}/Configs/.config/hypr/hyprlock/greetd-wallbash.conf";
          mutable = true;
          force = true;
        };
        ".config/hypr/hyprlock/Anurati.conf" = {
          source = "${pkgs.hyde}/Configs/.config/hypr/hyprlock/Anurati.conf";
        };
        ".config/hypr/hyprlock/Arfan on Clouds.conf" = {
          source = "${pkgs.hyde}/Configs/.config/hypr/hyprlock/Arfan on Clouds.conf";
        };
        ".config/hypr/hyprlock/IBM Plex.conf" = {
          source = "${pkgs.hyde}/Configs/.config/hypr/hyprlock/IBM Plex.conf";
        };
        ".config/hypr/hyprlock/SF Pro.conf" = {
          source = "${pkgs.hyde}/Configs/.config/hypr/hyprlock/SF Pro.conf";
        };
        ".config/hypr/hyprlock/IBM Xtented.conf" = {
          source = "${pkgs.hyde}/Configs/.config/hypr/hyprlock/IBM Xtented.conf";
        };
        ".config/hypr/hyprlock/greetd.conf" = {
          source = "${pkgs.hyde}/Configs/.config/hypr/hyprlock/greetd.conf";
        };
        ".config/hypr/hyprlock/HyDE.conf" = {
          source = "${pkgs.hyde}/Configs/.config/hypr/hyprlock/HyDE.conf";
        };
      })

      # Swaylock config
      (lib.mkIf cfg.swaylock {
        ".config/swaylock/config" = {
          source = "${pkgs.hyde}/Configs/.config/swaylock/config";
        };
      })
    ];
  };
}
