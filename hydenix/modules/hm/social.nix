{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.social;
in
{
  options.hydenix.hm.social = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable social module";
    };

    discord = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable discord module";
      };
    };

    webcord = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable webcord module";
      };
    };

    vesktop = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable vesktop module";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (lib.mkIf cfg.discord.enable discord)
      (lib.mkIf cfg.webcord.enable webcord)
      (lib.mkIf cfg.vesktop.enable vesktop)
    ];

    home.file = {
      ".config/electron-flags.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/electron-flags.conf";
      };
    };
  };
}
