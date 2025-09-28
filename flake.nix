{
  description = "Nix & home-manager configuration for HyDE, an Arch Linux based Hyprland desktop";

  inputs = {
    # Hydenix's nixpkgs
    hydenix-nixpkgs.url = "github:nixos/nixpkgs/53614373268559d054c080d070cfc732dbe68ac4";

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
      url = "github:HyDE-Project/HyDE/168287f2f10e95a4a9a623c955c7e08147c48472";
      flake = false;
    };

    # HyDE related binaries
    hyq = {
      url = "github:richen604/hyprquery";
      inputs.nixpkgs.follows = "hydenix-nixpkgs";
    };
    hydectl = {
      url = "github:richen604/hydectl";
      inputs.nixpkgs.follows = "hydenix-nixpkgs";
    };
    hyde-ipc = {
      url = "github:richen604/hyde-ipc";
      inputs.nixpkgs.follows = "hydenix-nixpkgs";
    };
    hyde-config = {
      url = "github:richen604/hyde-config";
      inputs.nixpkgs.follows = "hydenix-nixpkgs";
    };

  };
  outputs =
    hydenix-inputs@{ hydenix-nixpkgs, ... }:
    let
      system = "x86_64-linux";

      # Create lib attribute that template expects
      lib = {
        inherit system;
        overlays = import ./hydenix/sources/overlay.nix hydenix-inputs;
        nixOsModules = ./hydenix/modules/system;
        homeModules = ./hydenix/modules/hm;
      };

      # Internal inputs for building packages and configurations
      inputs = hydenix-inputs // {
        inherit lib;
      };

      defaultConfig = import ./lib/config {
        inherit inputs;
      };

      # Create VM variant of the NixOS configuration
      vmConfig = import ./lib/vms/nixos-vm.nix {
        nixosConfiguration = defaultConfig;
        inherit inputs;
      };

      demoVmConfig = import ./lib/vms/demo-vm.nix {
        inherit inputs;
      };

    in
    {
      # Main API that template uses
      # Will be depreciated in the next api update
      inherit lib;

      # Direct module access
      homeModules.default = ./hydenix/modules/hm;
      nixosModules.default = ./hydenix/modules/system;

      overlays.default = import ./hydenix/sources/overlay.nix hydenix-inputs;

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
        hyde-update = import ./lib/hyde-update { inherit inputs; };

        # Add hyq, hydectl, hyde-ipc, and hyde-config for building
        hyq = inputs.hyq.packages.${system}.default;
        hydectl = inputs.hydectl.packages.${system}.default;
        hyde-ipc = inputs.hyde-ipc.packages.${system}.default;
        hyde-config = inputs.hyde-config.packages.${system}.default;
      };

      devShells.${system}.default = import ./lib/dev-shell.nix { inherit inputs; };
    };
}
