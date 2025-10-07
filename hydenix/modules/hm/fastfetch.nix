{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.fastfetch;
in
{
  options.hydenix.hm.fastfetch = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable fastfetch configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/fastfetch/config.jsonc" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/fastfetch/config.jsonc";
      };
      # TODO: add hydenix logo
      # TODO: custom logos and pick defaults
      ".config/fastfetch/logos" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/fastfetch/logos";
        recursive = true;
      };
    };
  };
}
