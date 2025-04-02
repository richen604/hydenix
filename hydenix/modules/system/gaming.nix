{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.gaming;
in
{
  options.hydenix.gaming = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.enable;
      description = "Enable gaming module";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mangohud # Performance monitoring overlay for games
      lutris # Game manager for Linux
    ];

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
