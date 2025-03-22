###### *<div align="right"><sub>// design by t2</sub></div>*

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

 ![hyde_banner](https://raw.githubusercontent.com/prasanthrangan/hyprdots/main/Source/assets/hyde_banner.png)

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

<br><div align="center"><img width="16.5%" alt="NixOS" src="https://github.com/HyDE-Project/HyDE/blob/master/Source/assets/nixos.png?raw=true"/></div>

# Hydenix

Hydenix is a Nix & home-manager configuration for [HyDE](https://github.com/HyDE-Project/HyDE).
The nix ecosystem brings a reproducable environment to the HyDE experience; allowing for build-time configuration options, easy updates, and more.

Features:

- `hydenix` and `hydenix.hm` (home-manager) options for easy configuration
- Themes are fetched at build-time, for faster setup

Why Nix?:

- Reproducible environment
- Easy to manage packages, dependencies, and configurations
- changes in configuration can be rolled back easily
- home-manager for managing dotfiles

> [!IMPORTANT]
> Experience in functional programming is recommended.
> If you are new to Nix, please refer to the [Nix Resources](docs/faq.md#how-do-i-learn-more-about-nix).
> Feel free to ask questions in discussions or discord.

---

## Requirements

- minimal install of NixOS, follow instructions on [NixOS ISO](https://nixos.org/download/#nixos-iso)
- experimental features enabled:

  ```bash
  # Add to /etc/nixos/configuration.nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # then rebuild your system
  sudo nixos-rebuild switch
  ```

- git (`nix-shell -p git`)

---

## Documentation

- [Installation Options](#installation-options)
- [FAQ](./docs/faq.md)
- [Troubleshooting & Issues](./docs/troubleshooting.md)
- [Contributing](./docs/contributing.md)

## Installation Options

---

> [!CAUTION]
> Templated flake is designed for a minimal install of NixOS.

### 1. Template the Hydenix Flake

1. in a new directory, `nix flake init -t github:richen604/hydenix`
2. edit `configuration.nix` with your preferences for hydenix
   - options needing to be changed are marked with `! EDIT`
   - (optional) in your template flake folder, review both `./configuration.nix` and `./modules/hm/default.nix` for more options
3. run `sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix`
4. `git init && git add .` (flakes have to be managed via git)
5. run any of the packages in your new `flake.nix`
    - for rebuild, use `sudo nixos-rebuild switch --flake .`
6. DON'T FORGET: change your password for all users with `passwd` from initialPassword set in `configuration.nix`

NOTE: After launching hydenix, you can run `hyde-shell reload` to generate cache for remaining themes if you want.

### 2. Trying Out Hydenix with a VM

If your system supports it, the NixOS VM is a great way to try out hydenix without installing it.
If you encounter issues running the VM, refer to the [virtio guide](docs/faq.md#how-do-i-run-hyprland-in-a-vm)

```bash
# run the flake remotely
nix run github:richen604/hydenix
```

> **note:** any changes require the vm to be rebuilt. run `rm hydenix.qcow2` to remove the old one.

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

---