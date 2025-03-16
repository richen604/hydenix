{
  description = "Nix & home-manager configuration for HyDE, an Arch Linux based Hyprland desktop";

  inputs = {
    # Hydenix's nixpkgs
    hydenix-nixpkgs.url = "github:nixos/nixpkgs/573c650e8a14b2faa0041645ab18aed7e60f0c9a";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "hydenix-nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "hydenix-nixpkgs";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "hydenix-nixpkgs";
  };

  outputs =
    { ... }@inputs:
    let
      system = "x86_64-linux";

      # Hydenix's pkgs instance
      pkgs = import inputs.hydenix-nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkConfig = import ./lib/mkConfig.nix {
        inherit
          inputs
          pkgs
          system
          ;
      };

      defaultConfig = mkConfig {
        userConfig = import ./config.nix;
        extraInputs = { };
      };
    in
    {
      # Main config builder
      lib = {
        inherit mkConfig;
      };

      templates = {
        default = {
          path = ./template;
          description = "Hydenix template";
          welcomeText = ''
            ```
             _    _           _            _
            | |  | |         | |          (_)
            | |__| |_   _  __| | ___ _ __  ___  __
            |  __  | | | |/ _` |/ _ \ '_ \| \ \/ /
            | |  | | |_| | (_| |  __/ | | | |>  <
            |_|  |_|\__, |\__,_|\___|_| |_|_/_/\_\
                    __/ |
                    |___/       ❄️ Powered by Nix ❄️
            ```
            1. edit `config.nix` with your preferences
            2. run `sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix`
            3. `git init && git add .` (flakes have to be managed via git)
            4. run any of the packages in your new `flake.nix`
              - for rebuild, use `sudo nixos-rebuild switch --flake .`
              - for vm, use `nix run .`
          '';
        };
      };

      nixosConfigurations.nixos = defaultConfig.nixosConfiguration;
      nixosConfigurations.${defaultConfig.userConfig.host} = defaultConfig.nixosConfiguration;

      packages.${system} = {
        # generate-config script
        gen-config = pkgs.writeShellScriptBin "gen-config" (builtins.readFile ./lib/gen-config.sh);

        # defaults to nix-vm
        default = defaultConfig.nix-vm.config.system.build.vm;

        # NixOS activation packages
        hydenix = defaultConfig.nixosConfiguration.config.system.build.toplevel;

        # Home activation packages
        hm = defaultConfig.homeConfigurations.${defaultConfig.userConfig.username}.activationPackage;
        hm-generic =
          defaultConfig.homeConfigurations."${defaultConfig.userConfig.username}-generic".activationPackage;

        # EXPERIMENTAL VM BUILDERS
        arch-vm = defaultConfig.arch-vm;
        fedora-vm = defaultConfig.fedora-vm;

        # Add the ISO builder
        iso = defaultConfig.installer.iso;
        burn-iso = defaultConfig.installer.burn-iso;
      };

      devShells.${system}.default = import ./lib/dev-shell.nix { inherit pkgs; };
    };
}
