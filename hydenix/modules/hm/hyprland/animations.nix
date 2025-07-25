{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.hyprland;

  animationPresets = [
    "classic"
    "diablo-1"
    "diablo-2"
    "dynamic"
    "disable"
    "eevee-1"
    "eevee-2"
    "high"
    "low-1"
    "low-2"
    "minimal-1"
    "minimal-2"
    "moving"
    "optimized"
    "standard"
    "vertical"
    "LimeFrenzy"
  ];
in
{
  config = lib.mkIf (cfg.enable && cfg.animations.enable) {
    home.file = lib.mkMerge [
      # Active animation preset
      {
        ".config/hypr/animations.conf" =
          if cfg.animations.overrides ? ${cfg.animations.preset} then
            {
              text = ''
                ${cfg.animations.overrides.${cfg.animations.preset}}
                ${cfg.animations.extraConfig}
              '';
              force = true;
              mutable = true;
            }
          else
            {
              source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/${cfg.animations.preset}.conf";
              force = true;
              mutable = true;
            };
      }

      # All animation presets (with overrides)
      (lib.listToAttrs (
        map (preset: {
          name = ".config/hypr/animations/${preset}.conf";
          value =
            if cfg.animations.overrides ? ${preset} then
              {
                text = cfg.animations.overrides.${preset};
                force = true;
              }
            else
              {
                source = "${pkgs.hydenix.hyde}/Configs/.config/hypr/animations/${preset}.conf";
              };
        }) animationPresets
      ))
    ];
  };
}
