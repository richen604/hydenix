{
  hydenix-inputs,
  ...
}:
let

  hydenix-pkgs = import hydenix-inputs.hydenix-nixpkgs {
    inherit (hydenix-inputs.lib) system;
    config.allowUnfree = true;
    overlays = [
      hydenix-inputs.lib.overlays
    ];
  };

  # Add the ISO image module
  isoImageModule = "${hydenix-inputs.hydenix-nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix";

  # Create the base ISO configuration
  isoSystem = hydenix-inputs.hydenix-nixpkgs.lib.nixosSystem {
    inherit (hydenix-inputs.lib) system;
    modules = [
      isoImageModule
      {
        # Explicitly allow unfree packages in the ISO
        nixpkgs.config.allowUnfree = true;

        # Enable nix experimental features
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

        # Live USB settings
        isoImage.makeEfiBootable = true;
        isoImage.makeUsbBootable = true;
        isoImage.squashfsCompression = "zstd -Xcompression-level 6"; # Better compression ratio and speed

        # ISO-specific configuration
        isoImage.edition = hydenix-pkgs.lib.mkForce "hydenix";
        isoImage.isoName = hydenix-pkgs.lib.mkForce "hydenix-${hydenix-inputs.hydenix-nixpkgs.lib.version}.iso";

        # Improve boot experience
        boot.kernelParams = [
          # Better hardware compatibility
          "nomodeset"
          "i915.modeset=1"
          "nouveau.modeset=1"
          # Improve boot messages
          "boot.shell_on_fail"
          # Memory management improvements
          "zswap.enabled=1"
        ];

        # Better hardware support
        hardware.enableRedistributableFirmware = true;
        hardware.enableAllFirmware = true;

        # Add installation script and required packages to ISO
        environment.systemPackages = with hydenix-pkgs; [
          (writeScriptBin "hydenix-install" (builtins.readFile ./nixos-install.sh))
          # Required by installation script
          fzf
          parted
          dosfstools # for mkfs.fat
          e2fsprogs # for mkfs.ext4
          util-linux # for wipefs, lsblk
          util-linux.bin
          git
          vim
          nano # More beginner-friendly editor
          curl
          wget
          htop # System monitoring

          # Networking tools
          networkmanager # Includes nmcli
          iw
          wirelesstools

          # Hardware detection and management
          pciutils # for lspci
          usbutils # for lsusb
          dmidecode # for system information

          # Filesystem tools
          gptfdisk # for gdisk/sgdisk (advanced partitioning)
          ntfs3g # for NTFS support (dual-boot scenarios)
          btrfs-progs # for btrfs support
          xfsprogs # for XFS support

          # Compression tools
          gzip
          bzip2
          xz
          zip
          unzip

          # Troubleshooting tools
          lshw # List hardware
          smartmontools # Disk health

          # Documentation
          man-pages
          man-pages-posix
        ];

        # Enable NetworkManager
        networking.networkmanager.enable = true;
        networking.wireless.enable = false; # Disable wpa_supplicant as we're using NetworkManager

        # Better hardware support
        services.xserver.videoDrivers = [
          "modesetting"
          "fbdev"
          "vesa"
        ];
        services.fwupd.enable = true; # Firmware updates

        # Improve console experience
        console = {
          font = "Lat2-Terminus16";
          keyMap = hydenix-pkgs.lib.mkForce "us";
          useXkbConfig = true;
        };

        # Copy installation script to home directory
        system.activationScripts.copyTemplate =
          let
            # This allows us to use this script for both the default ISO and user template flake
            configPath = if builtins.pathExists ../../template then ../../template else ../..;
          in
          ''
            mkdir -p /home/nixos
            cp -r ${configPath} /home/nixos/hydenix
            chmod -R u+w /home/nixos/hydenix
            chown -R nixos:nixos /home/nixos/hydenix

            # Create a helpful README in the home directory
            cat > /home/nixos/README.txt << 'EOF'
            HydeNix Installation Guide
            =========================

            Quick Start:
            1. Run 'hydenix-install' for guided installation

            For WiFi:
            - Run 'nmtui' for a text-based network manager
            - Or use 'nmcli device wifi connect <SSID> password <password>'

            For troubleshooting:
            - Check hardware: lspci, lsusb, lshw
            - Check disks: fdisk -l, smartctl -a /dev/sdX
            - Check logs: journalctl -xe

            Need more help? Visit: https://github.com/richen604/hydenix
            EOF

            chmod 644 /home/nixos/README.txt
            chown nixos:nixos /home/nixos/README.txt
          '';

        # Display welcome message and instructions at boot
        services.getty.helpLine = ''
          Welcome to HydeNix! 💻

          WiFi Setup:
          - Use 'nmtui' for text-based network configuration
          - Or use 'nmcli device wifi connect <SSID> password <password>'

          To start the installation:
          1. Run 'hydenix-install' to start the guided installation
          2. Follow the on-screen prompts

          For help, read /home/nixos/README.txt or visit: https://github.com/richen604/hydeni
        '';

        # Better internationalization support
        i18n = {
          supportedLocales = [ "all" ];
          defaultLocale = "en_US.UTF-8";
        };

        # Auto-login for live system
        services.getty.autologinUser = "nixos";

        # Set timezone to UTC by default
        time.timeZone = "UTC";
      }
    ];
  };
in
{

  # Add a build-iso script that can be run with 'nix run'
  build-iso = hydenix-pkgs.writeScriptBin "build-iso" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Colors for output
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color

    # Get the actual ISO path
    ISO_DIR="${isoSystem.config.system.build.isoImage}"

    echo -e "''${BLUE}Building HydeNix ISO...''${NC}"
    echo -e "''${BLUE}This may take a while depending on your system.''${NC}"

    # Create the output directory if it doesn't exist
    mkdir -p ./result

    # Find the ISO file
    if [ -d "$ISO_DIR/iso" ]; then
      ISO_PATH=$(find "$ISO_DIR/iso" -name "*.iso" -type f)
    else
      ISO_PATH=$(find "$ISO_DIR" -name "*.iso" -type f)
    fi

    if [ -z "$ISO_PATH" ]; then
      echo -e "''${RED}Error: Could not find ISO file in $ISO_DIR''${NC}"
      echo "Directory contents:"
      find "$ISO_DIR" -type f | sort
      exit 1
    fi

    # Copy the ISO to the current directory
    echo -e "''${BLUE}Copying ISO to ./result directory...''${NC}"
    cp -v "$ISO_PATH" ./result/

    ISO_FILENAME=$(basename "$ISO_PATH")

    echo -e "''${GREEN}ISO built successfully!''${NC}"
    echo -e "''${BLUE}Your ISO is available at:''${NC} ./result/$ISO_FILENAME"
    echo
    echo -e "''${BLUE}To burn this ISO to a USB drive, you can use:''${NC}"
    echo "nix run .#burn-iso -- ./result/$ISO_FILENAME /dev/sdX"
    echo -e "''${BLUE}(Replace /dev/sdX with your USB device)''${NC}"
  '';

  burn-iso = hydenix-pkgs.writeScriptBin "burn-iso" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Colors for output
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color

    if [ $# -ne 2 ]; then
      echo -e "''${BLUE}Usage:''${NC} burn-iso <iso-file> <device>"
      echo -e "''${BLUE}Example:''${NC} burn-iso hydenix.iso /dev/sdb"
      echo -e "\n''${BLUE}Available devices:''${NC}"
      lsblk -d -o NAME,SIZE,TYPE,MODEL,MOUNTPOINT
      exit 1
    fi

    ISO_FILE=$1
    DEVICE=$2

    if [ ! -f "$ISO_FILE" ]; then
      echo -e "''${RED}Error: ISO file '$ISO_FILE' not found''${NC}"
      exit 1
    fi

    # Check if device exists
    if [ ! -b "$DEVICE" ]; then
      echo -e "''${RED}Error: Device '$DEVICE' does not exist or is not a block device''${NC}"
      echo -e "''${BLUE}Available devices:''${NC}"
      lsblk -d -o NAME,SIZE,TYPE,MODEL,MOUNTPOINT
      exit 1
    fi

    # Check if device is mounted
    if grep -q "$DEVICE" /proc/mounts; then
      echo -e "''${RED}Warning: Device '$DEVICE' is currently mounted''${NC}"
      echo "Mounted partitions:"
      grep "$DEVICE" /proc/mounts
      echo -e "''${BLUE}Please unmount all partitions before continuing''${NC}"
      read -p "Attempt to unmount all partitions? (y/N) " -n 1 -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        for mount in $(grep "$DEVICE" /proc/mounts | awk '{print $2}'); do
          echo "Unmounting $mount..."
          sudo umount "$mount"
        done
      else
        exit 1
      fi
    fi

    echo -e "''${RED}WARNING: This will ERASE ALL DATA on $DEVICE''${NC}"
    echo -e "''${BLUE}Device details:''${NC}"
    lsblk "$DEVICE" -o NAME,SIZE,TYPE,MODEL,MOUNTPOINT
    echo
    echo -e "''${RED}Double-check that this is the correct device!''${NC}"
    read -p "Are you absolutely sure you want to continue? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo -e "''${BLUE}Formatting device...''${NC}"
      sudo wipefs -a "$DEVICE"
      
      echo -e "''${BLUE}Writing ISO to device...''${NC}"
      # Calculate ISO size for progress reporting
      ISO_SIZE=$(stat -c %s "$ISO_FILE")
      sudo dd bs=4M if="$ISO_FILE" of="$DEVICE" conv=fsync status=progress
      
      echo -e "''${BLUE}Syncing...''${NC}"
      sync
      
      echo -e "''${GREEN}Done! You can now safely remove the device.''${NC}"
      echo -e "''${BLUE}To boot from this device:''${NC}"
      echo "1. Restart your computer"
      echo "2. Enter your BIOS/UEFI settings (usually by pressing F2, F12, DEL, or ESC during startup)"
      echo "3. Select this device as the boot device"
      echo "4. Save and exit"
    fi
  '';
}
