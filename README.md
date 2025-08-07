<div align="center">

[![NixOS Unstable](https://img.shields.io/badge/NixOS-unstable-ebbcba.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)
[![Release](https://img.shields.io/github/v/release/richen604/hydenix?style=flat-square&color=c79bf0)](https://github.com/richen604/hydenix/releases)
[![Last Commit](https://img.shields.io/github/last-commit/richen604/hydenix/main?style=flat-square&color=ebbcba)](https://github.com/richen604/hydenix/commits/main)
[![Nix Flake Check](https://img.shields.io/github/actions/workflow/status/richen604/hydenix/flake-check.yml?style=flat-square&color=c79bf0&label=flake%20check)](https://github.com/richen604/hydenix/actions/workflows/flake-check.yml)

</div>

<div align = center>
    <a href="https://discord.gg/AYbJ9MJez7">
<img alt="Dynamic JSON Badge" src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fdiscordapp.com%2Fapi%2Finvites%2FmT5YqjaJFh%3Fwith_counts%3Dtrue&query=%24.approximate_member_count&suffix=%20members&style=for-the-badge&logo=discord&logoSize=auto&label=The%20HyDe%20Project&labelColor=ebbcba&color=c79bf0">
    </a>
</div>

https://github.com/user-attachments/assets/7f8fadc8-e293-4482-a851-e9c6464f5265

<div align="left" style="margin: 0 10% 0 10%;">

<div align="right" style="margin: 0 -12% -75px 0;"><img width="100px" alt="NixOS" src="https://github.com/HyDE-Project/HyDE/blob/master/Source/assets/nixos.png?raw=true"/></div>
</div>

# hydenix

a nixos and home-manager configuration for [HyDE](https://github.com/HyDE-Project/HyDE)

**features / why nixos? :**

- declarative `hydenix` and `hydenix.hm` configuration options
- leveraged module system, easily extend disable or override any module
- close feature parity with [HyDE](https://github.com/HyDE-Project/HyDE)
- every community [hyde-gallery theme](https://github.com/HyDE-Project/hyde-gallery)
- reproducible environments with easy rollbacks
- version control for your desktop

## requirements

- minimal install of nixos, follow instructions on [nixos iso](https://nixos.org/download/#nixos-iso)

> [!IMPORTANT]
> functional programming experience recommended. <br>
> new to nix? see [nix resources](./template/docs/faq.md#how-do-i-learn-more-about-nix) or ask in discussions/discord.

## documentation

- [installation](./template/docs/installation.md)
- [upgrading](./template/docs/upgrading.md)
- [module options](./template/docs/options.md)
- [faq](./template/docs/faq.md)
- [troubleshooting & issues](./template/docs/troubleshooting.md)
- [contributing](./template/docs/contributing.md)
- [community configs](./template/docs/community.md)
- [todo - sneak peak of whats coming soon](./TODO.md)

## hydenix vm

if your system supports it, the nixos vm is a great way to try out hydenix without installing it.
if you encounter issues running the vm, refer to the [virtio guide](./template/docs/faq.md#how-do-i-run-hyprland-in-a-vm)

```bash
# run the flake remotely
nix run github:richen604/hydenix
```

> [!NOTE]
> any changes require the vm to be rebuilt. run `rm hydenix.qcow2` to remove the old one.

</div>
