{
  description = "Nix & home-manager configuration for HyDE, an Arch Linux based Hyprland desktop";

  inputs = {
    # Hydenix's nixpkgs
    hydenix-nixpkgs.url = "github:nixos/nixpkgs/00b574b1ba8a352f0601c4dde4faff4b534ebb1e";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "hydenix-nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Nix-index-database - for comma and command-not-found
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "hydenix-nixpkgs";
    };

    hyde = {
      url = "github:HyDE-Project/HyDE/cc76f032e090b84c367c11a4c1b326be76a9fa7e";
      flake = false;
    };
  };

  outputs =
    inputs@{ hydenix-nixpkgs, ... }:
    let
      system = "x86_64-linux";

      # Create lib attribute that template expects
      lib = {
        inherit system;
        overlays = import ./hydenix/sources/overlay.nix { inherit inputs; };
        nixOsModules = ./hydenix/modules/system;
        homeModules = ./hydenix/modules/hm;
      };

      # Internal inputs for building packages and configurations
      hydenix-inputs = inputs // {
        inherit lib;
      };

      defaultConfig = import ./lib/config {
        inherit hydenix-inputs;
      };

      # Create VM variant of the NixOS configuration
      vmConfig = import ./lib/vms/nixos-vm.nix {
        nixosConfiguration = defaultConfig;
        inherit hydenix-inputs;
      };

      demoVmConfig = import ./lib/vms/demo-vm.nix {
        inherit hydenix-inputs;
      };

    in
    {
      # Main API that template uses
      # Will be depreciated in the next api update
      inherit lib;

      # Direct module access
      homeModules.default = ./hydenix/modules/hm;
      nixosModules.default = ./hydenix/modules/system;

      overlays.default = import ./hydenix/sources/overlay.nix { inherit inputs; };

      templates.default = {
        path = ./template;
        description = "Template for hydenix configuration";
      };

      nixosConfigurations.default = defaultConfig;

      packages.${system} = {
        # Use the VM configuration as default
        default = vmConfig.config.system.build.vm;

        # WIP: For a future demo installation & usage video
        demo-vm = demoVmConfig.config.system.build.vm;

        # Helper to manage hyde updates
        hyde-update = import ./lib/hyde-update { inherit hydenix-inputs; };
      };

      devShells.${system}.default = import ./lib/dev-shell.nix { inherit hydenix-inputs; };
    };
}
