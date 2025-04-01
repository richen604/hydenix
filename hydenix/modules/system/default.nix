{ lib, config, ... }:

let
  cfg = config.hydenix;
in
{
  imports = [
    ./audio.nix
    ./boot.nix
    ./hardware.nix
    ./network.nix
    ./nix.nix
    ./sddm.nix
    ./system.nix
    ./gaming.nix
  ];

  options.hydenix = {
    enable = lib.mkEnableOption "Enable Hydenix modules globally";

    hostname = lib.mkOption {
      type = lib.types.str;
      description = "Hostname";
      example = "hydenix";
    };

    timezone = lib.mkOption {
      type = lib.types.str;
      description = "Timezone";
      example = "America/Vancouver";
    };

    locale = lib.mkOption {
      type = lib.types.str;
      description = "Locale";
      example = "en_CA.UTF-8";
    };
  };

  config = {
    hydenix.enable = lib.mkDefault false;

    # Assertions to check if required variables are set when hydenix is enabled
    assertions = lib.mkIf cfg.enable [
      {
        assertion = cfg.hostname != "";
        message = "hydenix.hostname must be set";
      }
      {
        assertion = cfg.timezone != "";
        message = "hydenix.timezone must be set";
      }
      {
        assertion = cfg.locale != "";
        message = "hydenix.locale must be set";
      }
    ];

    # Configuration for variables (only applied when hydenix is enabled)
    time.timeZone = lib.mkIf cfg.enable cfg.timezone;
    i18n.defaultLocale = lib.mkIf cfg.enable cfg.locale;
    networking.hostName = lib.mkIf cfg.enable cfg.hostname;

    system.stateVersion = "25.05";
  };
}
