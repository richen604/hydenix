# Hydenix Template

Welcome to your Hydenix configuration!

This template provides a self-documenting NixOS configuration with the HyDE desktop environment.

## Quick Setup

### 1. Configure Your System

Edit `configuration.nix` following the detailed comments:

**Required Changes:**

- Set your username (replace "hydenix" in two places)
- Set your hostname, timezone, and locale
- Configure your hardware (GPU/CPU modules)

**User Account Setup:**

- Find the "USER ACCOUNT SETUP" section
- Replace `"hydenix"` with your desired username (appears in 2 places)
- Choose your shell: `pkgs.zsh`, `pkgs.bash`, or `pkgs.fish`

**System Settings:**

- Set your `hostname` (computer network name)
- Set your `timezone` (run `timedatectl list-timezones` for options)
- Set your `locale` (language/region format)

**Hardware Configuration:**

- Uncomment your GPU type (NVIDIA or AMD)
- Uncomment your CPU type (Intel or AMD)
- Add any additional hardware modules (laptop, SSD, high-DPI, etc.)

**For NVIDIA users:** If you have hybrid graphics (laptop), you'll also need to:

```bash
# Find your GPU bus IDs:
lspci | grep VGA

# Then set in configuration.nix:
# hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
# hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";
```

### 2. Generate Hardware Configuration

```bash
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```

### 3. Initialize Git Repository

```bash
git init && git add .
```

### 4. Build Your System

```bash
sudo nixos-rebuild switch --flake .#nixos
```

### 5. IMPORTANT: Set Your Password

```bash
passwd
```

### 6. Launch Hydenix

After first login, generate theme cache (you only need to do this once):

```bash
hyde-shell reload
```

## Next Steps

- Review `./modules/hm/default.nix` for home-manager options
- See [Module Options](https://github.com/richen604/hydenix/blob/main/docs/options.md) for advanced configuration
- Check the [FAQ](https://github.com/richen604/hydenix/blob/main/docs/faq.md) and [Troubleshooting](https://github.com/richen604/hydenix/blob/main/docs/troubleshooting.md) guides

## Getting Help

- [Hydenix Documentation](https://github.com/richen604/hydenix)
- [Hyde Discord](https://discord.gg/AYbJ9MJez7)
- [GitHub Discussions](https://github.com/richen604/hydenix/discussions)

## Upgrading

Update Hydenix:

```bash
nix flake update hydenix
sudo nixos-rebuild switch --flake .#nixos
```

This is now your personal NixOS configuration. Add packages, customize themes, or even try other desktop environments. Enjoy the full power of Nix!
