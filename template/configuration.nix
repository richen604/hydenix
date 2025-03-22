{
  inputs,
  ...
}:
let
  # Package declaration
  # ---------------------

  pkgs = import inputs.hydenix.inputs.hydenix-nixpkgs {
    inherit (inputs.hydenix.lib) system;
    config.allowUnfree = true;
    overlays = [
      inputs.hydenix.lib.overlays
    ];

    # Include your own package set to be used eg. pkgs.userPkgs.bash
    userPkgs = inputs.nixpkgs {
      config.allowUnfree = true;
    };
  };
in
{

  # Set pkgs for hydenix globally, any file that imports pkgs will use this
  nixpkgs.pkgs = pkgs;

  imports = [
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    inputs.hydenix.lib.nixOsModules
    ./modules/system
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    #! EDIT THIS USER (must match users defined below)
    users."hydenix" =
      { ... }:
      {
        imports = [
          inputs.hydenix.lib.homeModules
          ./modules/hm
        ];
      };
  };

  # IMPORTANT: Customize the following values to match your preferences
  hydenix = {
    enable = true; # Enable the Hydenix module

    #! EDIT THESE VALUES
    hostname = "hydenix"; # Change to your preferred hostname
    timezone = "America/Vancouver"; # Change to your timezone
    locale = "en_CA.UTF-8"; # Change to your preferred locale

    /*
      Optionally edit the below values, or leave to use hydenix defaults
      visit ./modules/hm/default.nix for more options

      audio.enable = true;
      boot = {
        enable = true;
        useSystemdBoot = true; - false for GRUB
        grubTheme = pkgs.hydenix.grub-retroboot; - or pkgs.hydenix.grub-pochita
        grubExtraConfig = "";
        kernelPackages = pkgs.linuxPackages_zen;
      };
      hardware.enable = true;
      network.enable = true;
      nix.enable = true;
      sddm = {
        enable = true;
        theme = pkgs.hydenix.sddm-candy; # or pkgs.hydenix.sddm-corners
      };
      system.enable = true;
    */
  };

  #! EDIT THESE VALUES (must match users defined above)
  users.users.hydenix = {
    isNormalUser = true; # Regular user account
    initialPassword = "hydenix"; # Default password (CHANGE THIS after first login with passwd)
    extraGroups = [
      "wheel" # For sudo access
      "networkmanager" # For network management
      "video" # For display/graphics access
      # Add other groups as needed
    ];
    shell = pkgs.zsh; # Change if you prefer a different shell
  };
}
