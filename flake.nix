{
  description = "Nix & home-manager configuration for HyDE, an Arch Linux based Hyprland desktop";

  inputs = {
    # Hydenix's nixpkgs
    hydenix-nixpkgs.url = "github:nixos/nixpkgs/6c5963357f3c1c840201eda129a99d455074db04";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "hydenix-nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    { ... }@hydenix-pre-inputs:
    let
      # TODO: multi system support?
      system = "x86_64-linux";

      hydenix-inputs = hydenix-pre-inputs // {
        lib = {
          overlays = import ./hydenix/sources/overlay.nix;
          nixOsModules = import ./hydenix/modules/system;
          homeModules = import ./hydenix/modules/hm;
          iso = import ./lib/iso/default.nix;
          mkTheme = import ./hydenix/sources/themes/utils/mkTheme.nix;
          inherit system;
        };
      };

      defaultConfig = import ./lib/config {
        inherit hydenix-inputs;
      };

      # Create VM variant of the NixOS configuration
      vmConfig = import ./lib/vms/nixos-vm.nix {
        nixosConfiguration = defaultConfig;
        inherit hydenix-inputs;
      };

      isoConfig = hydenix-inputs.lib.iso {
        inherit hydenix-inputs;
      };

    in
    {
      lib = hydenix-inputs.lib;

      templates = {
        default = {
          path = ./template;
          description = "Hydenix template";
          welcomeText = ''
            ```             _    _           _            _
            | |  | |         | |          (_)
            | |__| |_   _  __| | ___ _ __  ___  __
            |  __  | | | |/ _` |/ _ \ '_ \| \ \/ /
            | |  | | |_| | (_| |  __/ | | | |>  <
            |_|  |_|\__, |\__,_|\___|_| |_|_/_/\_\
                    __/ |
                    |___/       ❄️ Powered by Nix ❄️
            ```
            1. edit `configuration.nix` with your preferences for hydenix
              - visit https://github.com/richen604/hydenix for module documentation
            2. run `sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix`
            3. `git init && git add .` (flakes have to be managed via git)
            4. run any of the packages in your new `flake.nix`
              - for rebuild, use `sudo nixos-rebuild switch --flake .`
            5. DON'T FORGET: change your password for all users with `passwd` from initialPassword set in `configuration.nix`
            6. NOTE: After rebuild, the first boot may take a while depending on how many `hydenix.hm.themes` are enabled, as the system generates cache.
          '';
        };
      };

      packages.${system} = {
        # Use the VM configuration as default
        default = vmConfig.config.system.build.vm;

        # Original NixOS configuration
        nixos = defaultConfig.config.system.build.toplevel;

        # Explicitly named VM configuration
        nixos-vm = vmConfig.config.system.build.vm;

        # ISO configuration
        iso = isoConfig.build-iso;

        # Add the burn-iso script as a package
        burn-iso = isoConfig.burn-iso;
      };

      devShells.${system}.default = import ./lib/dev-shell.nix { inherit hydenix-inputs; };
    };
}
