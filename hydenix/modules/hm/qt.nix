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
      kdePackages.qt6ct
      kdePackages.qtbase
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum
      kdePackages.breeze-icons
      kdePackages.qtimageformats
      kdePackages.qtsvg
      kdePackages.qtwayland
    ];

    home.file = {
      ".config/qt5ct/qt5ct.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/qt5ct/qt5ct.conf";
      };
      ".config/qt6ct/qt6ct.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/qt6ct/qt6ct.conf";
      };
      ".config/menus/applications.menu" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/menus/applications.menu";
      };

      ".config/Kvantum/wallbash/wallbash.kvconfig" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/Kvantum/wallbash/wallbash.kvconfig";
        force = true;
        mutable = true;
      };
      ".config/Kvantum/wallbash/wallbash.svg" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/Kvantum/wallbash/wallbash.svg";
        force = true;
        mutable = true;
      };
      ".config/Kvantum/kvantum.kvconfig" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/Kvantum/kvantum.kvconfig";
        force = true;
        mutable = true;
      };
      # stateful files
      ".config/kdeglobals" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/kdeglobals";
        force = true;
        mutable = true;
      };
      ".config/qt5ct/colors.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/qt5ct/colors.conf";
        force = true;
        mutable = true;
      };
      ".config/qt6ct/colors.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/qt6ct/colors.conf";
        force = true;
        mutable = true;
      };
    };
  };
}
