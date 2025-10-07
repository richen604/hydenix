{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.hyde;
in
{

  options.hydenix.hm.hyde = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable hyde module";
    };
  };

  # TODO: review stateful files in hyde module
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyde
      Bibata-Modern-Ice
      Tela-circle-dracula
      kdePackages.kconfig # TODO: not sure if this is still needed
      wf-recorder # screen recorder for wlroots-based compositors such as sway
      python-pyamdgpuinfo
      hyq
      hydectl
      hyde-ipc
      hyde-config
    ];

    # ensures hyprland config is available in session as per hyde uwsm update
    home.sessionVariables = {
      HYPRLAND_CONFIG = "${config.xdg.dataHome}/hypr/hyprland.conf";
    };

    fonts.fontconfig.enable = true;

    # fixes cava from not initializing on boot
    home.activation.createCavaConfig = lib.hm.dag.entryAfter [ "mutableGeneration" ] ''
      mkdir -p "$HOME/.config/cava"
      touch "$HOME/.config/cava/config"
      chmod 644 "$HOME/.config/cava/config"
    '';

    home.file = {
      # Regular files (processed first)
      ".config/hyde/wallbash" = {
        source = "${pkgs.hyde}/Configs/.config/hyde/wallbash";
        recursive = true;
        force = true;
        mutable = true;
      };

      ".config/systemd/user/hyde-config.service" = {
        text = ''
          [Unit]
          Description=HyDE Configuration Parser Service
          Documentation=https://github.com/HyDE-Project/hyde-config
          After=graphical-session.target
          PartOf=graphical-session.target

          [Service]
          Type=simple
          ExecStart=%h/.local/lib/hyde/hyde-config
          Restart=on-failure
          RestartSec=5s
          Environment="DISPLAY=:0"

          # Make sure the required directories exist
          ExecStartPre=/usr/bin/env mkdir -p %h/.config/hyde
          ExecStartPre=/usr/bin/env mkdir -p %h/.local/state/hyde

          [Install]
          WantedBy=graphical-session.target
        '';
      };
      ".config/systemd/user/hyde-ipc.service" = {
        source = "${pkgs.hyde}/Configs/.config/systemd/user/hyde-ipc.service";
      };

      ".local/bin/hyde-shell" = {
        source = pkgs.writeShellScript "hyde-shell" ''
          export PYTHONPATH="${pkgs.python-pyamdgpuinfo}/${pkgs.python3.sitePackages}:$PYTHONPATH"
          exec "${pkgs.hyde}/Configs/.local/bin/hyde-shell" "$@"
        '';
        executable = true;
      };

      ".local/lib/hyde" = {
        source = "${pkgs.hyde}/Configs/.local/lib/hyde";
        recursive = true;
        executable = true;
        force = true;
      };

      ".local/lib/hyde/resetxdgportal.sh" = {
        text = ''
          #!/usr/bin/env bash

        '';
        executable = true;
        mutable = true;
        force = true;
      };

      ".local/share/fastfetch/presets/hyde" = {
        source = "${pkgs.hyde}/Configs/.local/share/fastfetch/presets/hyde";
        recursive = true;
      };
      ".local/share/hyde" = {
        source = "${pkgs.hyde}/Configs/.local/share/hyde";
        recursive = true;
        executable = true;
        force = true;
        mutable = true;
      };
      ".local/share/wallbash/" = {
        source = "${pkgs.hyde}/Configs/.local/share/wallbash/";
        recursive = true;
        force = true;
        mutable = true;
      };
      ".local/share/waybar/includes" = {
        source = "${pkgs.hyde}/Configs/.local/share/waybar/includes";
        recursive = true;
      };
      ".local/share/waybar/layouts" = {
        source = "${pkgs.hyde}/Configs/.local/share/waybar/layouts";
        recursive = true;
      };
      ".local/share/waybar/menus" = {
        source = "${pkgs.hyde}/Configs/.local/share/waybar/menus";
        recursive = true;
      };
      ".local/share/waybar/modules" = {
        source = "${pkgs.hyde}/Configs/.local/share/waybar/modules";
        recursive = true;
      };
      ".local/share/waybar/styles" = {
        source = "${pkgs.hyde}/Configs/.local/share/waybar/styles";
        force = true;
        mutable = true;
        recursive = true;
      };
      ".config/MangoHud/MangoHud.conf" = {
        source = "${pkgs.hyde}/Configs/.config/MangoHud/MangoHud.conf";
      };
      ".local/share/kio/servicemenus/hydewallpaper.desktop" = {
        source = "${pkgs.hyde}/Configs/.local/share/kio/servicemenus/hydewallpaper.desktop";
      };
      ".local/share/kxmlgui5/dolphin/dolphinui.rc" = {
        source = "${pkgs.hyde}/Configs/.local/share/kxmlgui5/dolphin/dolphinui.rc";
      };

      ".config/electron-flags.conf" = {
        source = "${pkgs.hyde}/Configs/.config/electron-flags.conf";
      };

      ".local/share/icons/Wallbash-Icon" = {
        source = "${pkgs.hyde}/share/icons/Wallbash-Icon";
        force = true;
        recursive = true;
        mutable = true;
      };

      # stateful files
      ".config/hyde/config.toml" = {
        source = "${pkgs.hyde}/Configs/.config/hyde/config.toml";
        force = true;
        mutable = true;
      };
      ".local/share/dolphin/view_properties/global/.directory" = {
        source = "${pkgs.hyde}/Configs/.local/share/dolphin/view_properties/global/.directory";
        force = true;
        mutable = true;
      };
      ".local/share/icons/default/index.theme" = {
        source = "${pkgs.hyde}/Configs/.local/share/icons/default/index.theme";
        force = true;
        mutable = true;
      };
      ".local/share/themes/Wallbash-Gtk" = {
        source = "${pkgs.hyde}/share/themes/Wallbash-Gtk";
        recursive = true;
        force = true;
        mutable = true;
      };
    };
  };

}
