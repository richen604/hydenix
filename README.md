###### _<div align="right"><sub>// design by t2</sub></div>_

<div align="center">

[![NixOS Unstable](https://img.shields.io/badge/NixOS-unstable-blue.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)
[![Release](https://img.shields.io/github/v/release/richen604/hydenix?style=flat-square)](https://github.com/richen604/hydenix/releases)
[![Last Commit](https://img.shields.io/github/last-commit/richen604/hydenix/main?style=flat-square)](https://github.com/richen604/hydenix/commits/main)
[![Nix Flake Check](https://github.com/richen604/hydenix/actions/workflows/flake-check.yml/badge.svg?style=flat-square)](https://github.com/richen604/hydenix/actions/workflows/flake-check.yml)

</div>

<div align = center>
  <a href="https://discord.gg/AYbJ9MJez7">
    <img alt="Dynamic JSON Badge" src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fdiscordapp.com%2Fapi%2Finvites%2FmT5YqjaJFh%3Fwith_counts%3Dtrue&query=%24.approximate_member_count&suffix=%20members&style=for-the-badge&logo=discord&logoSize=auto&label=The%20HyDe%20Project&labelColor=ebbcba&color=c79bf0">
  </a>
</div>

<!--
<img alt="Dynamic JSON Badge" src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fdiscordapp.com%2Fapi%2Finvites%2FmT5YqjaJFh%3Fwith_counts%3Dtrue&query=%24.approximate_member_count&suffix=%20members&style=for-the-badge&logo=discord&logoSize=auto&label=The%20HyDe%20Project&labelColor=ebbcba&color=c79bf0">

<img alt="Dynamic JSON Badge" src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fdiscordapp.com%2Fapi%2Finvites%2FmT5YqjaJFh%3Fwith_counts%3Dtrue&query=%24.approximate_presence_count&suffix=%20online&style=for-the-badge&logo=discord&logoSize=auto&label=The%20HyDe%20Project&labelColor=ebbcba&color=c79bf0">
-->

<div align="center">

![hyde_banner](https://raw.githubusercontent.com/HyDE-Project/HyDE/main/Source/assets/hyde_banner.png)
<br>

<a href="#installation-options"><kbd> <br> Installation <br> </kbd></a>&ensp;
<a href="#upgrading"><kbd> <br> Upgrading <br> </kbd></a>&ensp;
<a href="#troubleshooting--issues"><kbd> <br> Issues <br> </kbd></a>&ensp;
<a href="#faq"><kbd> <br> FAQ <br> </kbd></a>&ensp;
<a href="#contributing"><kbd> <br> Contributing <br> </kbd></a>&ensp;
<a href="https://www.youtube.com/watch?v=2rWqdKU1vu8&list=PLt8rU_ebLsc5yEHUVsAQTqokIBMtx3RFY&index=1"><kbd> <br> Youtube <br> </kbd></a>&ensp;
<a href="https://discord.gg/qWehcFJxPa"><kbd> <br> Discord <br> </kbd></a>

</div><br><br>

<video controls src="https://private-user-images.githubusercontent.com/106020512/324331744-7f8fadc8-e293-4482-a851-e9c6464f5265.mp4?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzAxNzIwODEsIm5iZiI6MTczMDE3MTc4MSwicGF0aCI6Ii8xMDYwMjA1MTIvMzI0MzMxNzQ0LTdmOGZhZGM4LWUyOTMtNDQ4Mi1hODUxLWU5YzY0NjRmNTI2NS5tcDQ_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjQxMDI5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI0MTAyOVQwMzE2MjFaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03YTBiNDVjZThhZjU4NmY1MTc4NTRjYzEyZTBmYjRmZjI0YTY0ZTIyNWU2NTlhMTBkZmIxOWFlOWQ0YzQ5YTAyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.cTLUInzudFw4tmHUS1K32e6hx3umv84Ka2sDCuzrUig" title="https://github.com/prasanthrangan/hyprdots/assets/106020512/7f8fadc8-e293-4482-a851-e9c6464f5265"></video>

<br><div align="center"><img width="18%" src="https://raw.githubusercontent.com/HyDE-Project/HyDE/main/Source/assets/arch.png"/> <img style="margin-right: 10px" width="16%" src="https://em-content.zobj.net/source/apple/391/handshake_1f91d.png">&ensp;&ensp;&ensp;<img width="16.5%" src="https://github.com/NixOS/nixos-artwork/raw/refs/heads/master/logo/nix-snowflake-colours.svg"/></div>

# Hydenix

Hydenix is a Nix & home-manager configuration for [HyDE](https://github.com/HyDE-Project/HyDE).
The nix ecosystem brings a reproducible environment to the HyDE experience; allowing for build-time configuration options, easy updates, and more.

Features:

- Includes [HyDE-cli](https://github.com/HyDE-Project/Hyde-cli) by default
- NixOS VM that can be run with any supported distro
- Themes are fetched at build-time, for faster setup
- `config.nix` for easy configuration
- Includes **beta cross-distro** support using home-manager, more on that [here](#installation-options).

Why Nix?:

- Reproducible environment
- Easy to manage packages, dependencies, and configurations
- changes in configuration can be rolled back easily
- home-manager for managing dotfiles

> [!IMPORTANT]
> NixOS is entirely different than Arch. Experience in functional programming is recommended.
> If you are new to Nix, please refer to the [Nix Resources](#Nix-Resources).
> Feel free to ask questions in discussions or discord.

---

## Limitations

- **important** - Custom modules in `config.nix` may override hydenix defaults.
- **important** - Configurations will RESET on reboot/relog/rebuilds if your configuration does not match commands run in Hyde; such as active theme and waybar styles. This by design, as nixos and home-manager rerun.
- Some Hyde-cli commands are not supported
  - `Hyde theme import` use `config.nix` options
  - `Hyde restore/backup/control` while these commands will work, hydenix makes edits to hyde files by default.
  - `Hyde override` changing the user dir conflics with home-manager, rebuilds won't run as expected
  - `Hyde inject` not supported, use nixos options
- Any other issues, see [Troubleshooting & Issues](#troubleshooting--issues)

## Requirements

- nix pkg manager: i recommend using the [nix-installer from DeterminateSystems](https://github.com/DeterminateSystems/nix-installer)
- git (`nix-shell -p git`)

---

## Installation Options

---

> [!CAUTION]
> Templated flake is designed for a minimal install of NixOS. YMMV.

#### 1. Template the Flake

1. in a new directory, `nix flake init -t github:richen604/hydenix`
2. edit `config.nix` with your preferences
3. run `sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix`
4. `git init && git add .` (flakes have to be managed via git)
5. run any of the packages in your new `flake.nix`
   - for vm `nix run .`
   - for rebuild `sudo nixos-rebuild switch/test/boot --flake .`

#### 2. Running as a nixos VM

If your system supports it, the NixOS VM is the quickest way to get up and running.
If you have issues running the VM, see the [virtio faq](#vm-virtio-guide)

```bash
# run the flake remotely
nix run github:richen604/hydenix
```

> **note:** any changes require the vm to be rebuilt. run `rm hydenix.qcow2` to remove the old one.

#### 3. (BETA) Cross-distro VMs

Currently Arch & Fedora VMs are supported
Same VM requirements as [VM virtio guide](#vm-virtio-guide)

```bash
nix run github:richen604/hydenix/#build-fedora-vm # or #build-arch-vm

# after the vm is built, run the flake from the vm
nix run github:richen604/hydenix/#run-fedora-vm # or #run-arch-vm
```

## Upgrading

Hydenix can be upgraded, downgraded, or version locked easy.

in your template flake folder, update hydenix to main using

```bash
nix flake update hydenix
```

or define a specific version in your `flake.nix` template

```nix
inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hydenix = {
      # Available inputs:
      # Main: github:richen604/hydenix
      # Dev: github:richen604/hydenix/dev
      # Commit: github:richen604/hydenix/<commit-hash>
      # Version: github:richen604/hydenix/v1.0.0
      url = "github:richen604/hydenix";
    };
  };
```

run `nix flake update hydenix` again to apply the changes

## Directory Structure

Below is a brief reference of the directory structure to hydenix:

## `/hosts`

Contains host-specific configurations and settings.

### `/hosts/nixos`

NixOS-specific configurations:

- `configuration.nix` - main nixos system configuration, anything that cannot be done in home-manager
- `default.nix` - nixos configuration function used in `lib/mkConfig.nix`
- `drivers.nix` - Hardware driver config - used in `config.nix`
- `home.nix` - base home-manager config

### `/hosts/vm`

Virtual machine related configurations:

- `arch-vm.nix` - Arch Linux VM configuration
- `fedora-vm.nix` - Fedora VM configuration
- `nix-vm.nix` - NixOS VM configuration
- `vm-utils.nix` - Shared VM utilities for non-nixos
- `/scripts` - VM management scripts

## `/hydenix`

home-manager module containing most of hydenix's configurations:

- `/hm` - Home-manager specific configurations
- `/packages` - Custom package definitions
- `/programs` - Program-specific configurations
- `/sources` - Source files and dependencies, including hyde-cli and themes
- `default.nix` - Main configuration entry point

## `/lib`

Shared libraries and utilities:

- `dev-shell.nix` - Development shell configuration for pre-commit hook
- `gen-config.sh` - Configuration generation script
- `mkConfig.nix` - Configuration builder, takes `config.nix` and returns hydenix

## `/template`

Template for creating your own flake.

## Troubleshooting & Issues

The following information is required when creating an issue, please provide as much as possible.
It's also possible to diagnose issues yourself with the information provided.

1. **System Logs**

```bash
journalctl -b                                           # System logs
journalctl --user -b                                   # User logs
sudo systemctl status home-manager-$HOSTNAME.service   # Home-manager status
```

2. **System Information**

```bash
nix-shell -p nix-info --run "nix-info -m"
```

3. **Configuration**

- Link to a github repo with your templated flake or fork

> [!NOTE]
> Custom modules in `config.nix` have limited support.

<div align="right">
  <br>
  <a href="#"><kbd> <br> 🡅 <br> </kbd></a>
</div>

## FAQ

#### VM Virtio guide

Hyprland vm is not well supported. check out [Hyprland - Running in a VM](https://wiki.hyprland.org/Getting-Started/Installation/#running-in-a-vm)

Best bet is to have virtio, opengl, and VT-x support

Non-NixOS hosts should run with [nixGL](https://github.com/nix-community/nixGL) eg `nixGL nix run .`

CPU

- Intel CPU with VT-x or AMD CPU with AMD-V
- Virtualization enabled in BIOS/UEFI

GPU

- NVIDIA: GTX 600+ series (proprietary drivers)
- AMD: HD 7000+ series
- Intel: HD 4000+ (Ivy Bridge)
- OpenGL 3.3+ support required

Install Drivers

```bash
# Nvidia
sudo apt install nvidia-driver nvidia-utils     # Debian/Ubuntu
sudo pacman -S nvidia nvidia-utils              # Arch

# AMD
sudo apt install mesa-utils vulkan-tools        # Debian/Ubuntu
sudo pacman -S mesa lib32-mesa vulkan-radeon    # Arch

# Intel
sudo apt install mesa-utils intel-media-va-driver  # Debian/Ubuntu
sudo pacman -S mesa lib32-mesa intel-media-driver  # Arch

# KVM modprobe
modprobe kvm
modprobe kvm_intel # or kvm_amd
```

Add user to groups
`sudo usermod -a -G render,video,kvm,libvirt $USER`

Verify Setup

```bash
# Verify KVM support
egrep -c '(vmx|svm)' /proc/cpuinfo    # Should return > 0
lsmod | grep kvm                       # Check KVM modules

# Host: Check OpenGL
glxinfo | grep "OpenGL"
```

<div align="right">
  <br>
  <a href="#"><kbd> <br> 🡅 <br> </kbd></a>
</div>

## Nix Resources

> [!TIP]
> Nix is a powerful package manager and configuration system that can be overwhelming at first. Here are some resources to help you get started:

General Resources

- [Nix Packages](https://search.nixos.org/packages)
- [Nix Options](https://search.nixos.org/options)
- [Home Manager Options](https://nix-community.github.io/home-manager/options.html) _hint: use control + f to search_
- [NixOS Wiki](https://nixos.wiki)
- [Nixpkgs Discussions](https://discourse.nixos.org)
- [Nixpkgs Issues](https://github.com/NixOS/nixpkgs/issues)

<div align="right">
  <br>
  <a href="#"><kbd> <br> 🡅 <br> </kbd></a>
</div>

## Contributing

This project uses [direnv](https://direnv.net/) for pre-commit hooks. Please install it first:

- **Nix**: `nix-env -iA nixpkgs.direnv`
- **MacOS**: `brew install direnv`
- **Ubuntu/Debian**: `apt-get install direnv`

then run `direnv allow` to enable the hooks

More documentation on the codebase can be found at [Template README](template/README.md)

This project enforces [Conventional Commits](https://www.conventionalcommits.org/) format for all commit messages. Each commit message must follow this structure:

```
type(optional-scope): subject

[optional body]

[optional footer(s)]
```

Where:

- **type** must be one of:

  - `feat`: A new feature
  - `fix`: A bug fix
  - `docs`: Documentation changes
  - `style`: Code style changes (formatting, etc)
  - `refactor`: Code changes that neither fix bugs nor add features
  - `perf`: Performance improvements
  - `test`: Adding or modifying tests
  - `chore`: Maintenance tasks

- **scope** is optional but if used:

  - must be lowercase
  - should be descriptive of the area of change
  - examples: vm, themes, home, cli, docs, etc.

- **subject** must:
  - be lowercase
  - not end with a period
  - be descriptive

Examples:

- `feat(vm): add support for fedora vm configuration`
- `fix: correct wallpaper path in material theme`
- `docs: update installation instructions`
- `chore: update dependencies`

### Pull Requests

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes using conventional commits
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Changelog

The changelog is automatically generated from commit messages. Clear, well-formatted commit messages ensure your changes are properly documented.

For more details, see the [Conventional Commits specification](https://www.conventionalcommits.org/).
