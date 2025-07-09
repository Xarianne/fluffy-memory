#!/bin/bash

# This makes the script exit immediately if a command fails
set -ouex pipefail

### Manual Installation of Hyprland and ML4W Dotfiles

echo "--- Starting Hyprland and Dotfiles Installation (Manual) ---"

# 1. Enable COPR repositories, skipping GPG checks
echo "Enabling COPR repositories..."
dnf5 -y copr enable --nogpgcheck solopasha/hyprland
dnf5 -y copr enable --nogpgcheck alternateved/eza

# 2. Install all required packages, including the Display Manager
echo "Installing all required packages..."
dnf5 -y install --nogpgcheck \
    sddm \
    grim \
    slurp \
    swaybg \
    swaylock \
    wlogout \
    wlsunset \
    waybar \
    mako \
    kanshi \
    thunar \
    polkit \
    NetworkManager-tui \
    wpa_supplicant \
    mtools \
    dosfstools \
    gvfs-smb \
    acpi \
    acpid \
    terminus-fonts \
    eza \
    bat \
    ranger \
    xorg-x11-xinit \
    xclip \
    brightnessctl \
    rofi-wayland \
    xdg-desktop-portal-hyprland \
    hyprland \
    hyprland-devel

# 3. Clone the dotfiles repository
echo "Cloning dotfiles repository..."
git clone --depth=1 https://github.com/mylinuxforwork/dotfiles.git /tmp/ml4w-dotfiles

# 4. Manually copy all configuration files
echo "Copying all configuration files..."
cp -r /tmp/ml4w-dotfiles/. /etc/skel/

# 5. Clean up
echo "Cleaning up..."
rm -rf /tmp/ml4w-dotfiles
dnf5 -y copr disable solopasha/hyprland
dnf5 -y copr disable alternateved/eza

echo "--- Installation Complete ---"

# Enable services. The Display Manager is the most critical one for a graphical login.
systemctl enable sddm
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable firewalld
systemctl enable acpid
