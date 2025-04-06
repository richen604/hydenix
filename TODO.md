
# todo / roadmap

## priority

- [ ] fix: boot module grub is not working?
- [ ] feat: spicetify theme support with declarative flatpak
- [ ] feat: add Code Garden theme
- [ ] chore: review bug template
- [ ] docs: better documented drivers in template flake, plus nvidia default settings
- [ ] feat: hyprland via home-manager
  - support plugins
  - use hyprland flake package

## iso builder

- [ ] feat: iso builder should give a copy of the iso to the user on install
- [ ] feat: iso builder automated install should have more clear options, not just configuration.nix
- [ ] feat: iso builder should tell user exact steps of auto installer, reflect that in the readme
- [ ] fix: iso builder should prompt to edit hostname in flake.nix
- [ ] refactor: expand iso installer sections to be more clear and concise
- [ ] feat: iso installer section option to clone your own personal flake from github and use that instead of the hyde template
- [ ] feat: Completed iso builder

## config.toml integration

- [ ] feat: hyde config.toml module and options in hyde.nix
- [ ] feat: other program configuration should determine hyde config.toml options
- [ ] feat: extend hyde config.toml options for more nix integration

## hyprland.conf

- [ ] feat: more options in hyprland.nix
- [ ] feat: other program configuration should determine hyprland.conf options eg

## hypridle

- [ ] feat: hypridle module and options
- [ ] feat: use dpms-off instead of hyprctl dispatch dpms off in hypridle

## hyprlock

- [ ] feat: better hyprlock options

## uncategorized

- [ ] feat: is code the default EDITOR? change editors.nix
   yes, code-oss though, not code
- [ ] feat: cleanupOnDisable activation script and option

## CI

- [ ] ci: fix iso builder release flake check

## Future Enhancements

- [ ] Ecosystem
  - [ ] feat: Create sddm-hyprland
  - [ ] feat: Integrate hydepanel from rubin
  - [ ] feat: Add telegram theme support
  - [ ] feat: Add zed theme support
  - [ ] feat: Add obsidian theme support
  - [ ] feat: Add terminal-emulators support
  - [ ] feat: Add updated HyDE/code-wallbash nix support
- [ ] feat: full nixos config & full home-manager config
- [ ] feat: Set NIX-PATH to template flake location

## Non-NixOS

https://github.com/jpikl/pm for non-nixos packages
specific scripts for each non-nixos distro options, ideally one script for all packages using pm
nixGL wrapping for all prorgrams, well documented in the configuration as users will need to edit it. combine with any driver setup

## Hyde repo

- [ ] hyde-shell reload requires display, unable to run in activation scripts
- [ ] caffiene mode resets on hyde-shell reload
- [ ] some yubikey touch detection for hyprlock and waybar <https://github.com/maximbaz/yubikey-touch-detector>

- [ ] hyde themes should precache things, there is no reason each user should have to build cache
This will heavily improve performance of first boot, as swwwallcache is not built
This feature would be outside of hydenix, most likely a PR to both theme maintainers and hyde