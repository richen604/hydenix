{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.qt;
in
{
  options.hydenix.hm.qt = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable qt module";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libsForQt5.qt5ct
      libsForQt5.qt5.qtbase
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qtimageformats
      libsForQt5.qtsvg
      libsForQt5.qt5.qtwayland
      kdePackages.qtbase
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum
      kdePackages.breeze-icons
      kdePackages.qtimageformats
      kdePackages.qtsvg
      kdePackages.qtwayland
    ];

    home.file = {
      ".config/qt5ct/qt5ct.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/qt5ct/qt5ct.conf";
      };
      ".config/qt6ct/qt6ct.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/qt6ct/qt6ct.conf";
      };
      ".config/Kvantum/wallbash/wallbash.kvconfig" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/Kvantum/wallbash/wallbash.kvconfig";
      };
      ".config/Kvantum/wallbash/wallbash.svg" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/Kvantum/wallbash/wallbash.svg";
      };
      ".config/Kvantum/kvantum.kvconfig" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/Kvantum/kvantum.kvconfig";
      };

      ".config/menus/applications.menu" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/menus/applications.menu";
      };

      # stateful files
      ".config/kdeglobals" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/kdeglobals";
        force = true;
        mutable = true;
      };

      ".config/qt5ct/colors.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/qt5ct/colors.conf";
        force = true;
        mutable = true;
      };
      ".config/qt6ct/colors.conf" = lib.mkDefault {
        source = "${pkgs.hydenix.hyde}/Configs/.config/qt6ct/colors.conf";
        force = true;
        mutable = true;
      };
    };
  };
}
