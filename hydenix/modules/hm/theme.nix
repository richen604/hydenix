{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.theme;

  # Helper function to find a theme package by name, returns null if not found
  findThemeByName = themeName: pkgs.hydenix.themes.${themeName} or null;

  # Filter out themes that don't have corresponding packages
  availableThemes = lib.filter (themeName: findThemeByName themeName != null) cfg.themes;
in
{
  options.hydenix.hm.theme = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable theme module";
    };

    active = lib.mkOption {
      type = lib.types.str;
      default = "Catppuccin Mocha";
      description = "Active theme name";
    };

    themes = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "Catppuccin Mocha"
        "Catppuccin Latte"
      ];
      description = "Available theme names";
    };
  };

  config = lib.mkIf cfg.enable {
    # Convert theme names to their corresponding packages, filtering out missing ones
    home.packages = lib.filter (p: p != null) (map findThemeByName availableThemes);

    # walks through the themes and creates symlinks in the hyde themes directory
    home.file =
      let
        # Find the package for each theme name, filtering out missing ones
        themesList = lib.filter (t: t.pkg != null) (
          map (themeName: {
            name = themeName;
            pkg = findThemeByName themeName;
          }) availableThemes
        );
      in
      lib.mkMerge (
        map (theme: {
          ".config/hyde/themes/${theme.name}" = {
            source = "${theme.pkg}/share/hyde/themes/${theme.name}";
            force = true;
            recursive = true;
            mutable = true;
          };
        }) themesList
      );

    # Add activation script to set the active theme
    home.activation.setTheme = lib.hm.dag.entryAfter [ "mutableGeneration" ] ''
      # Define path with required tools
      export PATH="${
        lib.makeBinPath (
          with pkgs;
          [
            swww
            killall
            hyprland
            dunst
            libnotify
            systemd
            waybar
            kitty
            gawk
            coreutils
            parallel
            imagemagick
            hydenix.hyde
            which
            util-linux
            dconf
          ]
        )
      }:$PATH"

      # Set up logging
      LOG_FILE="$HOME/.local/state/hyde/theme-switch.log"
      mkdir -p $HOME/.local/state/hyde
      # Clear the log file before writing
      : > "$LOG_FILE"
      chmod 644 $LOG_FILE

      echo "Setting theme to ${cfg.active}..." | tee -a "$LOG_FILE"

      export LOG_LEVEL=debug

      # Run the theme switch commands with the custom runtime dir
      $HOME/.local/lib/hyde/theme.switch.sh -s "${cfg.active}" >> "$LOG_FILE" 2>&1

      echo "Theme switch completed. Log saved to $LOG_FILE" | tee -a "$LOG_FILE"
    '';
  };
}
