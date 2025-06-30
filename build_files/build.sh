#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos


# Enable Hyprland COPR repository
dnf5 -y copr enable solopasha/hyprland

# Remove KDE Plasma desktop components (keeping sddm)
dnf5 -y remove \
    plasma-workspace-common \
    plasma-activities \
    plasma-activities-stats \
    kde-settings-plasma \
    libplasma \
    plasma-systemsettings \
    plasma5support \
    plasma-discover-libs \
    plasma-integration-qt5 \
    plasma-integration \
    plasma-workspace-libs \
    plasma-discover \
    plasma-nm \
    plasma-desktop \
    plasma-lookandfeel-fedora \
    plasma-workspace \
    plasma-workspace-wayland \
    plasma-print-manager-libs \
    plasma-print-manager \
    plasma-nm-vpnc \
    plasma-nm-openvpn \
    plasma-nm-openconnect \
    plasma-discover-flatpak \
    plasma-discover-notifier \
    kdeplasma-addons \
    plasma-systemmonitor \
    plasma-pa \
    plasma-vault \
    plasma-disks \
    plasma-thunderbolt \
    plasma-milou \
    plasma-workspace-wallpapers \
    plasma-desktop-doc

# Install Hyprland and its immediate dependencies (already listed)
dnf5 -y install \
    hyprland \
    xdg-desktop-portal-hyprland \
    foot \
    waybar \
    wofi \
    swaybg \
    grim \
    slurp \
    wl-clipboard \
    pamixer \
    polkit-kde-agent

# Install dependencies for the new dotfiles
dnf5 -y install \
    kitty \
    neovim \
    rofi \
    qt6ct \
    xsettingsd \
    fastfetch \
    # swaync, wlogout, nwg-dock-hyprland might need specific COPRs or building.
    # Check if a COPR is available for these or if they are in the Hyprland COPR.
    # Example for a COPR if needed: dnf5 -y copr enable <owner>/<project>
    # oh-my-posh, matugen, wallust might be pip installed or have specific install methods.
    # For oh-my-posh, it's often a curl | bash install or specific releases.
    # For matugen/wallust, check if they have RPMs or if pip install is needed in a custom script.
    # Example if installing via pip: dnf5 install -y python3-pip && pip install matugen wallust

# Copy dotfiles from the 'dotfiles' directory into /etc/skel/
# This makes them default for new users.
# Assuming .config contains all the folders listed:
mkdir -p /etc/skel/.config && \
cp -r /ctx/dotfiles/.config/* /etc/skel/.config/ && \
# If you have custom shell config files directly in the dotfiles repo root (e.g., .bashrc, .zshrc)
# cp /ctx/dotfiles/.bashrc /etc/skel/
# cp /ctx/dotfiles/.zshrc /etc/skel/

# NOT disabling the COPR, so you continue to get updates

#### Example for enabling a System Unit File
systemctl enable podman.socket
