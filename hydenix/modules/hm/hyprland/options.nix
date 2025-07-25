{
  config,
  lib,
  ...
}:

let
  cfg = config.hydenix.hm.hyprland;
in
{
  options.hydenix.hm.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable hyprland module";
    };
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra config appended to userprefs.conf";
    };
    overrideMain = lib.mkOption {
      type = lib.types.nullOr lib.types.lines;
      default = null;
      description = "Complete override of hyprland.conf";
    };

    # Animation configurations
    animations = {
      enable = lib.mkEnableOption "animation configurations" // {
        default = cfg.enable;
      };
      preset = lib.mkOption {
        type = lib.types.enum [
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
        default = "standard";
        description = "Animation preset to use";
      };
      extraConfig = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Additional animation configuration";
      };
      overrides = lib.mkOption {
        type = lib.types.attrsOf lib.types.lines;
        default = { };
        description = "Override specific animation files by name";
        example = lib.literalExpression ''
          {
            "classic" = '''
              animation = windows, 1, 5, default
            ''';
          }
        '';
      };
    };

    # Shader configurations
    shaders = {
      enable = lib.mkEnableOption "shader configurations" // {
        default = cfg.enable;
      };
      overrides = lib.mkOption {
        type = lib.types.attrsOf lib.types.lines;
        default = { };
        description = "Override or add custom shaders";
        example = lib.literalExpression ''
          {
            "my-filter.frag" = '''
              precision mediump float;
              // Custom shader code
            ''';
          }
        '';
      };
    };

    # Workflow configurations
    workflows = {
      enable = lib.mkEnableOption "workflow configurations" // {
        default = cfg.enable;
      };
      active = lib.mkOption {
        type = lib.types.enum [
          "default"
          "editing"
          "gaming"
          "powersaver"
          "snappy"
        ];
        default = "default";
        description = "Active workflow preset";
      };
      overrides = lib.mkOption {
        type = lib.types.attrsOf lib.types.lines;
        default = { };
        description = "Override or add custom workflows";
      };
    };

    # Hypridle configurations
    hypridle = {
      enable = lib.mkEnableOption "hypridle configurations" // {
        default = cfg.enable;
      };
      extraConfig = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Additional hypridle configuration";
      };
      overrideConfig = lib.mkOption {
        type = lib.types.nullOr lib.types.lines;
        default = null;
        description = "Complete hypridle configuration override";
      };
    };

    # Keybindings configurations
    keybindings = {
      enable = lib.mkEnableOption "keybindings configurations" // {
        default = cfg.enable;
      };
      extraConfig = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Additional keybindings configuration";
      };
      overrideConfig = lib.mkOption {
        type = lib.types.nullOr lib.types.lines;
        default = null;
        description = "Complete keybindings configuration override";
      };
    };

    # Window rules configurations
    windowrules = {
      enable = lib.mkEnableOption "window rules configurations" // {
        default = cfg.enable;
      };
      extraConfig = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Additional window rules configuration";
      };
      overrideConfig = lib.mkOption {
        type = lib.types.nullOr lib.types.lines;
        default = null;
        description = "Complete window rules configuration override";
      };
    };

    # NVIDIA configurations
    nvidia = {
      enable = lib.mkEnableOption "NVIDIA configurations" // {
        default = config.hardware.nvidia.enabled or false;
      };
      extraConfig = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Additional NVIDIA configuration";
      };
      overrideConfig = lib.mkOption {
        type = lib.types.nullOr lib.types.lines;
        default = null;
        description = "Complete NVIDIA configuration override";
      };
    };

    # Monitor configurations
    monitors = {
      enable = lib.mkEnableOption "monitor configurations" // {
        default = cfg.enable;
      };
      overrideConfig = lib.mkOption {
        type = lib.types.nullOr lib.types.lines;
        default = null;
        description = "Complete monitor configuration override";
      };
    };
  };
}
