
# todo

## now

## next

- feat: new themes to build

- fix: hydenix.hm.hyprland options with presets should by type str to allow for overrides, example should show default lists
- feat: move hyprlock to hyprland module, swaylock should just be swaylock module
  - assertion to not have both enabled
- feat: hyde config.toml options
- feat: extending more options for feature parity with hyde
  - fastfetch
  - hyprlock
  - rofi
  - waybar
- docs: remove doc for overlays on theme for now i think unless i can fix it
  - adding the overlay causes `pkgs.hydenix.hyde` to disappear lol
- feat: update.sh for themes, map name to hash (check daily), passThru update.sh caller github action
  - <https://github.com/NixOS/nixpkgs/blob/nixos-25.05/pkgs/by-name/ad/adi1090x-plymouth-themes/update.sh>
- feat: vscode-nix-ide part of editors, enabled by default
- fix: i don't think .config/waybar/modules is supposed to be set anymore

## 5.0.0

- fix: removed hydenix-inputs from template/configuration.nix
- refactor: removed hydenix.lib to standardize outputs, hydenix nixOsModules to nixosModules
- fix: nix-index should be a module in hydenix only, its declared twice
- fix: rename nix-index home-manager module whatever new name
- feat: user now owns their nixosSystem, depreciated hydenix-nixpkgs.lib.nixosSystem
- feat: hydenix follows its own nixpkgs, no userPkgs overlays, template hydenix follows nixpkgs by default
  - update docs to reflect this, as users can remove

## backlog

- complete demo video after 5.0
- fix: wallbash for code
- feat: assertions for common requirements
- chore: review bug template to make it more clear (easier with scripts?)
- feat: enhance `mutable` Home Manager option for `home.file`, `xdg.configFile`, `xdg.dataFile`:
  - Introduce `mutable.enable` (boolean) and `mutable.mode` (enum: `initOnly`, `replace`) for fine-grained control over file copying behavior.
  - Implement custom cleanup logic for `mutable.enable = true` files, ensuring they are removed when no longer declared in the configuration.
    - Largest hurdle is if users remove the module the stale files will exist as mutable.nix is no longer imported
  - Ensure this cleanup mechanism supports Home Manager generation rollbacks.
  - create a simple flake to test and export as a full module

## future

- binary cache when i build it

## notes

- using nixos-anywhere to install hydenix:
  - must be part of the template flake or a new template flake, as it will be used for the user configuration
  - document disko configuration clearly, the issue is ive never used disko
  - most likely will need its own video installation guide
- nh by default?
- docs: documentation generation using nixosOptionsDoc
- refactor: revise module hierarchy to be more clear and concise?
- feat: spicetify theme support? flatpak?
