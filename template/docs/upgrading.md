<img align="right" width="75px" alt="NixOS" src="https://github.com/HyDE-Project/HyDE/blob/master/Source/assets/nixos.png?raw=true"/>

# upgrading

hydenix can be upgraded, downgraded, or version locked easy.
in your template flake folder, update hydenix to main using:

```bash
nix flake update hydenix
```

or define a specific version in your `flake.nix` template:

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

run `nix flake update hydenix` again to load the update, then rebuild your system to apply the changes.

## when to upgrade

```mermaid
graph TD
    A[v2.3.1] --> B[major]
    A --> C[minor]
    A --> D[patch]
    B --> E[breaking changes<br>review release notes for api changes]
    C --> F[new features<br>safe to update]
    D --> G[bug fixes<br>safe to update]

    style A fill:#c79bf0,stroke:#ebbcba,stroke-width:2px,color:#000
    style B fill:#ebbcba,stroke:#c79bf0,stroke-width:2px,color:#000
    style C fill:#ebbcba,stroke:#c79bf0,stroke-width:2px,color:#000
    style D fill:#ebbcba,stroke:#c79bf0,stroke-width:2px,color:#000
    style E fill:#f6f6f6,stroke:#c79bf0,stroke-width:2px,color:#000
    style F fill:#f6f6f6,stroke:#c79bf0,stroke-width:2px,color:#000
    style G fill:#f6f6f6,stroke:#c79bf0,stroke-width:2px,color:#000
```

<br>

> [!Important]
>
> - **always review [release notes](https://github.com/richen604/hydenix/releases) for major updates (API changes)**
> - update to minor versions for new features
> - keep up with patches for stability
