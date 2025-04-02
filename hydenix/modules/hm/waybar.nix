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
      ];

    home.file = {

      # Modules for waybar
      # Note: some of these may not work for NixOS
      # TODO: review waybar modules for nix compatibility
      ".config/waybar/modules/backlight.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/backlight.jsonc";
      };
      ".config/waybar/modules/battery.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/battery.jsonc";
      };
      ".config/waybar/modules/bluetooth.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/bluetooth.jsonc";
      };
      ".config/waybar/modules/cava.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/cava.jsonc";
      };
      ".config/waybar/modules/cliphist.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/cliphist.jsonc";
      };
      ".config/waybar/modules/clock##alt.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/clock##alt.jsonc";
      };
      ".config/waybar/modules/clock.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/clock.jsonc";
      };
      ".config/waybar/modules/cpu.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/cpu.jsonc";
      };
      ".config/waybar/modules/cpuinfo.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/cpuinfo.jsonc";
      };
      ".config/waybar/modules/display.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/display.jsonc";
      };
      ".config/waybar/modules/github_hyde.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/github_hyde.jsonc";
      };
      ".config/waybar/modules/gpuinfo.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/gpuinfo.jsonc";
      };
      ".config/waybar/modules/hyprsunset.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/hyprsunset.jsonc";
      };
      ".config/waybar/modules/idle_inhibitor.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/idle_inhibitor.jsonc";
      };

      ".config/waybar/modules/language.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/language.jsonc";
      };
      ".config/waybar/modules/memory.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/memory.jsonc";
      };
      ".config/waybar/modules/mpris.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/mpris.jsonc";
      };
      ".config/waybar/modules/network.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/network.jsonc";
      };
      ".config/waybar/modules/notifications.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/notifications.jsonc";
      };
      ".config/waybar/modules/power.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/power.jsonc";
      };
      ".config/waybar/modules/privacy.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/privacy.jsonc";
      };
      ".config/waybar/modules/pulseaudio.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/pulseaudio.jsonc";
      };
      ".config/waybar/modules/sensorsinfo.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/sensorsinfo.jsonc";
      };
      ".config/waybar/modules/spotify.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/spotify.jsonc";
      };
      ".config/waybar/modules/taskbar##custom.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/taskbar##custom.jsonc";
      };
      ".config/waybar/modules/taskbar##windows.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/taskbar##windows.jsonc";
      };
      ".config/waybar/modules/taskbar.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/taskbar.jsonc";
      };
      ".config/waybar/modules/theme.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/theme.jsonc";
      };
      ".config/waybar/modules/tray.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/tray.jsonc";
      };
      ".config/waybar/modules/updates.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/updates.jsonc";
      };
      ".config/waybar/modules/wbar.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/wbar.jsonc";
      };
      ".config/waybar/modules/weather.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/weather.jsonc";
      };
      ".config/waybar/modules/window.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/window.jsonc";
      };
      ".config/waybar/modules/workspaces##kanji.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/workspaces##kanji.jsonc";
      };
      ".config/waybar/modules/workspaces##roman.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/workspaces##roman.jsonc";
      };
      ".config/waybar/modules/workspaces.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/workspaces.jsonc";
      };

      # stateful files
      # for some reason this won't pull from the repo
      ".config/waybar/modules/keyboardhint.jsonc" = lib.mkDefault {
        text = ''
              "custom/keybindhint": {
              "format": " ",
              "tooltip-format": " Keybinds",
              "rotate": ''${r_deg},
              "on-click": "keybinds_hint.sh"
          },
        '';
      };
      ".config/waybar/config.ctl" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/config.ctl";
        force = true;
        mutable = true;
      };
      ".config/waybar/modules/header.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/header.jsonc";
        force = true;
        mutable = true;
      };
      ".config/waybar/modules/footer.jsonc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/footer.jsonc";
        mutable = true;
        force = true;
      };

      ".config/waybar/modules/style.css" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/modules/style.css";
        force = true;
        mutable = true;
      };
      # ".config/waybar/config.jsonc" =  lib.mkDefault {
      #   source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/config.jsonc";
      #   force = true;
      #   mutable = true;
      # };
      # ".config/waybar/style.css" = lib.mkDefault {
      #   source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/style.css";
      #   force = true;
      #   mutable = true;
      # };
      # ".config/waybar/theme.css" =  lib.mkDefault {
      #   source = "${pkgs.hydenix.hyde}/Configs/.config/waybar/theme.css";
      #   force = true;
      #   mutable = true;
      # };

    };
  };
}
