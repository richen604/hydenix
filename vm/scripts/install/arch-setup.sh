#!/bin/bash
set -e

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

echo "This script will set up Arch Linux for Hydenix."
# read -p "Do you want to proceed? (y/n) " REPLY
# echo
# if [[ ! $REPLY =~ ^[Yy]$ ]]; then
#     echo "Setup cancelled."
#     exit 0
# fi

CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/hydenix/config.nix"

if [ -f "$CONFIG_FILE" ]; then
    echo "Config file found. Contents:"
    cat "$CONFIG_FILE"
else
    echo "Config file not found at $CONFIG_FILE"
    exit 1
fi

echo "Using config file: $CONFIG_FILE"

# Function to read values from config.nix
read_config() {
    local result
    result=$(grep "^[[:space:]]*$1[[:space:]]*=" "$CONFIG_FILE" | cut -d '=' -f2- | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | tr -d '";')
    if [ -n "$result" ]; then
        echo "$result"
    else
        echo "Error: Failed to read $1 from config file" >&2
        return 1
    fi
}

# Read configuration values
USERNAME=$(read_config "username")
TIMEZONE=$(read_config "timezone")
LOCALE=$(read_config "locale")
DEFAULT_PASSWORD=$(read_config "defaultPassword")

echo "Setting up Arch Linux with the following configuration:"
echo "Username: $USERNAME"
echo "Timezone: $TIMEZONE"
echo "Locale: $LOCALE"
echo

# read -p "Is this correct? (y/n) " CONFIRM
# if [[ ! $CONFIRM =~ ^[Yy]$ ]]; then
#     echo "Please update your config.nix file and run this script again."
#     exit 1
# fi

# Enable parallel downloads in pacman
echo "Enabling parallel downloads in pacman..."
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

# Update mirrorlist
echo "Updating mirrorlist..."
sudo pacman -S --noconfirm --needed reflector
sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Update package database
sudo pacman -Sy --noconfirm

# Install base packages
echo "Installing base packages..."

# TODO: review
sudo pacman -S --needed --noconfirm \
    zsh polkit udisks2 openssh \
    pipewire pipewire-pulse \
    sddm \
    networkmanager \
    qemu-guest-agent spice-vdagent \
    libvirt \
    upower \
    iptables \
    libinput \
    xf86-input-libinput \
    dconf

# Enable services (without starting them yet)
sudo systemctl enable \
    sshd \
    NetworkManager \
    upower \
    libvirtd

# Set timezone
sudo timedatectl set-timezone "$TIMEZONE"

# Set locale
sudo localectl set-locale LANG="$LOCALE"

# Edit existing user
sudo usermod -aG wheel,video "$USERNAME"
sudo chsh -s /bin/zsh "$USERNAME"
echo "$USERNAME:$DEFAULT_PASSWORD" | sudo chpasswd

# Set up Hyprland to run on boot
echo "Setting up Hyprland to run on boot..."
sudo mkdir -p /usr/share/wayland-sessions
sudo tee /usr/share/wayland-sessions/hyprland.desktop >/dev/null <<EOL
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=nixGL Hyprland
Type=Application
EOL

# Configure SDDM to use Wayland
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/10-wayland.conf >/dev/null <<EOL
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_DISABLE_WINDOWDECORATION=1
EOL

echo "Setup complete. Hyprland will now start on boot. Please reboot your system."
