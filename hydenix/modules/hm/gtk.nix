{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.gtk;
in
{
  options.hydenix.hm.gtk = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable gtk module";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gtk3
      gtk4
      glib
      gsettings-desktop-schemas
      gnome-settings-daemon
      gnome-tweaks
      gnomeExtensions.window-gestures
      nwg-look
      adwaita-icon-theme
      emote
    ];
    home.file = {
      ".config/nwg-look/config" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/nwg-look/config";
      };

      # stateful files
      # TODO: might flash on initial theme change, unnecessary?
      ".config/gtk-3.0/settings.ini" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/gtk-3.0/settings.ini";
        force = true;
        mutable = true;
      };
      ".gtkrc-2.0" = {
        source = "${pkgs.hydenix.hyde}/Configs/.gtkrc-2.0";
        force = true;
        mutable = true;
      };
      ".config/xsettingsd/xsettingsd.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/xsettingsd/xsettingsd.conf";
        force = true;
        mutable = true;
      };
    };
  };
}
