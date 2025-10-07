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
    # Create a combined theme package using symlinkJoin with only selected themes
    home.packages = [
      (pkgs.symlinkJoin {
        name = "hydenix-themes";
        paths = lib.filter (p: p != null) (map findThemeByName availableThemes);
        meta = {
          description = "Combined HyDE themes package";
          platforms = pkgs.lib.platforms.all;
        };
      })
    ];

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

    /*
      We require both an activation script and a service to set the theme.
      theme.set.sh uses dconf partially to set vars, which requires graphical targets to run
      This is only an issue for the *first* rebuild, as dbus has never been started

      #TODO: this works but a more robust implementation is possible. just do what theme.set.sh/dconf.set.sh does and use home.file to set the correct gtk/qt/etc options
    */

    # applies what it can before graphical.target, think of this like a "first content paint"
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
            which
            util-linux
            dconf
          ]
        )
      }:$HOME/.local/bin:$PATH"

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

    # sets dconf settings correctly
    systemd.user.services.setThemeDconf = {
      Unit = {
        Description = "Apply Hyde theme dconf settings";
        After = [
          "graphical-session.target"
          "dbus.service"
        ];
        Wants = [ "dbus.service" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = ''
          ${config.home.homeDirectory}/.local/lib/hyde/dconf.set.sh
        '';
        Path = with pkgs; [
          dconf
          glib
          hyprland
          util-linux
          which
          coreutils
          imagemagick
          gawk
          parallel
          swww
          waybar
          kitty
          dunst
          libnotify
          "${config.home.homeDirectory}/.local/bin"
        ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    # reapplies the theme to fix dconf
    systemd.user.services.setTheme = {
      Unit = {
        Description = "Apply Hyde theme settings (full theme switch)";
        After = [
          "graphical-session.target"
          "dbus.service"
          "setThemeDconf.service"
        ];
        Wants = [ "dbus.service" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = ''
          ${config.home.homeDirectory}/.local/lib/hyde/theme.switch.sh -s "${cfg.active}" || true
        '';
        Path = with pkgs; [
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
          which
          util-linux
          dconf
          "${config.home.homeDirectory}/.local/bin"
        ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

  };
}
