# installation

> [!CAUTION]
> the templated flake is designed for a minimal install of nixos. install nixos first, then follow the instructions below.

1. **initialize the flake template**

   ```bash
   # create a new directory and initialize the template
   mkdir hydenix && cd hydenix
   nix flake init -t github:richen604/hydenix
   ```

2. **configure your system**

   edit `configuration.nix` following the detailed comments:

   - **required changes:**
     - set your username (replace "hydenix" in two places)
     - set your hostname, timezone, and locale
     - configure your hardware (gpu/cpu modules)

   - **optional:**
     - see [module options](./options.md) for advanced configuration

3. **generate hardware configuration**

   ```bash
   sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
   ```

4. **initialize git repository**

   ```bash
   git init && git add .
   ```

   > [!NOTE]
   > we do this because flakes must be managed via git. and its good practice to version control your configuration

5. **build and switch to the new configuration**

   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

   > [!NOTE]
   > if you made mistakes, it will fail here. try following:
   > - read the error carefully, it may be self-explanatory
   > - troubleshooting steps in [troubleshooting & issues](./troubleshooting.md)
   > - read the [faq](./faq.md), it may have the answer you're looking for
   > - ask in [discord](https://discord.gg/AYbJ9MJez7) or [github discussions](https://github.com/richen604/hydenix/discussions)

6. **important: set your password**

   ```bash
   passwd
   ```

7. **launch hydenix**

   reboot and log in.

   after first login, generate theme cache (you only need to do this once):

   ```bash
   hyde-shell reload
   ```
