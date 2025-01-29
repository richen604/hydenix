# hydenix todo.md

## hyprdots to hyde - hydenix 2.0 🏃

as hyprdots is being depreciated, work needs to be done to migrate to hyde.
i will also take this opportunity to add some needed design changes to hydenix.

this means hydenix 2.0!

what needs to be done? listing things below, by no means in order.
if you have any additional ideas, feel free to let me know!

### progress tracker

core package changes:

- [ ] packages to create:
  - [ ] hyde
  - [ ] sddm themes
  - [ ] hyde-fonts
  - [x] hyde-gallery
  - [ ] pokemon-colorscripts -> [pokego](https://github.com/rubiin/pokego)
  - [ ] vscode-wallbash -> code-wallbash
  - [ ] wallbash-gtk
- [ ] reviewing hyprdots -> hyde packages
  - removing:
    - [ ] swaylock*
    - [ ] pokemon-colorscripts
  - adding:
    - [ ] hyprlock
    - [ ] grim
    - [ ] satty
    - [ ] hyprsunset
    - [ ] noto-fonts-emoji
    - [ ] unzip
    - [ ] nwg-displays
    - [ ] pokego
    - [ ] starship
    - [ ] fish
    - [ ] hypridle
    - [ ] wttrbar
    - [ ] python-requests
    - [ ] ddccui
    - [ ] hyprgui-bin
- [ ] modules:
  - [ ] zsh
  - [ ] hyde module
    - for setting hyprland hyde.conf settings with hydenix programs
    - for hyde config.toml options

hydenix design changes:

- [ ] modularize hydenix programs
  - [ ] easy disable option
  - [ ] initial home.file calls for configs
- [ ] mutable.nix performance improvements, to be used for *mutable state* only
- [ ] arcStore improvements:
  - [ ] theme-name -> theme-arcs for easier commit hashes
  - [ ] sha256 hash management (?)
  - [ ] extensibility
  - [ ] allow user to define their own theme-arcs
- [ ] custom theme support
  - [ ] add mkTheme, mkFont, etc to hydenix lib for user use
  - [ ] non-nix way vs nix way
    - [ ] allow theme arcs undefined with warning, will be called by hyde scripts
- [ ] user ownership of mkConfig and all hydenix host builds
- [ ] config.nix migration
  - [ ] module system options instead of file
  - [ ] hydenix.enable!
  - [ ] template will have proper file structure

## misc todo (future) ⏳

hyde main:

- [ ] spicetify
- [ ] add missing hyde-gallery themes
- [ ] downgrade dolphin to qt5 for icon support

hyde ecosystem:

- [ ] sddm-hyprland
- [ ] hyprpanel
- [ ] hydepanel from rubin
- [ ] wallbash-extras
  - [ ] telegram
  - [ ] zed
  - [ ] obsidian
  - [ ] terminal-emulators

new hydenix features:

- [ ] finish iso builder
- [ ] revise readme
- [ ] full documentation for hydenix hyde-site
- [ ] wallbash/swwwallcache on nix build
  - [ ] modularize wallbash
  - [ ] modularize swwwallcache

unorganized:

- [ ] feat: waybar option in config.nix
- [ ] feat: set NIX-PATH to template flake location?
- [ ] feat: revise hosts to be more modular
- [ ] feat: add home-manager only "host" for non-nixos
- [ ] revisit non-nix vms
- [ ] feat: depreciate home.file calls when possible
