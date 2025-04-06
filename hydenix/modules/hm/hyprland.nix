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

    home.activation.createHyprConfigs = lib.hm.dag.entryAfter [ "mutableGeneration" ] ''
      mkdir -p "$HOME/.config/hypr/animations"
      mkdir -p "$HOME/.config/hypr/themes"

      touch "$HOME/.config/hypr/animations/theme.conf"
      touch "$HOME/.config/hypr/themes/colors.conf"
      touch "$HOME/.config/hypr/themes/theme.conf"
      touch "$HOME/.config/hypr/themes/wallbash.conf"

      chmod 644 "$HOME/.config/hypr/animations/theme.conf"
      chmod 644 "$HOME/.config/hypr/themes/colors.conf"
      chmod 644 "$HOME/.config/hypr/themes/theme.conf"
      chmod 644 "$HOME/.config/hypr/themes/wallbash.conf"
    '';

    home.file = {
      ".config/hypr/hyprland.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hyprland.conf";
        force = true;
      };
      ".config/hypr/hyde.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hyde.conf";
      };
      ".config/hypr/keybindings.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/keybindings.conf";
      };
      ".config/hypr/monitors.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/monitors.conf";
      };
      ".config/hypr/nvidia.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/nvidia.conf";
      };
      ".config/hypr/userprefs.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/userprefs.conf";
      };
      ".config/hypr/windowrules.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/windowrules.conf";
      };
      ".config/hypr/animations.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations.conf";
      };
      ".config/hypr/animations/classic.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/classic.conf";
      };
      ".config/hypr/animations/diablo-1.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/diablo-1.conf";
      };
      ".config/hypr/animations/diablo-2.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/diablo-2.conf";
      };
      ".config/hypr/animations/dynamic.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/dynamic.conf";
      };
      ".config/hypr/animations/disable.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/disable.conf";
      };
      ".config/hypr/animations/eevee-1.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/eevee-1.conf";
      };
      ".config/hypr/animations/eevee-2.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/eevee-2.conf";
      };
      ".config/hypr/animations/high.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/high.conf";
      };
      ".config/hypr/animations/low-1.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/low-1.conf";
      };
      ".config/hypr/animations/low-2.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/low-2.conf";
      };
      ".config/hypr/animations/minimal-1.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/minimal-1.conf";
      };
      ".config/hypr/animations/minimal-2.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/minimal-2.conf";
      };
      ".config/hypr/animations/moving.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/moving.conf";
      };
      ".config/hypr/animations/optimized.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/optimized.conf";
      };
      ".config/hypr/animations/standard.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/standard.conf";
      };
      ".config/hypr/animations/vertical.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/vertical.conf";
      };

      ".config/hypr/hypridle.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/hypridle.conf";
      };

    };
  };
}
