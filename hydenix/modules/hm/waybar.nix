{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.waybar;
in
{
  options.hydenix.hm.waybar = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable bar module";
    };

    waybar = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable waybar";
      };
    };

    userStyle = lib.mkOption {
      type = lib.types.lines;
      default = "";
      example = ''
        /* Custom waybar styles */
        window#waybar {
          background-color: rgba(0, 0, 0, 0.8);
        }
      '';
      description = "Custom CSS styles for waybar user-style.css";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      lib.optionals cfg.waybar.enable [
        waybar # system bar
        playerctl # media player cli
        gobject-introspection # for python packages
        (python3.withPackages (ps: with ps; [ pygobject3 ])) # python with pygobject3
        python-pyamdgpuinfo # AMD GPU information library
        lm_sensors # sensors information library
        power-profiles-daemon # power profiles daemon
      ];

    home.file = {

      # Modules for waybar
      # Note: some of these may not work for NixOS
      # TODO: review waybar modules for nix compatibility
      ".config/waybar/modules" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules";
        recursive = true;
      };
      ".config/waybar/layouts" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/layouts";
        recursive = true;
      };
      ".config/waybar/menus" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/menus";
        recursive = true;
      };
      ".config/waybar/styles" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/styles";
        recursive = true;
      };
      ".config/waybar/includes/border-radius.css" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/includes/border-radius.css";
        force = true;
        mutable = true;
      };
      ".config/waybar/includes/global.css" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/includes/global.css";
        force = true;
        mutable = true;
      };
      ".config/waybar/includes/includes.json" = {
        text = ''
          {
            "include": [
                "${config.xdg.configHome}/waybar/modules/backlight.jsonc",
                "${config.xdg.configHome}/waybar/modules/battery.jsonc",
                "${config.xdg.configHome}/waybar/modules/bluetooth.jsonc",
                "${config.xdg.configHome}/waybar/modules/cava.jsonc",
                "${config.xdg.configHome}/waybar/modules/cliphist.jsonc",
                "${config.xdg.configHome}/waybar/modules/clock##alt.jsonc",
                "${config.xdg.configHome}/waybar/modules/clock.jsonc",
                "${config.xdg.configHome}/waybar/modules/cpu.jsonc",
                "${config.xdg.configHome}/waybar/modules/cpuinfo.jsonc",
                "${config.xdg.configHome}/waybar/modules/display.jsonc",
                "${config.xdg.configHome}/waybar/modules/footer.jsonc",
                "${config.xdg.configHome}/waybar/modules/github_hyde.jsonc",
                "${config.xdg.configHome}/waybar/modules/github_hyprdots.jsonc",
                "${config.xdg.configHome}/waybar/modules/gpuinfo.jsonc",
                "${config.xdg.configHome}/waybar/modules/header.jsonc",
                "${config.xdg.configHome}/waybar/modules/hyprsunset.jsonc",
                "${config.xdg.configHome}/waybar/modules/idle_inhibitor.jsonc",
                "${config.xdg.configHome}/waybar/modules/keybindhint.jsonc",
                "${config.xdg.configHome}/waybar/modules/language.jsonc",
                "${config.xdg.configHome}/waybar/modules/memory.jsonc",
                "${config.xdg.configHome}/waybar/modules/mpris.jsonc",
                "${config.xdg.configHome}/waybar/modules/network.jsonc",
                "${config.xdg.configHome}/waybar/modules/notifications.jsonc",
                "${config.xdg.configHome}/waybar/modules/power.jsonc",
                "${config.xdg.configHome}/waybar/modules/privacy.jsonc",
                "${config.xdg.configHome}/waybar/modules/pulseaudio#microphone.jsonc",
                "${config.xdg.configHome}/waybar/modules/pulseaudio.jsonc",
                "${config.xdg.configHome}/waybar/modules/sensorsinfo.jsonc",
                "${config.xdg.configHome}/waybar/modules/spotify.jsonc",
                "${config.xdg.configHome}/waybar/modules/taskbar##custom.jsonc",
                "${config.xdg.configHome}/waybar/modules/taskbar##windows.jsonc",
                "${config.xdg.configHome}/waybar/modules/taskbar.jsonc",
                "${config.xdg.configHome}/waybar/modules/theme.jsonc",
                "${config.xdg.configHome}/waybar/modules/tray.jsonc",
                "${config.xdg.configHome}/waybar/modules/updates.jsonc",
                "${config.xdg.configHome}/waybar/modules/wallchange.jsonc",
                "${config.xdg.configHome}/waybar/modules/wbar.jsonc",
                "${config.xdg.configHome}/waybar/modules/weather.jsonc",
                "${config.xdg.configHome}/waybar/modules/window.jsonc",
                "${config.xdg.configHome}/waybar/modules/workspaces##kanji.jsonc",
                "${config.xdg.configHome}/waybar/modules/workspaces##roman.jsonc",
                "${config.xdg.configHome}/waybar/modules/workspaces.jsonc",
                "${config.xdg.dataHome}/waybar/modules/wlr-taskbar#windows.json",
                "${config.xdg.dataHome}/waybar/modules/wlr-taskbar.json",
                "${config.xdg.dataHome}/waybar/modules/privacy.json",
                "${config.xdg.dataHome}/waybar/modules/tray.json",
                "${config.xdg.dataHome}/waybar/modules/custom-cava.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-clipboard.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-cliphist.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-cpuinfo.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-display.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-dunst.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-gamemode.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-github_hyde.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-gpuinfo#amd.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-gpuinfo#intel.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-gpuinfo#nvidia.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-gpuinfo.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-hyprsunset.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-keybindhint.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-power.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-powermenu.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-sensorsinfo.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-spotify.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-theme.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-updates.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-wallchange.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-wbar.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-weather.jsonc",
                "${config.xdg.dataHome}/waybar/modules/hyprland-language.jsonc",
                "${config.xdg.dataHome}/waybar/modules/hyprland-window.jsonc",
                "${config.xdg.dataHome}/waybar/modules/hyprland-workspaces.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-swaync.jsonc",
                "${config.xdg.dataHome}/waybar/modules/wlr-taskbar.jsonc",
                "${config.xdg.dataHome}/waybar/modules/wlr-taskbar#windows.jsonc",
                "${config.xdg.dataHome}/waybar/modules/clock.jsonc",
                "${config.xdg.dataHome}/waybar/modules/cpu.jsonc",
                "${config.xdg.dataHome}/waybar/modules/idle_inhibitor.jsonc",
                "${config.xdg.dataHome}/waybar/modules/memory.jsonc",
                "${config.xdg.dataHome}/waybar/modules/mpris.jsonc",
                "${config.xdg.dataHome}/waybar/modules/network.jsonc",
                "${config.xdg.dataHome}/waybar/modules/privacy.jsonc",
                "${config.xdg.dataHome}/waybar/modules/pulseaudio.jsonc",
                "${config.xdg.dataHome}/waybar/modules/pulseaudio#microphone.jsonc",
                "${config.xdg.dataHome}/waybar/modules/tray.jsonc",
                "${config.xdg.dataHome}/waybar/modules/power-profiles-daemon.jsonc",
                "${config.xdg.dataHome}/waybar/modules/image#hyde-menu.jsonc",
                "${config.xdg.dataHome}/waybar/modules/custom-hyde-menu.jsonc",
                "${config.xdg.dataHome}/waybar/modules/network#bandwidth.jsonc"
            ],
            "wlr/taskbar#windows": {
                "icon-size": 16.0,
                "icon-size-multiplier": 1.6
            },
            "wlr/taskbar": {
                "icon-size": 16.0,
                "icon-size-multiplier": 1.6
            },
            "privacy": {
                "icon-size": 10,
                "icon-size-multiplier": 1
            },
            "tray": {
                "icon-size": 16.0,
                "icon-size-multiplier": 1.6
            }
          }
        '';
        force = true;
        mutable = true;
      };
      ".config/waybar/user-style.css" = {
        text = cfg.userStyle;
        force = true;
        mutable = true;
      };
      ".config/waybar/style.css" = {
        text = ''
          /*!  DO NOT EDIT THIS FILE */
          /*
          *     ░▒▒▒░░░▓▓           ___________
          *   ░░▒▒▒░░░░░▓▓        //___________/
          *  ░░▒▒▒░░░░░▓▓     _   _ _    _ _____
          *  ░░▒▒░░░░░▓▓▓▓▓ | | | | |  | |  __/
          *   ░▒▒░░░░▓▓   ▓▓ | |_| | |_/ /| |___
          *    ░▒▒░░▓▓   ▓▓   |__  |____/ |____/
          *      ░▒▓▓   ▓▓  //____/
          */

          /* Modified by Hyde */
          /* Modify/add style in ~/.config/waybar/styles/ */
          @import "${config.xdg.dataHome}/waybar/styles/defaults.css";

          /* Imports wallbash colors */
          @import "${config.xdg.cacheHome}/hyde/wallbash/gtk.css";

          /* Colors and theme configuration is generated through the `theme.css` file */
          @import "theme.css";

          /* Users who want to override the current style add/edit 'user-style.css' */
          @import "user-style.css";  
        '';
        force = true;
        mutable = true;
      };
      ".config/waybar/config.jsonc" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/config.jsonc";
        force = true;
        mutable = true;
      };
    };
  };
}
