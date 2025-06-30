#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Ensure /root/.gnupg exists for gpg operations
mkdir -p /root/.gnupg && chmod 0700 /root/.gnupg

# Enable Hyprland COPR repository
dnf5 -y copr enable solopasha/hyprland

# Enable nwg-shell COPR repository
dnf5 -y copr enable tofik/nwg-shell

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

# Install Hyprland and its dependencies
# Removed 'wl-clipboard' as it's already installed.
# Replaced 'polkit-kde-agent' with 'polkit-gnome'.
dnf5 -y install \
    hyprland \
    xdg-desktop-portal-hyprland \
    foot \
    waybar \
    wofi \
    swaybg \
    grim \
    slurp \
    pamixer \
    polkit-gnome # Using polkit-gnome as an alternative polkit agent

# Install nwg-shell
dnf5 -y install \
    nwg-shell

# Execute the nwg-shell installer script for ostree systems
# This script is expected to be placed in your build_files directory.
/ctx/fedora-ostree.sh -a # The -a flag is for "auto-install" if the script supports it, check script for exact flags

# NOT disabling the COPRs, so you continue to get updates

#### Example for enabling a System Unit File
systemctl enable podman.socket
