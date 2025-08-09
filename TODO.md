
# todo

## now

- feat: update hyde
  - feat(hyde-update): update fish config in shell.nix
  - feat(hyde-update): update zsh config in zsh.zsh, new config root is .config/zsh
  - feat(hyde-update): update hyprlock config
  - feat(hyde-update): remove oled.frag
  - feat(hyde-update): update satty config, set as default?
  - feat(hyde-update): update cava path
- docs: options.md use hydenix.hm.theme as an example instead of hydenix.hm.hyprland

## next

- docs: remove doc for overlays on theme for now i think unless i can fix it
 - adding the overlay causes `pkgs.hydenix.hyde` to disappear lol
- feat: new themes to build
- feat: move hyprlock to hyprland module, swaylock should just be swaylock module
  - assertion to not have both enabled
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
- docs: documentation generation using nixosOptionsDoc
- refactor: revise module hierarchy to be more clear and concise?
- feat: spicetify theme support? flatpak?

// docs & onboarding

- docs: first-boot checklist (set password, run `hyde-shell reload`) + keybindings/workflows cheat sheet
- docs: uninstall/rollback guide + break-glass steps if Hyprland fails (switch TTY, disable module, rebuild)
- docs: "add a theme" contributor guide + PR template
- docs: generate option docs via `nixosOptionsDoc` and publish to GitHub Pages
