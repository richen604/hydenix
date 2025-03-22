{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.firefox;
in
{
  options.hydenix.hm.firefox = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable firefox module";
    };

    useHydeConfig = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use HyDE Firefox configuration and extensions";
    };

    useUserChrome = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Apply HyDE userChrome CSS customizations";
    };

    useUserJs = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Apply HyDE user.js preferences";
    };

    useExtensions = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Install HyDE Firefox extensions";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      firefox # browser
    ];

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };

    # Apply HyDE Firefox configuration if enabled
    home.activation = lib.mkIf cfg.useHydeConfig {
      installHydeFirefoxConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # Get the default profile directory
        PROFILE_DIR=$(find ~/.mozilla/firefox -name "*.default-release" -type d 2>/dev/null || echo "")
        if [ -z "$PROFILE_DIR" ]; then
          echo "No default Firefox profile found. Creating one may require running Firefox first."
        else
          # Create chrome directory if it doesn't exist
          $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$PROFILE_DIR/chrome"
          
          # Install extensions if enabled
          ${lib.optionalString cfg.useExtensions ''
            $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ~/.mozilla/firefox
            $DRY_RUN_CMD cp -r $VERBOSE_ARG ${pkgs.hydenix.hyde-firefox}/extensions/* ~/.mozilla/
          ''}
          
          # Install userChrome.css if enabled
          ${lib.optionalString cfg.useUserChrome ''
            $DRY_RUN_CMD cp -r $VERBOSE_ARG ${pkgs.hydenix.hyde-firefox}/userconfig/chrome/* "$PROFILE_DIR/chrome/"
          ''}
          
          # Install user.js if enabled
          ${lib.optionalString cfg.useUserJs ''
            $DRY_RUN_CMD cp -r $VERBOSE_ARG ${pkgs.hydenix.hyde-firefox}/userconfig/user.js "$PROFILE_DIR/"
          ''}
        fi
      '';
    };
  };
}
