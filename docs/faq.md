# FAQ

## General FAQ

- [FAQ](#faq)
  - [General FAQ](#general-faq)
    - [Why should I use NixOS?](#why-should-i-use-nixos)
    - [How do I learn more about Nix?](#how-do-i-learn-more-about-nix)
  - [Hydenix FAQ](#hydenix-faq)
    - [How do I upgrade Hydenix?](#how-do-i-upgrade-hydenix)
    - [When should I upgrade?](#when-should-i-upgrade)
    - [How do I fix (Nix error / system error / bug / etc)?](#how-do-i-fix-nix-error--system-error--bug--etc)
    - [Common errors](#common-errors)
      - [`error: hash mismatch in fixed-output derivation`](#error-hash-mismatch-in-fixed-output-derivation)
      - [`Existing file '...' is in the way of '...'`](#existing-file--is-in-the-way-of-)
    - [What are the module options?](#what-are-the-module-options)
    - [What if I want to customize hydenix?](#what-if-i-want-to-customize-hydenix)
    - [What are some example configurations?](#what-are-some-example-configurations)
    - [How do I persist changes on reboot/rebuild/etc?](#how-do-i-persist-changes-on-rebootrebuildetc)
    - [How do I add a new theme?](#how-do-i-add-a-new-theme)
    - [What is mutable.nix?](#what-is-mutablenix)
    - [Why do themes still show after I remove them from `hydenix.hm.theme.themes`?](#why-do-themes-still-show-after-i-remove-them-from-hydenixhmthemethemes)
    - [Requesting features](#requesting-features)
  - [Other FAQ](#other-faq)
    - [How do I run Hyprland in a VM?](#how-do-i-run-hyprland-in-a-vm)

### Why should I use NixOS?

NixOS offers several key advantages:

1. **Reproducible setups**: Roll back to working states instantly if something breaks.
2. **Configuration as code**: Version control your entire OS setup.
3. **No dependency hell**: Packages are isolated, allowing multiple versions side by side.
4. **Declarative approach**: Describe the desired end state rather than steps to achieve it.
5. **Risk-free experimentation**: Test configurations without permanent consequences.
6. **Developer-friendly**: Create isolated environments with precise dependencies.

There's a learning curve, but the benefits are worth it.

<div align="right">
  <a href="#faq">
    <img src="https://img.shields.io/badge/Back_to_Top-↑-blue" alt="Back to Top" />
  </a>
</div>

### How do I learn more about Nix?

> [!TIP]
> Nix is a powerful package manager and configuration system that can be overwhelming at first. Here are some resources to help you get started:

General Resources

- [Nix Packages](https://search.nixos.org/packages)
- [Nix Options](https://search.nixos.org/options)
- [Home Manager Options](https://home-manager-options.extranix.com/?query=&release=master)
- [NixOS Wiki](https://nixos.wiki)
- [Nixpkgs Discussions](https://discourse.nixos.org)
- [Nixpkgs Issues](https://github.com/NixOS/nixpkgs/issues)

<div align="right">
  <a href="#faq">
    <img src="https://img.shields.io/badge/Back_to_Top-↑-blue" alt="Back to Top" />
  </a>
</div>

## Hydenix FAQ

### How do I upgrade Hydenix?

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

run `nix flake update hydenix` again to load the update, then rebuild your system to apply the changes

### When should I upgrade?

```mermaid
graph TD
    A[v2.3.1] --> B[MAJOR]
    A --> C[MINOR]
    A --> D[PATCH]
    B --> E[Breaking Changes<br>Review Release Notes for API Changes]
    C --> F[New Features<br>Safe to Update]
    D --> G[Bug Fixes<br>Safe to Update]

    style A fill:#c79bf0,stroke:#ebbcba,stroke-width:2px,color:#000
    style B fill:#ebbcba,stroke:#c79bf0,stroke-width:2px,color:#000
    style C fill:#ebbcba,stroke:#c79bf0,stroke-width:2px,color:#000
    style D fill:#ebbcba,stroke:#c79bf0,stroke-width:2px,color:#000
    style E fill:#f6f6f6,stroke:#c79bf0,stroke-width:2px,color:#000
    style F fill:#f6f6f6,stroke:#c79bf0,stroke-width:2px,color:#000
    style G fill:#f6f6f6,stroke:#c79bf0,stroke-width:2px,color:#000
```

- **Always review [release notes](https://github.com/richen604/hydenix/releases) for major updates (API changes)**
- Keep up with patches for stability
- Update to minor versions for new features

### How do I fix (Nix error / system error / bug / etc)?

Please see the [troubleshooting](./troubleshooting.md) guide for more information on how to diagnose and fix issues.
Or create an issue in the [Hydenix GitHub repository](https://github.com/richen604/hydenix/issues).

### Common errors

#### `error: hash mismatch in fixed-output derivation`

This error occurs when Nix expects a specific hash for a downloaded file, but the actual file has a different hash due to upstream changes.

These usually happen with themes as they are updated frequently.

Example:

```bash
error: hash mismatch in fixed-output derivation '/nix/store/2s2n054di1wg8d3sw50wqhs10yg8svj0-Code-Garden.drv':
         specified: sha256-ZAmxhz7MK24htAcPdnNMZF/K7Cw7vru80xZn+7yJgXQ=
            got:    sha256-HHC15pPHJ+ylQ56yYysEoKjKYUAoye2WHmt4Q2vyffk=
```

**Solution: Override the package in configuration.nix**

If I haven't updated this in the repo yet, add this overlay to your existing overlays in `configuration.nix` to fix the error:

```nix
overlays = [
  inputs.hydenix.lib.overlays
  # Fix hash mismatch errors for Catppuccin Mocha
  (final: prev: {
    # Replace 'hydenix.themes."Catppuccin Mocha"' with the actual failing package, for theme names check https://github.com/richen604/hydenix/blob/main/hydenix/sources/themes/default.nix
    hydenix.themes."Catppuccin Mocha" = prev.hydenix.themes."Catppuccin Mocha".overrideAttrs (oldAttrs: {
      src = prev.fetchFromGitHub {
        # Use the hash from error message under "got:"
        sha256 = "HHC15pPHJ+ylQ56yYysEoKjKYUAoye2WHmt4Q2vyffk=";
      };
    });
  })
  (final: prev: {
    userPkgs = import inputs.nixpkgs {
      config.allowUnfree = true;
    };
  })
];
```

#### `Existing file '...' is in the way of '...'`

This error occurs when home-manager tries to manage a file that already exists and wasn't created by home-manager.

Example:

```bash
Existing file '/home/user/.config/kitty/kitty.conf' is in the way of '/nix/store/...-home-manager-files/.config/kitty/kitty.conf'
```

**Solution 1: Remove existing files (recommended)**

Remove the conflicting files and let home-manager recreate them:

```bash
# Remove the specific file
rm ~/.config/kitty/kitty.conf

# Or remove entire config directory if needed (careful not to delete important files)
rm -rf ~/.config/kitty/
```

**Solution 2: Backup existing files**

If you want to preserve your existing configuration:

```bash
# Create backup
mv ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.backup

# Then rebuild to let home-manager create the new file
sudo nixos-rebuild switch
```

**Solution 3: Force home-manager to backup automatically**

Add this to your `configuration.nix` to automatically backup conflicting files:

```nix
{
  home-manager.backupFileExtension = "backup";
}
```

This will automatically rename existing files with a `.backup` extension when home-manager encounters conflicts, allowing the rebuild to proceed without manual intervention only once.

> [!WARNING]
> if there is a conflict again, home-manager will error for you to manually resolve it. I don't include this by default as automating backups may not be ideal for users and it does not really solve the issue with managing backups

### What are the module options?

Visit [options.md](./options.md) for more information on the module options.

### What if I want to customize hydenix?

Hydenix is designed to be customizable outside of the module options. Write your own modules, import your own flakes, packages, etc.

If you need to disable any of the modules above in [module options](#what-are-the-module-options), simply disable the module and write your own configuration. Ideally referencing the module in the source code.

Note however, it's very easy to overwrite hydenix defaults this way and may lead to bugs. Feel free to ask questions in our [Discord](https://discord.gg/AYbJ9MJez7) if you need help.

<div align="right">
  <a href="#faq">
    <img src="https://img.shields.io/badge/Back_to_Top-↑-blue" alt="Back to Top" />
  </a>
</div>

### What are some example configurations?

Here's a list, feel free to make a PR to add your own!

- [richen604/richendots](https://github.com/richen604/richendots)

### How do I persist changes on reboot/rebuild/etc?

> [!IMPORTANT]
> Do not edit any mutable files at runtime as they will be overwritten on rebuild <br>
> All edits must be done in your flake via nixos & home-manager options

Some state files in HyDE are mutable by design. This allows certain theme changes during runtime.

Example:

Lets say you have the default theme set to `Catppuccin Mocha` in `hydenix.hm.theme.active`.

You change a theme during runtime using `Meta + Shift + T` to `Catppuccin Latte`.
Your config is unchanged so when you reboot/relog/rebuild, the theme will revert to `Catppuccin Mocha`.

```nix
{
  hydenix.hm.theme.active = "Catppuccin Mocha";
}
```

Simply change the theme in your config to match your desired theme and rebuild.

```nix
{
  hydenix.hm.theme.active = "Catppuccin Latte";
}
```

But what about file you want to stop from reverting? waybar position or kitty config?
home-managers `home.file` allows you to do this

```nix
# any file in `./modules/hm/`
{
  home.file = {
    # copy kitty config to your template flake
    # cp ~/.config/kitty/kitty.conf ~/path/to/flake/kitty.conf
    ".config/kitty/kitty.conf" = {
      source = ./kitty.conf; # path to your kitty config in your template flake
    };
    # copy waybar position state to your template flake
    # cp ~/.config/waybar/config.ctl ~/path/to/flake/config.ctl
    ".config/waybar/config.ctl" = {
      source = ./config.ctl; # path to your waybar config in your template flake
    };
  };
}
```

see [home.file options](https://home-manager-options.extranix.com/?query=home.file&release=master) for more information

<div align="right">
  <a href="#faq">
    <img src="https://img.shields.io/badge/Back_to_Top-↑-blue" alt="Back to Top" />
  </a>
</div>

### How do I add a new theme?

<!-- TODO: docs: Add a guide on how to add a new theme -->

### What is mutable.nix?

> [!IMPORTANT]
> Do not edit any mutable files at runtime as they will be overwritten on rebuild <br>
> All edits must be done in your flake via nixos & home-manager options

`mutable.nix` is a custom module that allows certain files to be copied instead of symlinked during system builds, making them writable at runtime. Key points:

- Extends `home.file`, `xdg.configFile`, and `xdg.dataFile` with a `mutable` option
- Files marked as `mutable = true` (and `force = true`) will be writable
- Changes persist across rebuilds
- Useful for programs that need runtime configuration changes

Example usage in scripts:

```nix
home.activation = {
    example = lib.hm.dag.entryAfter [ "mutableGeneration" ] ''
        $DRY_RUN_CMD echo "example"
    '';
}
```

Credit: [@piousdeer](https://gist.github.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa)

<div align="right">
  <a href="#faq">
    <img src="https://img.shields.io/badge/Back_to_Top-↑-blue" alt="Back to Top" />
  </a>
</div>

### Why do themes still show after I remove them from `hydenix.hm.theme.themes`?

Themes are saved in `~/.config/hydenix/themes` so they will still show after you remove them from `hydenix.hm.theme.themes`.
To clear the saved themes, run `rm -rf ~/.config/hydenix/themes/THEME_NAME` for each theme you want to remove.

<div align="right">
  <a href="#faq">
    <img src="https://img.shields.io/badge/Back_to_Top-↑-blue" alt="Back to Top" />
  </a>
</div>

### Requesting features

Please open a [feature request](https://github.com/richen604/hydenix/issues/new?template=feature_request.md) if you have any feature requests.

<div align="right">
  <a href="#faq">
    <img src="https://img.shields.io/badge/Back_to_Top-↑-blue" alt="Back to Top" />
  </a>
</div>

## Other FAQ

### How do I run Hyprland in a VM?

Hyprland vm is not well supported. check out [Hyprland - Running in a VM](https://wiki.hyprland.org/Getting-Started/Installation/#running-in-a-vm)

Best bet is to have virtio, opengl, and VT-x support

Non-NixOS hosts should run with [nixGL](https://github.com/nix-community/nixGL) eg `nixGL nix run .`

<details>
<summary>Hardware Requirements</summary>
CPU

- Intel CPU with VT-x or AMD CPU with AMD-V
- Virtualization enabled in BIOS/UEFI

GPU

- NVIDIA: GTX 600+ series (proprietary drivers)
- AMD: HD 7000+ series
- Intel: HD 4000+ (Ivy Bridge)
- OpenGL 3.3+ support required

</details>

<br>

<details>
<summary>1. Install Drivers</summary>

```bash
# Nvidia
sudo apt install nvidia-driver nvidia-utils     # Debian/Ubuntu
sudo pacman -S nvidia nvidia-utils              # Arch
# NixOS configuration
{
  hardware.graphics.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;
}

# AMD
sudo apt install mesa-utils vulkan-tools        # Debian/Ubuntu
sudo pacman -S mesa lib32-mesa vulkan-radeon    # Arch
# NixOS configuration
{
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [ amdvlk ];
}

# Intel
sudo apt install mesa-utils intel-media-va-driver  # Debian/Ubuntu
sudo pacman -S mesa lib32-mesa intel-media-driver  # Arch
# NixOS configuration
{
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [ intel-media-driver ];
}

# KVM modprobe
modprobe kvm
modprobe kvm_intel # or kvm_amd
# NixOS configuration
{
  boot.kernelModules = [ "kvm-intel" ]; # or "kvm-amd" for AMD processors
  virtualisation.libvirtd.enable = true;
}
```

</details>

<div style="margin-top: 10px;"></div>

<details>
<summary>2. Verify Setup</summary>

```bash
# Verify KVM support
egrep -c '(vmx|svm)' /proc/cpuinfo    # Should return > 0
lsmod | grep kvm                       # Check KVM modules

# Host: Check OpenGL
glxinfo | grep "OpenGL"
```

</details>

<div style="margin-top: 10px;"></div>

<details>
<summary>3. Setup the VM</summary>

To set up the VM, follow the instructions in the [Hyprland - Running in a VM](https://wiki.hyprland.org/Getting-Started/Installation/#running-in-a-vm) guide.

Additionally, the following qemu options have been found to be successful:

```bash
-device virtio-vga-gl
-display gtk,gl=on,grab-on-hover=on
-usb -device usb-tablet
-cpu host
-enable-kvm
-machine q35
-device intel-iommu
-device ich9-intel-hda
-device hda-output
-vga none
```

</details>

<div align="right">
  <a href="#faq">
    <img src="https://img.shields.io/badge/Back_to_Top-↑-blue" alt="Back to Top" />
  </a>
</div>
