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

  options.hydenix.hm.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable hyprland module";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprcursor
      hyprutils
      xdg-desktop-portal-hyprland
      hyprpicker
      hypridle
    ];

    home.file = {
      ".config/hypr/hyprland.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hyprland.conf";
        force = true;
      };
      ".config/hypr/hyde.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hyde.conf";
      };
      ".config/hypr/keybindings.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/keybindings.conf";
      };
      ".config/hypr/monitors.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/monitors.conf";
      };
      ".config/hypr/nvidia.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/nvidia.conf";
      };
      ".config/hypr/userprefs.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/userprefs.conf";
      };
      ".config/hypr/windowrules.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/windowrules.conf";
      };
      ".config/hypr/animations.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations.conf";
      };
      ".config/hypr/animations/classic.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/classic.conf";
      };
      ".config/hypr/animations/diablo-1.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/diablo-1.conf";
      };
      ".config/hypr/animations/diablo-2.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/diablo-2.conf";
      };
      ".config/hypr/animations/dynamic.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/dynamic.conf";
      };
      ".config/hypr/animations/disable.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/disable.conf";
      };
      ".config/hypr/animations/eevee-1.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/eevee-1.conf";
      };
      ".config/hypr/animations/eevee-2.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/eevee-2.conf";
      };
      ".config/hypr/animations/high.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/high.conf";
      };
      ".config/hypr/animations/low-1.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/low-1.conf";
      };
      ".config/hypr/animations/low-2.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/low-2.conf";
      };
      ".config/hypr/animations/minimal-1.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/minimal-1.conf";
      };
      ".config/hypr/animations/minimal-2.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/minimal-2.conf";
      };
      ".config/hypr/animations/moving.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/moving.conf";
      };
      ".config/hypr/animations/optimized.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/optimized.conf";
      };
      ".config/hypr/animations/standard.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/standard.conf";
      };
      ".config/hypr/animations/vertical.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/vertical.conf";
      };

      ".config/hypr/hypridle.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hypridle.conf";
      };

      ".config/hypr/animations/theme.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/theme.conf";
        force = true;
        mutable = true;
      };
      ".config/hypr/themes/colors.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/themes/colors.conf";
        force = true;
        mutable = true;
      };
      ".config/hypr/themes/theme.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/themes/theme.conf";
        force = true;
        mutable = true;
      };
      ".config/hypr/themes/wallbash.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/themes/wallbash.conf";
        force = true;
        mutable = true;
      };

    };
  };
}
