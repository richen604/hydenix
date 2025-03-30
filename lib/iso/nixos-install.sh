#!/usr/bin/env bash

set -euo pipefail

cat <<"EOF"
  _    _           _            _
 | |  | |         | |          (_)
 | |__| |_   _  __| | ___ _ __  ___  __
 |  __  | | | |/ _` |/ _ \ '_ \| \ \/ /
 | |  | | |_| | (_| |  __/ | | | |>  <
 |_|  |_|\__, |\__,_|\___|_| |_|_/_/\_\
          __/ |
         |___/       ❄️ Powered by Nix ❄️
EOF

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
  echo -e "${RED}Please run as root${NC}"
  exit 1
fi

# Check for required commands
check_requirements() {
  local required_commands=("wipefs" "parted" "mkfs.fat" "mkfs.ext4" "lsblk" "fzf")
  local missing_commands=()

  for cmd in "${required_commands[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      missing_commands+=("$cmd")
    fi
  done

  if [ ${#missing_commands[@]} -ne 0 ]; then
    echo -e "${RED}Error: Required commands not found: ${missing_commands[*]}${NC}"
    exit 1
  fi
}

# Calculate swap size based on RAM
get_swap_size() {
  local mem_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
  local mem_gb=$((mem_kb / 1024 / 1024))
  
  if [ $mem_gb -le 2 ]; then
    echo $((mem_gb * 2))
  elif [ $mem_gb -le 8 ]; then
    echo $mem_gb
  else
    echo 8
  fi
}

# Select installation drive
select_drive() {
  # Check if any block devices exist
  if ! lsblk -d -p -n -l -o NAME,SIZE,MODEL > /dev/null 2>&1; then
    echo -e "${RED}Error: Unable to list block devices. Are you running in a virtual environment?${NC}"
    echo -e "${RED}Debug info:${NC}"
    ls -l /dev/sd* /dev/nvme* /dev/vd* 2>&1 || true
    echo
    exit 1
  fi
  
  local drives=$(lsblk -d -p -n -l -o NAME,SIZE,MODEL | grep -v "loop")
  if [ -z "$drives" ]; then
    echo -e "${RED}Error: No valid drives found${NC}"
    exit 1
  fi

  # Quote the selection to handle whitespace properly
  local selection
  selection=$(echo "$drives" | fzf --header "Select installation drive" --height=10)
  if [ -z "$selection" ]; then
    echo -e "${RED}No drive selected${NC}"
    exit 1
  fi
  # Extract just the device path and ensure it's trimmed
  echo "$selection" | awk '{print $1}' | tr -d '[:space:]'
}

# Detect boot mode
detect_boot_mode() {
  if [ -d "/sys/firmware/efi" ]; then
    echo "uefi"
  else
    echo -e "${RED}Warning: UEFI boot mode not detected. NixOS strongly recommends UEFI boot.${NC}"
    read -p "Continue with legacy BIOS boot anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      exit 1
    fi
    echo "bios"
  fi
}

# Main installation function
main() {
  # Check requirements first
  check_requirements
  
  echo -e "${RED}╔════════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${RED}║  STOP! READ CAREFULLY OR YOU MAY PERMANENTLY LOSE DATA!        ║${NC}"
  echo -e "${RED}╚════════════════════════════════════════════════════════════════╝${NC}"
  echo
  
  # Explain partitioning scheme and give option to exit
  echo -e "${BLUE}This script will perform a simple automated NixOS installation with:${NC}"
  echo "  • A two-partition layout (boot + root)"
  echo "  • No separate partitions for /home, /var, etc."
  echo "  • A swap file instead of a swap partition"
  echo
  echo -e "For UEFI systems (recommended):"
  echo "  • GPT partition table"
  echo "  • 512MiB EFI System Partition (ESP) formatted as FAT32"
  echo "  • Remaining space as ext4 root partition"
  echo
  echo -e "For Legacy BIOS systems (fallback):"
  echo "  • MBR partition table"
  echo "  • 512MiB boot partition"
  echo "  • Remaining space as ext4 root partition"
  echo
  
  # Calculate and show swap size
  local swap_size
  swap_size=$(get_swap_size)
  echo -e "${BLUE}Based on your system memory:${NC}"
  echo "  • Swap file size: ${swap_size}GB"
  echo
  
  echo -e "${RED}WARNING: THIS WILL COMPLETELY ERASE THE SELECTED DRIVE!${NC}"
  echo -e "${BLUE}If you need a custom partition layout (separate /home, encryption, etc.),${NC}"
  echo -e "${BLUE}please exit and follow the manual partitioning instructions at:${NC}"
  echo -e "${GREEN}https://nixos.org/manual/nixos/stable/#ch-installation${NC}"
  echo

  # SECTION 1: PARTITIONING
  echo -e "${BLUE}=== SECTION 1: DRIVE SELECTION AND PARTITIONING ===${NC}"
  read -p "Continue with drive selection and partitioning? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Exiting installation. No changes were made.${NC}"
    exit 0
  fi
  
  # Select drive
  local selected_drive
  selected_drive="$(select_drive)"
  if [ ! -b "$selected_drive" ]; then
    echo -e "${RED}Error: Invalid drive selected: $selected_drive${NC}"
    exit 1
  fi
  echo -e "${GREEN}Selected drive: $selected_drive${NC}"

  # Confirm selection
  read -p "This will ERASE ALL DATA on $selected_drive. Continue? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Exiting installation. No changes were made.${NC}"
    exit 1
  fi

  # Detect boot mode
  local boot_mode
  boot_mode=$(detect_boot_mode)
  echo -e "${BLUE}Detected boot mode: $boot_mode${NC}"

  # Calculate sizes
  local swap_size
  swap_size=$(get_swap_size)
  echo -e "${BLUE}Calculated swap size: ${swap_size}GB${NC}"

  # Wipe existing signatures
  wipefs -a "$selected_drive"

  # Partition drive
  if [ "$boot_mode" = "uefi" ]; then
    # GPT/UEFI partitioning (preferred)
    parted "$selected_drive" -- mklabel gpt
    parted "$selected_drive" -- mkpart ESP fat32 1MiB 512MiB
    parted "$selected_drive" -- set 1 esp on
    parted "$selected_drive" -- mkpart primary 512MiB 100%
  else
    # MBR/BIOS partitioning (fallback)
    echo -e "${RED}Warning: Using legacy BIOS boot mode. Some NixOS features may not work correctly.${NC}"
    parted "$selected_drive" -- mklabel msdos
    parted "$selected_drive" -- mkpart primary 1MiB 512MiB
    parted "$selected_drive" -- set 1 boot on
    parted "$selected_drive" -- mkpart primary 512MiB 100%
  fi

  # Format partitions
  local boot_partition
  local root_partition
  
  # Handle different drive naming schemes (NVME vs SATA/IDE)
  if [[ "$selected_drive" == *"nvme"* ]]; then
    boot_partition="${selected_drive}p1"
    root_partition="${selected_drive}p2"
  else
    boot_partition="${selected_drive}1"
    root_partition="${selected_drive}2"
  fi

  mkfs.fat -F 32 -n NIXBOOT "$boot_partition"
  mkfs.ext4 -L NIXROOT "$root_partition"
  
  echo -e "${GREEN}Partitioning and formatting complete!${NC}"
  
  # SECTION 2: MOUNTING AND SWAP
  echo -e "${BLUE}=== SECTION 2: MOUNTING PARTITIONS AND CREATING SWAP ===${NC}"
  read -p "Continue with mounting partitions and creating swap? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Partitioning completed but installation aborted. Your drive has been partitioned but no files were copied.${NC}"
    exit 0
  fi

  # Mount partitions
  if [ -e "/dev/disk/by-label/NIXROOT" ] && [ -e "/dev/disk/by-label/NIXBOOT" ]; then
    # Try mounting by labels first
    mount /dev/disk/by-label/NIXROOT /mnt
    mkdir -p /mnt/boot
    mount /dev/disk/by-label/NIXBOOT /mnt/boot
  else
    # Fall back to direct device mounting
    echo -e "${BLUE}Waiting for partition labels to be available...${NC}"
    sleep 2  # Give udev a moment to create the labels
    
    # Try one more time with labels
    if [ -e "/dev/disk/by-label/NIXROOT" ] && [ -e "/dev/disk/by-label/NIXBOOT" ]; then
      mount /dev/disk/by-label/NIXROOT /mnt
      mkdir -p /mnt/boot
      mount /dev/disk/by-label/NIXBOOT /mnt/boot
    else
      # Fall back to direct device mounting
      echo -e "${BLUE}Mounting partitions directly by device...${NC}"
      mount "$root_partition" /mnt
      mkdir -p /mnt/boot
      mount "$boot_partition" /mnt/boot
    fi
  fi

  # Create and enable swap file
  dd if=/dev/zero of=/mnt/.swapfile bs=1G count=$swap_size status=progress
  chmod 600 /mnt/.swapfile
  mkswap /mnt/.swapfile
  swapon /mnt/.swapfile

  # Generate NixOS config
  nixos-generate-config --root /mnt
  
  echo -e "${GREEN}Partitions mounted and swap file created!${NC}"
  
  # SECTION 3: HYDENIX TEMPLATING AND INSTALLATION
  echo -e "${BLUE}=== SECTION 3: CONFIGURATION AND INSTALLATION ===${NC}"
  read -p "Continue with configuration and installation? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Partitioning and mounting completed but installation aborted.${NC}"
    echo -e "${BLUE}Your drive has been partitioned and mounted at /mnt.${NC}"
    echo -e "${BLUE}You can continue with manual installation if desired.${NC}"
    exit 0
  fi

  # Copy template to installation target
  if [ -d "/home/nixos/hydenix" ]; then
    echo -e "${GREEN}Hydenix configuration template found!${NC}"
    echo -e "${BLUE}Copying Hydenix template to installation target...${NC}"
    cp -r /home/nixos/hydenix /mnt/etc/
    chmod -R u+w /mnt/etc/hydenix
    
    # Generate hardware configuration
    echo -e "${BLUE}Generating hardware configuration...${NC}"
    nixos-generate-config --root /mnt --show-hardware-config > /mnt/etc/hydenix/hardware-configuration.nix
    
    echo -e "${GREEN}Basic system configuration complete!${NC}"
    
    # Ask if user wants to edit configuration before installing
    echo -e "${BLUE}Would you like to edit configuration.nix before installing? (y/N)${NC}"
    read -r edit_config
    
    if [[ $edit_config =~ ^[Yy]$ ]]; then
      # Determine which editor to use
      if command -v nano >/dev/null 2>&1; then
        EDITOR="nano"
      else
        EDITOR="vim"
      fi
      
      echo -e "${BLUE}Opening configuration.nix with $EDITOR...${NC}"
      $EDITOR /mnt/etc/hydenix/configuration.nix
      
      echo -e "${GREEN}Configuration saved!${NC}"
    fi
    
    # Final confirmation before installation
    echo -e "${BLUE}Ready to install NixOS. This is the final step.${NC}"
    read -p "Proceed with installation? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo -e "${GREEN}Configuration completed but installation aborted.${NC}"
      echo -e "${BLUE}Your drive has been partitioned, mounted, and configured at /mnt.${NC}"
      echo -e "${BLUE}You can continue with manual installation by running: nixos-install --root /mnt --flake \"/mnt/etc/hydenix#nixos\"${NC}"
      exit 0
    fi
    
    # Install with default hostname and prompt for root password
    echo -e "${BLUE}Installing Hydenix using flake...${NC}"
    echo -e "${BLUE}You will be prompted to set the root password during installation.${NC}"
    nixos-install --root /mnt --flake "/mnt/etc/hydenix#nixos"
    
    echo -e "${GREEN}Hydenix installation complete!${NC}"
    echo -e "${BLUE}You can now reboot into your new system.${NC}"
    echo "Run: reboot"
  else
    echo -e "${RED}Hydenix template not found. Falling back to manual configuration.${NC}"
    echo -e "${GREEN}Basic system configuration complete!${NC}"
    echo -e "${BLUE}Next steps:${NC}"
    echo "1. Edit /mnt/etc/nixos/configuration.nix"
    echo "2. Run nixos-install"
    echo "3. Set root password"
    echo "4. Reboot"
  fi
}

main "$@"