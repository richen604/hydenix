
# todo

## now

- docs: restyled docs, moved docs to template/docs
- docs: options.md use hydenix.hm.theme as an example instead of hydenix.hm.hyprland

## next

- feat: hyprland flake packages rather than nixpkgs
- feat: new themes to build
- feat: move hyprlock to hyprland module, swaylock should just be swaylock module
  - assertion to not have both enabled
- feat: update hyde
- feat: update.sh for themes, map name to hash (check daily), passThru update.sh caller github action
  - <https://github.com/NixOS/nixpkgs/blob/nixos-25.05/pkgs/by-name/ad/adi1090x-plymouth-themes/update.sh>
- feat: vscode-nix-ide part of editors, enabled by default
- feat: hyde config.toml options
- feat: extending more options for feature parity with hyde
  - fastfetch
  - hyprlock
  - rofi
  - waybar

## 5.0.0

- refactor: removed hydenix.lib to standardize outputs, hydenix nixOsModules to nixosModules
- fix: nix-index should be a module in hydenix only, its declared twice
- fix: rename nix-index home-manager module whatever new name
- feat: user now owns their nixosSystem, depreciated hydenix-nixpkgs.lib.nixosSystem
- feat: hydenix follows its own nixpkgs, no userPkgs overlays, template hydenix follows nixpkgs by default
  - update docs to reflect this

## backlog

- finish demo-vm for video
- feat: assertions for common requirements
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
- docs: documentation generation?
- refactor: revise module hierarchy to be more clear and concise?
- feat: spicetify theme support? flatpak?
