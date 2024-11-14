{
  config,
  userConfig,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.hydenix;
  isNixOS = builtins.pathExists /etc/nixos;
  themes = (import ./sources/themes { inherit pkgs cfg; }).filteredThemes;
  activeTheme = builtins.head (builtins.filter (theme: theme.name == cfg.activeTheme) themes);
in
{
  imports = [
    ./hm/mutable
    ./packages
    ./programs
    ./sources
  ];

  options.hydenix = {
    enable = mkEnableOption "hydenix";
    git = {
      userName = mkOption {
        type = types.str;
        description = "Git user name";
      };
      userEmail = mkOption {
        type = types.str;
        description = "Git user email";
      };
    };
    themes = mkOption {
      type = types.listOf types.str;
      default = [ "Catppuccin Mocha" ];
      description = "List of theme names to install. The last one will be set as the current theme.";
    };
    activeTheme = mkOption {
      type = types.str;
      default = "Catppuccin Mocha";
      description = "The active theme to use.";
    };
  };

  config = mkIf cfg.enable {

    targets.genericLinux.enable = !isNixOS;

    home.username = userConfig.username;
    home.homeDirectory = "/home/${userConfig.username}";

    fonts.fontconfig.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        # xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };

    wayland.windowManager.hyprland.systemd.variables = [ "--all" ];

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          icon-theme = config.gtk.iconTheme.name or activeTheme.arcs.icon.name or "Tela-circle-dracula";
          gtk-theme = config.gtk.theme.name or activeTheme.arcs.gtk.name or "Wallbash-Gtk";
          color-scheme = "prefer-dark";
          font-name = activeTheme.arcs.font.name or "Cantarell 10";
          cursor-theme = config.pointerCursor.name or activeTheme.arcs.cursor.name or "Bibata-Modern-Ice";
          cursor-size = config.pointerCursor.size or "20";
          document-font-name = activeTheme.arcs.font.name or "Cantarell 10";
          monospace-font-name = "JetBrains Mono 9";
          font-antialiasing = "rgba";
          font-hinting = "full";
        };
      };
    };

    services = {
      blueman-applet.enable = true;
    };

    home.sessionVariables = import ./hm/home-env.nix { inherit lib; };
    home.packages = import ./hm/home-packages.nix { inherit lib pkgs themes; };
    home.file = import ./hm/home-file.nix {
      inherit
        lib
        pkgs
        themes
        userConfig
        ;
    };
    home.activation = import ./hm/home-activation.nix {
      inherit
        lib
        pkgs
        config
        themes
        ;
      activeTheme = cfg.activeTheme;
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        # Web
        "text/html" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/chrome" = [ "firefox.desktop" ];
        "application/x-extension-htm" = [ "firefox.desktop" ];
        "application/x-extension-html" = [ "firefox.desktop" ];
        "application/x-extension-shtml" = [ "firefox.desktop" ];
        "application/xhtml+xml" = [ "firefox.desktop" ];
        "application/x-extension-xhtml" = [ "firefox.desktop" ];
        "application/x-extension-xht" = [ "firefox.desktop" ];

        # File manager
        "inode/directory" = [ "org.kde.dolphin.desktop" ];
        "x-scheme-handler/file" = [ "org.kde.dolphin.desktop" ];
        "x-scheme-handler/about" = [ "org.kde.dolphin.desktop" ];

        # Text
        "text/plain" = [ "code.desktop" ];

        # Images
        "image/jpeg" = [ "org.kde.gwenview.desktop" ];
        "image/png" = [ "org.kde.gwenview.desktop" ];
        "image/gif" = [ "org.kde.gwenview.desktop" ];
        "image/svg+xml" = [ "org.kde.gwenview.desktop" ];

        # Archives
        "application/zip" = [ "org.kde.ark.desktop" ];
        "application/x-tar" = [ "org.kde.ark.desktop" ];
        "application/x-compressed-tar" = [ "org.kde.ark.desktop" ];
        "application/x-7z-compressed" = [ "org.kde.ark.desktop" ];
        "application/x-rar" = [ "org.kde.ark.desktop" ];

        # PDF
        "application/pdf" = [ "org.kde.okular.desktop" ];

        # Terminal
        "application/x-terminal-emulator" = [ "kitty.desktop" ];
      };
    };

    nix = {
      package = lib.mkForce pkgs.nix;
    };
  };
}
