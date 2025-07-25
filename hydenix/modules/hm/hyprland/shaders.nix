{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.hyprland;

  standardShaders = [
    "blue-light-filter"
    "color-vision"
    "custom"
    "disable"
    "grayscale"
    "invert-colors"
    "oled"
    "oled-saver"
    "paper"
    "vibrance"
    "wallbash"
  ];
in
{
  config = lib.mkIf (cfg.enable && cfg.shaders.enable) {
    home.file = lib.mkMerge [
      # Standard shaders (generated from list)
      (lib.mkMerge [
        # Generate standard shader files from list
        (lib.listToAttrs (
          map (shader: {
            name = ".config/hypr/shaders/${shader}.frag";
            value = {
              source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/shaders/${shader}.frag";
            };
          }) standardShaders
        ))

        # Additional shader files
        {
          ".config/hypr/shaders/.compiled.cache.glsl" = {
            source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/shaders/.compiled.cache.glsl";
            force = true;
            mutable = true;
          };
          ".config/hypr/shaders.conf" = {
            source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/shaders.conf";
            force = true;
            mutable = true;
          };
          ".config/hypr/shaders/wallbash.inc".source =
            "${pkgs.hydenix.hyde}/Configs/.config/hypr/shaders/wallbash.inc";
        }
      ])

      # Custom/override shaders
      (lib.mapAttrs' (name: content: {
        name = ".config/hypr/shaders/${name}";
        value = {
          text = content;
          force = true;
        };
      }) cfg.shaders.overrides)
    ];
  };
}
