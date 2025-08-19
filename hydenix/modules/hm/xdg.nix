{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.hm.xdg;
in
{
  options.hydenix.hm.xdg = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.hm.enable;
      description = "Enable XDG base directory specification";
    };
  };

  config = lib.mkIf cfg.enable {

    xdg = {
      enable = true;

      portal = {
        enable = true;
        extraPortals = with pkgs; [
          pkgs.xdg-desktop-portal-hyprland
          xdg-desktop-portal-gtk
          xdg-desktop-portal
        ];
        xdgOpenUsePortal = true;
        configPackages = with pkgs; [
          pkgs.xdg-desktop-portal-hyprland
          xdg-desktop-portal-gtk
          xdg-desktop-portal
        ];
      };

      mimeApps = {
        enable = true;
      };

      userDirs = {
        enable = true;
        createDirectories = true;

        # Define standard XDG user directories
        desktop = "${config.home.homeDirectory}/Desktop";
        documents = "${config.home.homeDirectory}/Documents";
        download = "${config.home.homeDirectory}/Downloads";
        music = "${config.home.homeDirectory}/Music";
        pictures = "${config.home.homeDirectory}/Pictures";
        publicShare = "${config.home.homeDirectory}/Public";
        templates = "${config.home.homeDirectory}/Templates";
        videos = "${config.home.homeDirectory}/Videos";
      };

      # Define standard XDG base directories
      cacheHome = "${config.home.homeDirectory}/.cache";
      configHome = "${config.home.homeDirectory}/.config";
      dataHome = "${config.home.homeDirectory}/.local/share";
      stateHome = "${config.home.homeDirectory}/.local/state";
    };

    # Set environment variables
    home.sessionVariables = {
      # Base XDG directories
      XDG_CACHE_HOME = config.xdg.cacheHome;
      XDG_CONFIG_HOME = config.xdg.configHome;
      XDG_DATA_HOME = config.xdg.dataHome;
      XDG_STATE_HOME = config.xdg.stateHome;
      XDG_RUNTIME_DIR = "/run/user/$(id -u)";

      # User directories
      XDG_DESKTOP_DIR = config.xdg.userDirs.desktop;
      XDG_DOCUMENTS_DIR = config.xdg.userDirs.documents;
      XDG_DOWNLOAD_DIR = config.xdg.userDirs.download;
      XDG_MUSIC_DIR = config.xdg.userDirs.music;
      XDG_PICTURES_DIR = config.xdg.userDirs.pictures;
      XDG_PUBLICSHARE_DIR = config.xdg.userDirs.publicShare;
      XDG_TEMPLATES_DIR = config.xdg.userDirs.templates;
      XDG_VIDEOS_DIR = config.xdg.userDirs.videos;

      # Additional XDG-related variables
      LESSHISTFILE = "/tmp/less-hist";
      PARALLEL_HOME = "${config.xdg.configHome}/parallel";
      SCREENRC = "${config.xdg.configHome}/screen/screenrc";
      ZSH_AUTOSUGGEST_STRATEGY = "history completion";

      # History configuration // explicit to not nuke history
      HISTFILE = "\${HISTFILE:-\$HOME/.zsh_history}";
      HISTSIZE = "10000";
      SAVEHIST = "10000";
      setopt_EXTENDED_HISTORY = "true";
      setopt_INC_APPEND_HISTORY = "true";
      setopt_SHARE_HISTORY = "true";
      setopt_HIST_EXPIRE_DUPS_FIRST = "true";
      setopt_HIST_IGNORE_DUPS = "true";
      setopt_HIST_IGNORE_ALL_DUPS = "true";
    };
  };
}
