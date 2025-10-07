{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.terminals;
in
{
  options.hydenix.hm.terminals = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable terminals module";
    };

    kitty = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable kitty terminal";
      };
      configText = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Kitty config multiline text, use this to extend kitty settings";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (lib.mkIf cfg.kitty.enable kitty) # terminal
    ];

    home.file = {
      ".config/kitty/hyde.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/kitty/hyde.conf";
      };
      ".config/kitty/kitty.conf" = {
        text = ''
          include hyde.conf

          # Add your custom configurations here
          ${cfg.kitty.configText}
        '';
        force = true;
        mutable = true;
      };

      # Kitty
      # stateful file for kitty wallbash

      ".config/kitty/theme.conf" = {
        source = "${pkgs.hydenix.hyde}/Configs/.config/kitty/theme.conf";
        force = true;
        mutable = true;
      };
    };
  };
}
