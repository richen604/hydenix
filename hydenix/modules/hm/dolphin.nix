{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.dolphin;
in
{
  options.hydenix.hm.dolphin = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable dolphin module";
    };
  };

  config = lib.mkIf cfg.enable {

    #! we are using libsForQt5 because dolphin likes to break things like icons on qt6
    home.packages = with pkgs.libsForQt5; [
      dolphin # KDE file manager
      qt5.qtimageformats # Image format support for Qt5
      ffmpegthumbs # Video thumbnail support
      kde-cli-tools # KDE command line utilities
      kdegraphics-thumbnailers # KDE graphics thumbnails
      kimageformats # Additional image format support for KDE
      qtsvg # SVG support
      kio # KDE I/O framework
      kio-extras # Additional KDE I/O protocols
      kwayland # KDE Wayland integration
    ];

    home.file = lib.mkMerge [
      {
        ".config/dolphinrc" = {
          source = "${pkgs.hydenix.hyde}/Configs/.config/dolphinrc";
        };
        ".config/baloofilerc" = {
          source = "${pkgs.hydenix.hyde}/Configs/.config/baloofilerc";
        };
        ".config/menus/applications.menu" = {
          source = "${pkgs.hydenix.hyde}/Configs/.config/menus/applications.menu";
        };
      }
      # stateful file for themes
      (lib.mkAfter {
        ".config/kdeglobals" = {
          source = "${pkgs.hydenix.hyde}/Configs/.config/kdeglobals";
          force = true;
          mutable = true;
        };
      })
    ];
  };
}
