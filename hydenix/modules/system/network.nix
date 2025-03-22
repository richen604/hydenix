{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.network;
in
{
  options.hydenix.network = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.enable;
      description = "Enable network module";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      networkmanager
      networkmanagerapplet
    ];

    networking.networkmanager.enable = true;
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        # SSH
        22
      ];
      allowedUDPPorts = [
        # DHCP
        68
        546
      ];
    };
  };
}
