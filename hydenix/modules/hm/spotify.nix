{
  config,
  lib,
  pkgs,
  ...
}:
# TODO: add spicetify support using flatpak
let
  cfg = config.hydenix.hm.spotify;
in
{
  options.hydenix.hm.spotify = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable spotify module";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      spotify
    ];

    home.file = {
      ".config/spotify-flags.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/spotify-flags.conf";
      };
      ".config/electron-flags.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/electron-flags.conf";
      };
    };
  };
}
