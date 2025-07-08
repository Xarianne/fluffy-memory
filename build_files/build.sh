#!/bin/bash

set -ouex pipefail

### Install packages

# --- Add your Hyprland installation here ---

# Enable solopasha/hyprland COPR for potentially newer versions
dnf5 -y copr enable solopasha/hyprland

# Install Hyprland and its development packages, and xdg-desktop-portal-hyprland
dnf5 -y install hyprland hyprland-devel xdg-desktop-portal-hyprland

# Install git and chezmoi for dotfile management
dnf5 -y install git chezmoi

# Optional: Clone ML4W dotfiles and apply them to /etc/skel for new users
# Adjust the git clone URL to your specific dotfiles repository
mkdir -p /etc/skel/.config
git clone https://github.com/mylinuxforwork/dotfiles.git /tmp/ml4w-dotfiles
cd /tmp/ml4w-dotfiles
chezmoi init --apply --destination /etc/skel
rm -rf /tmp/ml4w-dotfiles

# It's good practice to disable COPRs if you don't want them enabled on the final image
dnf5 -y copr disable solopasha/hyprland

# --- End Hyprland installation ---

# ... (your other build.sh content like systemctl enable) ...
systemctl enable podman.socket
