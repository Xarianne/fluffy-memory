#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Remove KDE components (keeping sddm)
rpm-ostree override remove \
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

# Use a COPR Example:
dnf5 y copr enable solopasha/hyprland
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

# this installs a package from fedora repos
dnf5 install -y hyprland \
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

#### Example for enabling a System Unit File

systemctl enable podman.socket
