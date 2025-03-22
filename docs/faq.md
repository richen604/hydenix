# FAQ

## General FAQ

- [FAQ](#faq)
  - [General FAQ](#general-faq)
    - [Why should I use NixOS?](#why-should-i-use-nixos)
    - [How do I learn more about Nix?](#how-do-i-learn-more-about-nix)
  - [Hydenix FAQ](#hydenix-faq)
    - [How do I fix (Nix error / system error / bug / etc)?](#how-do-i-fix-nix-error--system-error--bug--etc)
    - [What are the module options?](#what-are-the-module-options)
    - [What if I want to customize hydenix?](#what-if-i-want-to-customize-hydenix)
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

### How do I fix (Nix error / system error / bug / etc)?

Please see the [troubleshooting](./troubleshooting.md) guide for more information on how to diagnose and fix issues.
Or create an issue in the [Hydenix GitHub repository](https://github.com/richen604/hydenix/issues).

### What are the module options?

Below will be the default options for hydenix. the only required options are `hydenix.enable` and `hydenix.hm.enable`.

NixOS hydenix options:

<details>
<summary>View NixOS hydenix options</summary>

```nix
{
  hydenix = {

    #! Important options
    enable = true; # enable hydenix - required, default false
    hostname = "hydenix"; # hostname
    timezone = "America/Vancouver"; # timezone
    locale = "en_CA.UTF-8"; # locale

    #! Below are defaults
    audio.enable = true; # enable audio module
    boot = {
      enable = true; # enable boot module
      useSystemdBoot = true; # disable for GRUB
      grubTheme = pkgs.hydenix.grub-retroboot; # or pkgs.hydenix.grub-pochita
      grubExtraConfig = ""; # additional GRUB configuration
      kernelPackages = pkgs.linuxPackages_zen; # default zen kernel
    };
    hardware.enable = true; # enable hardware module
    network.enable = true; # enable network module
    nix.enable = true; # enable nix module
    sddm = {
      enable = true; # enable sddm module
      theme = pkgs.hydenix.sddm-candy; # or pkgs.hydenix.sddm-corners
    };
    system.enable = true; # enable system module
  };
}
```

</details>

<details>
<summary>View Home Manager hydenix options</summary>

```nix
{
  hydenix.hm = {

    #! Important options
    enable = true;

    #! Below are defaults
    comma.enable = true; # useful nix tool to run software without installing it first
      dolphin.enable = true; # file manager
      editors = {
        enable = true; # enable editors module
        neovim.enable = true; # enable neovim module
        vscode = {
          enable = true; # enable vscode module
          wallbash = true; # enable wallbash extension for vscode
        };
        vim.enable = true; # enable vim module
        default = "vim"; # default text editor
      };
      fastfetch.enable = true; # fastfetch configuration
      firefox = {
        enable = true; # enable firefox module
        useHydeConfig = false; # use hyde firefox configuration and extensions
        useUserChrome = true; # if useHydeConfig is true, apply hyde userChrome CSS customizations
        useUserJs = true; # if useHydeConfig is true, apply hyde user.js preferences
        useExtensions = true; # if useHydeConfig is true, install hyde firefox extensions
      };
      gaming.enable = true; # enable gaming module
      git = {
        enable = true; # enable git module
        name = null; # git user name eg "John Doe"
        email = null; # git user email eg "john.doe@example.com"
      };
      hyde.enable = true; # enable hyde module
    hyprland.enable = true; # enable hyprland module
    lockscreen = {
      enable = true; # enable lockscreen module
      hyprlock = true; # enable hyprlock lockscreen
      swaylock = false; # enable swaylock lockscreen
    };
    notifications.enable = true; # enable notifications module
    qt.enable = true; # enable qt module
    rofi.enable = true; # enable rofi module
    screenshots = {
      enable = true; # enable screenshots module
      grim.enable = true; # enable grim screenshot tool
      slurp.enable = true; # enable slurp region selection tool
      satty.enable = true; # enable satty screenshot annotation tool
      swappy.enable = false; # enable swappy screenshot editor
    };
    wallpapers.enable = true; # enable wallpapers module
    shell = {
      enable = true; # enable shell module
      zsh.enable = true; # enable zsh shell
      configText = ""; # zsh config text
      bash.enable = false; # enable bash shell
      fish.enable = false; # enable fish shell
      pokego.enable = true; # enable Pokemon ASCII art scripts
    };
    social = {
      enable = true; # enable social module
      discord.enable = true; # enable discord module
      webcord.enable = true; # enable webcord module
      vesktop.enable = true; # enable vesktop module
    };
    spotify.enable = true; # enable spotify module
    swww.enable = true; # enable swww wallpaper daemon
    terminals = {
      enable = true; # enable terminals module
      kitty.enable = true; # enable kitty terminal
      configText = ""; # kitty config text
    };
    theme = {
      enable = true; # enable theme module
      active = "Catppuccin Mocha"; # active theme name
      themes = [ "Catppuccin Mocha" "Catppuccin Latte" ]; # default enabled themes, full list in https://github.com/richen604/hydenix/tree/main/hydenix/sources/themes
    };
    waybar.enable = true; # enable waybar module
    wlogout.enable = true; # enable wlogout module
    xdg.enable = true; # enable xdg module
  };
}
```

</details>

<div align="right">
  <a href="#faq">
    <img src="https://img.shields.io/badge/Back_to_Top-↑-blue" alt="Back to Top" />
  </a>
</div>

### What if I want to customize hydenix?

Hydenix is designed to be customizable outside of the module options. Write your own modules, import your own flakes, packages, etc.

If you need to disable any of the modules above in [module options](#what-are-the-module-options), simply disable the module and write your own configuration. Ideally referencing the module in the source code.

Note however, it's very easy to overwrite hydenix defaults this way and may lead to bugs. Feel free to ask questions in our [Discord](https://discord.gg/AYbJ9MJez7) if you need help.

<div align="right">
  <a href="#faq">
    <img src="https://img.shields.io/badge/Back_to_Top-↑-blue" alt="Back to Top" />
  </a>
</div>

### How do I persist changes on reboot/rebuild/etc?

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
      force = true;
      mutable = true;
    };
    # copy waybar position state to your template flake
    # cp ~/.config/waybar/config.ctl ~/path/to/flake/config.ctl
    ".config/waybar/config.ctl" = {
      source = ./config.ctl; # path to your waybar config in your template flake
      force = true;
      mutable = true;
    };
  };
}
```

The [mutable](#what-is-mutablenix) part is important as it allows the file to copy at the right time.

<div align="right">
  <a href="#faq">
    <img src="https://img.shields.io/badge/Back_to_Top-↑-blue" alt="Back to Top" />
  </a>
</div>

### How do I add a new theme?

<!-- TODO: docs: Add a guide on how to add a new theme -->

### What is mutable.nix?

The `mutable.nix` file is a custom NixOS module that extends the `home.file`, `xdg.configFile`, and `xdg.dataFile` options with the `mutable` option.

This option allows you to copy the file without the read-only attribute instead of symlinking. If you set this option to `true`, you must also set the `force` option to `true`.

Mutable files are not removed when you remove them from your configuration. They are copied every rebuild so changes made to state will persist. This option is useful for programs that don't have good support for read-only configurations or need runtime changes.

Is this anti-pattern / impure? Yes. However, state files are common in linux systems. I chose to declaratively manage state files rather than remove functionality from HyDE.

When does this generation happen? During the `home.activation` `mutableGeneration` entry.
If you need access to stateful files that hydenix generates, make sure the script runs after `mutableGeneration`.

eg.

```nix
home.activation = {
    example = lib.hm.dag.entryAfter [ "mutableGeneration" ] ''
        $DRY_RUN_CMD echo "example"
    '';
}
```

credit to @piousdeer for the [implementation](https://gist.github.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa)

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