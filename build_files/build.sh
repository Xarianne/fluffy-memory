#!/bin/bash

# This makes the script exit immediately if a command fails
set -ouex pipefail

### Manual Installation of Hyprland and ML4W Dotfiles

echo "--- Starting Hyprland and Dotfiles Installation (Manual) ---"

# 1. Enable COPR repository for Hyprland
echo "Enabling Hyprland COPR..."
dnf5 -y copr enable solopasha/hyprland

# 2. Install Hyprland and all other required packages
# This list is derived from the ML4W dotfiles installer
echo "Installing Hyprland and all required packages..."
dnf5 -y install \
    git \
    grim \
    slurp \
    swaybg \
    swaylock-effects \
    wlogout \
    wlsunset \
    wl-clipboard \
    waybar \
    mako \
    kanshi \
    thunar \
    polkit-gnome \
    python-requests \
    python-pyquery \
    jq \
    inxi \
    yad \
    imagemagick \
    pavucontrol \
    brightnessctl \
    bluez \
    bluez-tools \
    btop \
    cava \
    neofetch \
    noto-fonts-emoji \
    noto-sans-mono-fonts \
    rofi-wayland \
    xdg-desktop-portal-hyprland \
    hyprland \
    hyprland-devel

# 3. Clone the dotfiles repository
echo "Cloning dotfiles repository..."
git clone https://github.com/mylinuxforwork/dotfiles.git /tmp/ml4w-dotfiles

# 4. Manually copy configuration files
# This copies the configs to /etc/skel, so new users get them by default.
echo "Copying configuration files..."
# Create the target directory
mkdir -p /etc/skel/.config/
# Copy the contents of the 'dot_config' directory from the clone to the target
cp -R /tmp/ml4w-dotfiles/dot_config/* /etc/skel/.config/

# 5. Clean up
echo "Cleaning up..."
# Remove the temporary dotfiles clone
rm -rf /tmp/ml4w-dotfiles

# Disable the COPR repo to keep the final image clean
dnf5 -y copr disable solopasha/hyprland

echo "--- Installation Complete ---"

# Enable other services as needed
systemctl enable podman.socket
