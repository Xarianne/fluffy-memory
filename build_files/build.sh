#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux

# Enable Hyprland COPR repository
dnf5 -y copr enable @feverfew/hyprland

# Remove KDE components (keeping sddm)
rpm-ostree override remove \
    plasma-desktop \
    kde-settings-fedora \
    kde-runtime \
    krunner \
    kwin

# Install Hyprland and its dependencies
rpm-ostree install \
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

#### Example for enabling a System Unit File
systemctl enable podman.socket
