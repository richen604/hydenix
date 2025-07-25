
# todo / roadmap

## now / notes

- docs: improved configuration guide
- docs: better hardware configuration guide, no default hardware options
- feat: more hyprland options
  - explicit configuration
- feat: new themes to build

## next api update

- refactor: hydenix nixOsModules to nixosModules
- refactor: outputs more flexible
- fix: nix-index should be a module in hydenix only, its declared twice
- fix: rename nix-index home-manager module whatever new name
- feat: hydenix follows nixpkgs, no userPkgs overlays

## backlog

- finish demo-vm for video
- feat: config.toml options
- chore: remove iso builder and ci, close issue related to it in favor of (hyde)nixos-anywhere
- chore: remove old vm builder
- docs: better documented first edits
- refactor: revise module hierarchy to be more clear and concise
- feat: assertions for common requirements
- feat: spicetify theme support? flatpak?
- chore: review bug template to make it more clear (easier with scripts?)

## future

- binary cache when i build it

## notes

using nixos-anywhere to install hydenix

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
