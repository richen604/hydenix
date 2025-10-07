
# todo

## done

## now

- refactor: rename all overlays so there is no namespace nesting

## next

- feat: home-manager configuration in flake

## 5.0.0

feat!: 5.0 release

existing template has gone through a major overhaul, please read through all the breaking changes below. at worst generate a new template and copy your config over.

a restart or `nixos-rebuild boot` is required for this update

BREAKING CHANGES:

- updated hyde to f246f2a
- hyde now uses uwsm (`hydenix.hm.uwsm.enable` is true by default)
- hydenix no longer uses hyde's sddm themes as they rely on deprecated qt5 libraries, `sddm-astronaut` is now used instead by default
- <details><summary>hydenix template changes: (click to expand)</summary>

  (`template/flake.nix`)

  ```diff
  diff --git a/template/flake.nix b/template/flake.nix
  index 125f1e9..0ba0e9a 100644
  --- a/template/flake.nix
  +++ b/template/flake.nix
  @@ -2,31 +2,35 @@
    description = "template for hydenix";
  
    inputs = {
  -    # User's nixpkgs - for user packages
  +    # Your nixpkgs
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  
  -    # Hydenix and its nixpkgs - kept separate to avoid conflicts
  +    # Hydenix
      hydenix = {
        # Available inputs:
        # Main: github:richen604/hydenix
  -      # Dev: github:richen604/hydenix/dev
        # Commit: github:richen604/hydenix/<commit-hash>
  -      # Version: github:richen604/hydenix/v1.0.0
  +      # Version: github:richen604/hydenix/v1.0.0 - note the version may not be compatible with this template
        url = "github:richen604/hydenix";
  +      # uncomment the below if you know what you're doing, hydenix updates nixos-unstable every week or so
  +      # inputs.nixpkgs.follows = "nixpkgs";
      };
  
  -    # Nix-index-database - for comma and command-not-found
  -    nix-index-database = {
  -      url = "github:nix-community/nix-index-database";
  +    # Home Manager
  +    home-manager = {
  +      url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  +
  +    # Hardware Configuration's, used in ./configuration.nix. Feel free to remove if unused
  +    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    };
  
    outputs =
      { ... }@inputs:
     let
  -      hydenixConfig = inputs.hydenix.inputs.hydenix-nixpkgs.lib.nixosSystem {
  -        inherit (inputs.hydenix.lib) system;
  +      system = "x86_64-linux";
  +      hydenixConfig = inputs.nixpkgs.lib.nixosSystem {
  +        inherit system;
           specialArgs = {
             inherit inputs;
           };
  @@ -38,5 +42,6 @@
       in
       {
         nixosConfigurations.hydenix = hydenixConfig;
  +      nixosConfigurations.default = hydenixConfig;
       };
   }
  ```

  (`template/configuration.nix`)

  ```diff
  --- a/template/configuration.nix
  +++ b/template/configuration.nix
  @@ -5,17 +5,12 @@
  let
    # Package configuration - sets up package system with proper overlays
    # Most users won't need to modify this section
  -  pkgs = import inputs.hydenix.inputs.hydenix-nixpkgs {
  -    inherit (inputs.hydenix.lib) system;
  +  system = "x86_64-linux";
  +  pkgs = import inputs.nixpkgs {
  +    inherit system;
      config.allowUnfree = true;
      overlays = [
  -      inputs.hydenix.lib.overlays
  -      (final: prev: {
  -        userPkgs = import inputs.nixpkgs {
  -          inherit (pkgs) system;
  -          config.allowUnfree = true;
  -        };
  -      })
  +      inputs.hydenix.overlays.default
      ];
    };
  in
  @@ -24,8 +19,8 @@ in
 
   imports = [
     # hydenix inputs - Required modules, don't modify unless you know what you're doing
  -    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
  -    inputs.hydenix.lib.nixOsModules
  +    inputs.home-manager.nixosModules.home-manager
  +    inputs.hydenix.nixosModules.default
       ./modules/system # Your custom system modules
       ./hardware-configuration.nix # Auto-generated hardware config
   
  @@ -33,17 +28,17 @@ in
       # Run `lshw -short` or `lspci` to identify your hardware
   
       # GPU Configuration (choose one):
  -    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-nvidia # NVIDIA
  -    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-amd # AMD
  +    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia # NVIDIA
  +    # inputs.nixos-hardware.nixosModules.common-gpu-amd # AMD
   
       # CPU Configuration (choose one):
  -    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-amd # AMD CPUs
  -    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-intel # Intel CPUs
  +    # inputs.nixos-hardware.nixosModules.common-cpu-amd # AMD CPUs
  +    # inputs.nixos-hardware.nixosModules.common-cpu-intel # Intel CPUs
   
       # Additional Hardware Modules - Uncomment based on your system type:
  -    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-hidpi # High-DPI displays
  +    # inputs.nixos-hardware.nixosModules.common-hidpi # High-DPI displays
  +    # inputs.nixos-hardware.nixosModules.common-pc-laptop # Laptops
  +    # inputs.nixos-hardware.nixosModules.common-pc-ssd # SSD storage
     ];
   
     # If enabling NVIDIA, you will be prompted to configure hardware.nvidia
  @@ -68,8 +63,7 @@ in
         { ... }:
         {
           imports = [
  -          inputs.hydenix.lib.homeModules
  -          inputs.nix-index-database.hmModules.nix-index # Command-not-found and comma tool support
  +          inputs.hydenix.homeModules.default
             ./modules/hm # Your custom home-manager modules (configure hydenix.hm here!)
           ];
         };
  ```

</details>

## backlog

- feat: move hyprlock to hyprland module, swaylock should just be swaylock module
  - assertion to not have both enabled
- feat: extending more options for feature parity with hyde
  - fastfetch
  - hyprlock
  - rofi
  - waybar
- fix: i don't think .config/waybar/modules is supposed to be set anymore
- fix: remove duplicate udisks2 setup
- hm.hyprland should have more warnings related to config overrides
- feat: hyde config.toml options
- demo video? fix demo-vm
- fix: wallbash for code
- feat: assertions for common requirements
- chore: review bug template to make it more clear (easier with scripts?)
- feat: enhance `mutable` Home Manager option for `home.file`, `xdg.configFile`, `xdg.dataFile`:
  - introduce `mutable.enable` (boolean) and `mutable.mode` (enum: `initOnly`, `replace`) for fine-grained control over file copying behavior.
  - implement custom cleanup logic for `mutable.enable = true` files, ensuring they are removed when no longer declared in the configuration.
    - largest hurdle is if users remove the module the stale files will exist as mutable.nix is no longer imported
  - ensure this cleanup mechanism supports Home Manager generation rollbacks.
  - create a simple flake to test and export as a full module
- feat: spicetify theme support? flatpak?

## future?

- binary cache when i build it
- using nixos-anywhere to install hydenix:
  - must be part of the template flake or a new template flake, as it will be used for the user configuration
  - document disko configuration clearly, the issue is ive never used disko
  - most likely will need its own video installation guide
- nh by default?
- docs: documentation generation using nixosOptionsDoc <https://bmcgee.ie/posts/2023/03/til-how-to-generate-nixos-module-docs/>
- refactor: revise module hierarchy to be more clear and concise?
