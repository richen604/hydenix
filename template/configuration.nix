{
  inputs,
  ...
}:
let
  # ========================================
  # PACKAGE CONFIGURATION
  # ========================================
  # This sets up the package system with proper overlays
  # Most users won't need to modify this section

  pkgs = import inputs.hydenix.inputs.hydenix-nixpkgs {
    inherit (inputs.hydenix.lib) system;
    config.allowUnfree = true;
    overlays = [
      inputs.hydenix.lib.overlays
      (final: prev: {
        userPkgs = import inputs.nixpkgs {
          config.allowUnfree = true;
        };
      })
    ];
  };
in
{
  # Set pkgs for hydenix globally
  nixpkgs.pkgs = pkgs;

  # ========================================
  # MODULE IMPORTS
  # ========================================
  imports = [
    # Required modules - don't modify unless you know what you're doing
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    inputs.hydenix.lib.nixOsModules
    ./modules/system # Your custom system modules
    ./hardware-configuration.nix # Auto-generated hardware config

    # ========================================
    # HARDWARE CONFIGURATION
    # ========================================
    # Uncomment the lines that match your hardware
    # Run `lshw -short` or `lspci` to identify your hardware

    # ----------------------------------------
    # GPU Configuration (choose one)
    # ----------------------------------------

    # NVIDIA GPUs:
    # 1. Uncomment the line below:
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    #
    # 2. If you have hybrid graphics (laptop), also set these:
    # hardware.nvidia.prime.intelBusId = "PCI:0:2:0";  # Run: lspci | grep VGA
    # hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0"; # to get correct IDs
    #
    # 3. For newer cards, you might want open drivers:
    # hardware.nvidia.open = true;

    # AMD GPUs:
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-amd

    # ----------------------------------------
    # CPU Configuration (choose one)
    # ----------------------------------------

    # AMD CPUs:
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-amd

    # Intel CPUs (also enables Intel graphics):
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-intel

    # ----------------------------------------
    # Additional Hardware Modules
    # ----------------------------------------
    # Uncomment based on your system type:

    # For high-DPI displays (4K, etc.):
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-hidpi

    # For laptops:
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc-laptop

    # For SSD storage:
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc-ssd

    # For HDD storage:
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc-hdd
  ];

  # ========================================
  # HOME MANAGER CONFIGURATION
  # ========================================
  # This manages user-specific configurations (dotfiles, themes, etc.)
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    # ----------------------------------------
    # User Configuration
    # ----------------------------------------
    # REQUIRED: Change "hydenix" to your actual username
    # This must match the username you define in users.users below
    users."hydenix" =
      { ... }:
      {
        imports = [
          inputs.hydenix.lib.homeModules
          # Command-not-found and comma tool support
          inputs.nix-index-database.hmModules.nix-index
          ./modules/hm # Your custom home-manager modules
        ];
      };
  };

  # ========================================
  # USER ACCOUNT SETUP
  # ========================================
  # REQUIRED: This creates your user account
  # Change "hydenix" to your desired username (must match above)
  users.users.hydenix = {
    isNormalUser = true;
    # SECURITY: Change this password after first login with `passwd`
    initialPassword = "hydenix";

    # User groups (determines permissions):
    extraGroups = [
      "wheel" # Sudo access (admin privileges)
      "networkmanager" # Network configuration
      "video" # Graphics/display access
    ];

    # Default shell (options: pkgs.bash, pkgs.zsh, pkgs.fish)
    shell = pkgs.zsh;
  };

  # ========================================
  # HYDENIX CONFIGURATION
  # ========================================
  # Main configuration for the Hydenix desktop environment
  hydenix = {
    enable = true; # Enable Hydenix modules

    # ----------------------------------------
    # Basic System Settings (REQUIRED)
    # ----------------------------------------
    # REQUIRED: Set your computer's network name
    hostname = "hydenix"; # Change to something unique

    # REQUIRED: Set your timezone
    # Examples: "America/New_York", "Europe/London", "Asia/Tokyo"
    # Full list: `timedatectl list-timezones`
    timezone = "America/Vancouver";

    # REQUIRED: Set your locale/language
    # Examples: "en_US.UTF-8", "en_GB.UTF-8", "de_DE.UTF-8"
    locale = "en_CA.UTF-8";

    # ----------------------------------------
    # Optional Settings
    # ----------------------------------------
    # For more configuration options, see:
    # https://github.com/richen604/hydenix/blob/main/docs/options.md
  };

  # ----------------------------------------
  # System Version
  # ----------------------------------------
  # Don't change this unless you know what you're doing
  # This helps with system upgrades and compatibility
  system.stateVersion = "25.05";
}
