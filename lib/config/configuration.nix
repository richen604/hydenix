{
  hydenix-inputs,
  ...
}:
let
  hydenix-pkgs = import hydenix-inputs.hydenix-nixpkgs {
    inherit (hydenix-inputs.lib) system;
    config.allowUnfree = true;
    overlays = [
      hydenix-inputs.lib.overlays
    ];
  };
in
{

  nixpkgs.pkgs = hydenix-pkgs;

  imports = [
    hydenix-inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    hydenix-inputs.lib.nixOsModules

    # === GPU-specific configurations ===

    /*
      For drivers, we are leveraging nixos-hardware
      Most common drivers are below, but you can see more options here: https://github.com/NixOS/nixos-hardware
    */

    #! EDIT THIS SECTION
    # For NVIDIA setups
    # hydenix-inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    # hydenix-inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonmodeset

    # For AMD setups
    # hydenix-inputs.nixos-hardware.nixosModules.common-gpu-amd

    # === CPU-specific configurations ===
    # For AMD CPUs
    # hydenix-inputs.nixos-hardware.nixosModules.common-cpu-amd
    # hydenix-inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate

    # For Intel CPUs
    hydenix-inputs.nixos-hardware.nixosModules.common-cpu-intel

    # === Other common modules ===
    hydenix-inputs.nixos-hardware.nixosModules.common-pc
    hydenix-inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit hydenix-inputs;
    };

    users."hydenix" =
      { ... }:
      {
        imports = [
          hydenix-inputs.lib.homeModules
          ./home.nix
        ];
      };
  };

  hydenix = {
    enable = true;
    hostname = "hydenix";
    timezone = "America/Vancouver";
    locale = "en_CA.UTF-8";
  };

  users.users.hydenix = {
    isNormalUser = true;
    initialPassword = "hydenix";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    shell = hydenix-pkgs.zsh;
  };
}
