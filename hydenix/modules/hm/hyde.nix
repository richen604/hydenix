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
      hydenix.wallbash-gtk
      hydenix.wallbash-icons
      Bibata-Modern-Ice
      Tela-circle-dracula
      hydenix.hyde
    ];

    fonts.fontconfig.enable = true;

    home.file = {
      # Regular files (processed first)
      ".config/hyde/wallbash" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hyde/wallbash";
        recursive = true;
      };

      ".local/bin/hyde-shell" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.local/bin/hyde-shell";
        executable = true;
      };

      ".local/lib/hyde" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.local/lib/hyde";
        recursive = true;
        executable = true;
      };

      ".local/lib/hyde/globalcontrol.sh" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.local/lib/hyde/globalcontrol.sh";
        executable = true;
      };

      ".local/share/fastfetch/presets/hyde" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.local/share/fastfetch/presets/hyde";
        recursive = true;
      };
      ".local/share/hyde" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.local/share/hyde";
        recursive = true;
        executable = true;
        force = true;
        mutable = true;
      };
      ".config/MangoHud/MangoHud.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/MangoHud/MangoHud.conf";
      };
      ".local/share/kio/servicemenus/hydewallpaper.desktop" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.local/share/kio/servicemenus/hydewallpaper.desktop";
      };
      ".local/share/kxmlgui5/dolphin/dolphinui.rc" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.local/share/kxmlgui5/dolphin/dolphinui.rc";
      };

      ".config/electron-flags.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/electron-flags.conf";
      };

      ".local/share/icons/Wallbash-Icon" = lib.mkDefault {
        source = "${pkgs.hydenix.wallbash-icons}/Wallbash-Icon";
        force = true;
        recursive = true;
        mutable = true;
      };

      # stateful files
      ".config/hyde/config.toml" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/hyde/config.toml";
        force = true;
        mutable = true;
      };
      ".local/share/dolphin/view_properties/global/.directory" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.local/share/dolphin/view_properties/global/.directory";
        force = true;
        mutable = true;
      };
      ".local/share/icons/default" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.local/share/icons/default/index.theme";
        force = true;
        mutable = true;
      };
      ".local/share/themes/Wallbash-Gtk" = lib.mkDefault {
        source = "${pkgs.hydenix.wallbash-gtk}/share/themes/Wallbash-Gtk";
        recursive = true;
        force = true;
        mutable = true;
      };

    };
  };
}
