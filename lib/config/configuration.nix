{
  inputs,
  ...
}:
let
  hydenix-pkgs = import inputs.hydenix-nixpkgs {
    inherit (inputs.lib) system;
    config.allowUnfree = true;
    overlays = [
      inputs.lib.overlays
    ];
  };
in
{

  nixpkgs.pkgs = hydenix-pkgs;

  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    inputs.lib.nixOsModules
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    users."hydenix" =
      { ... }:
      {
        imports = [
          inputs.lib.homeModules
          ./home.nix

          # Nix-index-database - for comma and command-not-found
          inputs.nix-index-database.homeModules.nix-index
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

  system.stateVersion = "25.05";
}
