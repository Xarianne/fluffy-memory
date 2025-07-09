#!/bin/bash

# This makes the script exit immediately if a command fails
set -ouex pipefail

### Manual Installation of Hyprland and ML4W Dotfiles

echo "--- Starting Hyprland and Dotfiles Installation (Manual) ---"

# 1. Enable COPR repositories, skipping GPG checks
echo "Enabling COPR repositories..."
dnf5 -y copr enable --nogpgcheck solopasha/hyprland
dnf5 -y copr enable --nogpgcheck alternateved/eza

# 2. Install only the necessary additional packages
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

# 5. Create the Hyprland session file for SDDM
echo "Creating Wayland session file for SDDM..."
mkdir -p /usr/share/wayland-sessions
cat > /usr/share/wayland-sessions/hyprland.desktop <<EOF
[Desktop Entry]
Name=Hyprland
Comment=A dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
EOF

# 6. Set required environment variables for Hyprland
echo "Setting environment variables for Hyprland..."
cat > /etc/profile.d/hyprland.sh <<EOF
# This sets the XDG_CURRENT_DESKTOP variable, which is required by
# many applications to function correctly under Hyprland.
export XDG_CURRENT_DESKTOP=Hyprland
EOF
chmod +x /etc/profile.d/hyprland.sh


# 7. Clean up
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
