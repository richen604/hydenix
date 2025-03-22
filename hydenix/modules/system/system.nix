{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.system;
in
{
  options.hydenix.system = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable system module";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      parallel # Shell tool for executing jobs in parallel
      jq # Command-line JSON processor
      imagemagick # Image manipulation tools
      resvg # SVG rendering library and tools
      libnotify # Desktop notification library
      envsubst # Environment variable substitution utility
      killall # Process termination utility
      wl-clipboard # Wayland clipboard utilities
      gnumake # Build automation tool
      git # distributed version control system
      fzf # command line fuzzy finder
      polkit_gnome # authentication agent for privilege escalation
      dbus # inter-process communication daemon
      upower # power management/battery status daemon
      mesa # OpenGL implementation and GPU drivers
      dconf # configuration storage system
      dconf-editor # dconf editor
      home-manager # user environment manager
      xdg-utils # Collection of XDG desktop integration tools
      desktop-file-utils # for updating desktop database
      hicolor-icon-theme # Base fallback icon theme
      kdePackages.ark # kde file archiver
      cava # audio visualizer
      cliphist # clipboard manager
      wayland # for wayland support
      egl-wayland # for wayland support
      xwayland # for x11 support
      gobject-introspection # for python packages
      trash-cli # cli to manage trash files
      gawk # awk implementation
      coreutils # coreutils implementation
      bash-completion # Add bash-completion package
    ];

    environment.variables = {
      NIXOS_OZONE_WL = "1";
    };

    programs.hyprland = {
      enable = true;
      withUWSM = false;
    };

    environment.pathsToLink = [
      "/share/icons"
      "/share/themes"
      "/share/fonts"
      "/share/xdg-desktop-portal"
      "/share/applications"
      "/share/mime"
      "/share/wayland-sessions"
      "/share/zsh"
      "/share/bash-completion"
      "/share/fish"
    ];

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    services = {
      dbus.enable = true;
      upower.enable = true;
      openssh.enable = true;
      libinput.enable = true;
      udisks2 = {
        enable = true;
        mountOnMedia = true;
      };
    };

    programs.dconf.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    programs.zsh.enable = true;

    # For polkit authentication
    security.polkit.enable = true;
    security.pam.services.swaylock = { };
    security.rtkit.enable = true;
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    # For trash-cli to work properly
    services.gvfs.enable = true;

    # For proper XDG desktop integration
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

  };
}
