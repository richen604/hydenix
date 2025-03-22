#!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm

# Add Nix to PATH for the current session and future logins
echo '. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' >>~/.bashrc
echo '. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' >>~/.bash_profile

# Source Nix environment for the current session
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
