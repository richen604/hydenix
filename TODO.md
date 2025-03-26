
# todo / roadmap

## priority

- [ ] docs: fix some docs related to options and related to #73
- [ ] fix: hyprlock supposed to have a background?
  - [ ] still doesnt work on rebuild/first boot (tied to hyde-shell reload)
- [ ] fix: boot module grub is not working?
- [ ] fix: hyde-shell compgen is not working, limits hyde usage

## iso builder

- [ ] feat: iso builder should give a copy of the iso to the user on install
- [ ] feat: iso builder automated install should have more clear options, not just configuration.nix
- [ ] feat: iso builder should handle nvme drives (breaks on setting partitions because 1)
- [ ] feat: iso builder should handle grub and systemd
- [ ] feat: iso builder should tell user exact steps of auto installer, reflect that in the readme
- [ ] fix: iso builder should prompt to edit hostname in flake.nix
- [ ] feat: Completed iso builder

## config.toml integration

- [ ] feat: hyde config.toml module and options in hyde.nix
- [ ] feat: other program configuration should determine hyde config.toml options
- [ ] feat: extend hyde config.toml options for more nix integration

## hyprland.conf

- [ ] feat: more options in hyprland.nix
- [ ] feat: other program configuration should determine hyprland.conf options

## hypridle

- [ ] feat: hypridle module and options

## hyprlock

- [ ] feat: better hyprlock options

## uncategorized

- [ ] fix: rebuild properly changes theme during runtime
- [ ] feat: is code the default EDITOR?
- [ ] feat: cleanupOnDisable activation script and option
- [ ] fix: slight flashing on rebuild

## CI

- [ ] ci: fix iso builder release flake check

## Future Enhancements

- [ ] Ecosystem
  - [ ] feat: Add spicetify support via declarative flatpak
  
  - [ ] feat: Create sddm-hyprland
  - [ ] feat: Integrate hydepanel from rubin
  - [ ] feat: Add telegram theme support
  - [ ] feat: Add zed theme support
  - [ ] feat: Add obsidian theme support
  - [ ] feat: Add terminal-emulators support
  - [ ] feat: Add updated HyDE/code-wallbash nix support
- [ ] feat: full nixos config & full home-manager config
- [ ] feat: Set NIX-PATH to template flake location

## Hyde repo

- [ ] hyde-shell reload requires display, unable to run in activation scripts
- [ ] caffiene mode resets on hyde-shell reload

- [ ] hyde themes should precache things, there is no reason each user should have to build cache
This will heavily improve performance of first boot, as swwwallcache is not built
This feature would be outside of hydenix, most likely a PR to both theme maintainers and hyde