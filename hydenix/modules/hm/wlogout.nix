{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.wlogout;
in
{
  options.hydenix.hm.wlogout = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable logout module";
    };

    wlogout = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable wlogout";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [

      # wlogout
      (lib.mkIf cfg.wlogout.enable wlogout) # logout menu
    ];

    home.file = {

      # icons
      ".config/wlogout/icons/" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/wlogout/icons/";
        recursive = true;
      };

      # Stateful files with themes
      ".config/wlogout/layout_1" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/wlogout/layout_1";
        force = true;
        mutable = true;
      };
      ".config/wlogout/style_1.css" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/wlogout/style_1.css";
        force = true;
        mutable = true;
      };
      ".config/wlogout/layout_2" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/wlogout/layout_2";
        force = true;
        mutable = true;
      };
      ".config/wlogout/style_2.css" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/wlogout/style_2.css";
        force = true;
        mutable = true;
      };

    };
  };
}
