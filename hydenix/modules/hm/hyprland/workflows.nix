{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.hyprland;

  workflowPresets = [
    "default"
    "editing"
    "gaming"
    "powersaver"
    "snappy"
  ];
in
{
  config = lib.mkIf (cfg.enable && cfg.workflows.enable) {
    home.file = lib.mkMerge [
      # Active workflow
      {
        ".config/hypr/workflows.conf" =
          if cfg.workflows.overrides ? ${cfg.workflows.active} then
            {
              text = cfg.workflows.overrides.${cfg.workflows.active};
              force = true;
              mutable = true;
            }
          else
            {
              source = "${pkgs.hyde}/Configs/.config/hypr/workflows/${cfg.workflows.active}.conf";
              force = true;
              mutable = true;
            };
      }

      # All workflow presets (with overrides)
      (lib.listToAttrs (
        map (workflow: {
          name = ".config/hypr/workflows/${workflow}.conf";
          value =
            if cfg.workflows.overrides ? ${workflow} then
              {
                text = cfg.workflows.overrides.${workflow};
                force = true;
              }
            else
              {
                source = "${pkgs.hyde}/Configs/.config/hypr/workflows/${workflow}.conf";
              };
        }) workflowPresets
      ))

      # Custom workflows (exclude the standard presets)
      (lib.mapAttrs' (name: content: {
        name = ".config/hypr/workflows/${name}.conf";
        value = {
          text = content;
          force = true;
        };
      }) (lib.filterAttrs (name: _: !(lib.elem name workflowPresets)) cfg.workflows.overrides))
    ];
  };
}
