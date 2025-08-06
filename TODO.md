
# todo / roadmaphydenix-inputs.lib

## now / note

- docs: options.md use hydenix.hm.theme as an example instead of hydenix.hm.hyprland
- feat: hyprland flake packages rather than nixpkgs
- feat: new themes to build
- feat: move hyprlock to hyprland module, swaylock should just be swaylock module
  - assertion to not have both enabled

- feat: update hyde

## next api update

- refactor: removed hydenix.lib to standardize outputs, hydenix nixOsModules to nixosModules
- fix: nix-index should be a module in hydenix only, its declared twice
- fix: rename nix-index home-manager module whatever new name
- feat: user now owns their nixosSystem, depreciated hydenix-nixpkgs.lib.nixosSystem
- feat: hydenix follows its own nixpkgs, no userPkgs overlays, template hydenix follows nixpkgs by default
  - update docs to reflect this
- feat: vscode-nix-ide part of editors, enabled by default
- feat: update.sh for themes, map name to hash (check daily), passThru update.sh caller github action
  - <https://github.com/NixOS/nixpkgs/blob/nixos-25.05/pkgs/by-name/ad/adi1090x-plymouth-themes/update.sh>

## backlog

- finish demo-vm for video
- docs: documentation generation?
- feat: config.toml options
- refactor: revise module hierarchy to be more clear and concise
- feat: assertions for common requirements
- feat: spicetify theme support? flatpak?
- chore: review bug template to make it more clear (easier with scripts?)

## future

- binary cache when i build it

## notes

- using nixos-anywhere to install hydenix:
  - must be part of the template flake or a new template flake, as it will be used for the user configuration
  - document disko configuration clearly, the issue is ive never used disko
  - most likely will need its own video installation guide
- cleanupOnDisable activation script and option
- nh by default?

## Hyde repo

- theme makers should be able to precache walls before patching
  - requires arch vm (w/ commit hash param and snapshot functionality)
  - hyde-theme-starter to implement /lib with swwwallcache and wallbash
    - whatever generates dcols and wallcaches
  - hyde repo themepatcher implement reading for .cache in theme to cp cache and skip
  - validation
    - themepatcher should still generate on missing cache per wall
  - PR's for all themes to bring cache
  - hydenix implementation (just home.file mutable)
  - FUTURE: wallbash should be a seperate lib
