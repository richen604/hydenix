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
    hydenix-inputs.nixos-hardware.nixosModules.common-cpu-intel
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

          # Nix-index-database - for comma and command-not-found
          hydenix-inputs.nix-index-database.hmModules.nix-index
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
