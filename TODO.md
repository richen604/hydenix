
# todo

## done

## now

- feat: new themes to build

## next

- refactor: rename all overlays so there is no namespace nesting
- feat: home-manager configuration in flake

## 5.0.0

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
- hm.hyprland should have more warnings related to config overrides, i think
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
