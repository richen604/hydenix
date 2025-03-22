{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.sddm;
in
{
  options.hydenix.sddm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable sddm module";
    };

    theme = lib.mkOption {
      type = lib.types.package;
      default = pkgs.hydenix.sddm-candy; # or pkgs.hydenix.sddm-corners
      description = "SDDM theme package to use";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.theme
      pkgs.Bibata-Modern-Ice
    ];

    # Add this section to ensure cursor theme is properly loaded
    environment.sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "24";
    };

    services.displayManager.sddm = {
      enable = true;
      package = pkgs.libsForQt5.sddm;
      theme = cfg.theme.name;
      wayland = {
        enable = true;
      };
      extraPackages = with pkgs; [
        libsForQt5.sddm
        libsForQt5.sddm-kcm
        libsForQt5.qtsvg
        libsForQt5.qtmultimedia
        libsForQt5.qtvirtualkeyboard
        libsForQt5.qtquickcontrols2
        libsForQt5.qtgraphicaleffects
        libsForQt5.layer-shell-qt
        libsForQt5.qt5.qtwayland
        cfg.theme
        Bibata-Modern-Ice
      ];
      settings = {
        Theme = {
          ThemeDir = "/run/current-system/sw/share/sddm/themes";
          CursorTheme = "Bibata-Modern-Ice";
          CursorSize = "24";
        };
        General = {
          # Set default session globally
          DefaultSession = "hyprland.desktop";
        };
        Wayland = {
          EnableHiDPI = true;
        };
      };
    };
  };
}
