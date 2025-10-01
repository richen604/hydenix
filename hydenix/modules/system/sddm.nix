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
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.hydenix.hyde
      pkgs.Bibata-Modern-Ice
      pkgs.sddm-astronaut
    ];

    # Add this section to ensure cursor theme is properly loaded
    environment.sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "24";
    };

    services.displayManager.sddm = {
      enable = true;
      theme = "sddm-astronaut-theme";
      wayland = {
        enable = true;
      };
      extraPackages = with pkgs.kdePackages; [
        qtsvg
        qtmultimedia
        qtvirtualkeyboard
      ];
      settings = {
        Theme = {
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
