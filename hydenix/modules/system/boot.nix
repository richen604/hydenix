{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.hydenix.boot;
in
{
  options.hydenix.boot = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hydenix.enable;
      description = "Enable boot module";
    };

    useSystemdBoot = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to use systemd-boot (true) or GRUB (false)";
    };

    grubTheme = lib.mkOption {
      type = lib.types.enum [
        "Retroboot"
        "Pochita"
      ];
      default = "Retroboot";
      description = "GRUB theme to use, use either `Retroboot` or `Pochita`";
    };

    grubExtraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Additional configuration for GRUB";
    };

    kernelPackages = lib.mkOption {
      type = lib.types.attrs;
      default = pkgs.linuxPackages_zen;
      description = "Kernel packages to use";
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelPackages = cfg.kernelPackages;
      loader =
        if cfg.useSystemdBoot then
          {
            # systemd-boot configuration
            systemd-boot = {
              enable = true;
              consoleMode = "auto";
              editor = false; # Disable the GRUB editor for security
            };
            efi.canTouchEfiVariables = true;
          }
        else
          {
            # GRUB configuration
            grub = {
              enable = true;
              efiSupport = true;
              device = "nodev";
              useOSProber = true;
              theme =
                pkgs.hyde + "/share/grub/themes/" + (if cfg.grubTheme == "Pochita" then "Pochita" else "Retroboot");
              extraConfig = cfg.grubExtraConfig;
            };
            efi.canTouchEfiVariables = true;
          };
    };
  };
}
