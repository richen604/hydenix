<img align="right" width="75px" alt="NixOS" src="https://github.com/HyDE-Project/HyDE/blob/master/Source/assets/nixos.png?raw=true"/>

# hydenix template flake

This is now your personal NixOS configuration.\
Add packages, customize themes, or even disable hydenix and setup your own wm/de.\
Enjoy the full power of Nix!

visit the [docs/installation.md](./docs/installation.md) to get started.

## file structure

### core configuration files

| file | description |
|------|-------------|
| `flake.nix` | main flake configuration and entry point |
| `configuration.nix` | nixos system configuration |
| `hardware-configuration.nix` | hardware-specific settings (auto-generated) |

### documentation

| file | purpose |
|------|---------|
| [`docs/installation.md`](./docs/installation.md) | installation guide and setup instructions |
| [`docs/options.md`](./docs/options.md) | available module configuration options |
| [`docs/faq.md`](./docs/faq.md) | frequently asked questions and solutions |
| [`docs/troubleshooting.md`](./docs/troubleshooting.md) | common issues and fixes |
| [`docs/upgrading.md`](./docs/upgrading.md) | how to upgrade your configuration |
| [`docs/contributing.md`](./docs/contributing.md) | guidelines for contributing |
| [`docs/community.md`](./docs/community.md) | community configurations and examples |

### write your own modules

> **note:** Use these directories to override or extend hydenix modules with your custom configurations.

| directory | type | purpose |
|-----------|------|---------|
| `modules/hm/` | home manager | custom home-manager module definitions (and for `hydenix.hm` options) |
| `modules/system/` | nixos system | custom system-level module definitions (and for `hydenix` options) |

### directory tree

```bash
hydenix/
├── README.md
├── flake.nix
├── configuration.nix
├── hardware-configuration.nix
├── docs/
│   ├── *.md files
│   └── assets/
└── modules/
    ├── hm/default.nix
    └── system/default.nix
```

## next steps

- to learn more about nix, see [nix resources](./docs/faq.md#how-do-i-learn-more-about-nix)
- see [module options](./docs/options.md) for configuration
- check the [faq](./docs/faq.md) and [troubleshooting](./docs/troubleshooting.md) guides

## getting help

- [hydenix issues](https://github.com/richen604/hydenix/issues)
- [hydenix discussions](https://github.com/richen604/hydenix/discussions)
- [hyde discord](https://discord.gg/AYbJ9MJez7)
