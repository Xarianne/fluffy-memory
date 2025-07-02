#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Enable the necessary COPR's:
dnf5 -y copr enable solopasha/hyprland

# Installing minimum required hyprland packages for ml4w:
# Removed: libnotify (likely base), qt5-qtwayland, qt6-qtwayland (already in base or handled by hyprland)
dnf5 install -y \
    hyprland \
    hyprpaper \
    hyprlock \
    hypridle \
    hyprpicker \
    noto-fonts \
    xdg-desktop-portal-hyprland \
    kitty

# Installer packages for ml4w (mostly redundant, keeping only gum for now if not in base)
# Removed: wget, zip, unzip, gum, rsync, git, figlet, sed, vim, xdg-user-dirs, man-pages, python-pip
# Keeping 'gum' as it's less common and might not be in the base.
# Retained 'python3-pip' as it was already correct.
dnf5 install -y \
    gum \
    python3-pip

# Installing required ml4w packages - BATCH 1: Core desktop components & utilities
# Removed: xdg-desktop-portal-gtk (using hyprland one), python-screeninfo (keeping python3-gobject only),
# gtk4, libadwaita, fuse, gvfs, flatpak, nautilus, gnome-text-editor, gnome-calculator
dnf5 install -y \
    fastfetch \
    python3-gobject \
    tumbler \
    brightnessctl \
    nm-connection-editor \
    network-manager-applet \
    ImageMagick \
    jq \
    xclip \
    neovim \
    htop \
    rust \
    cargo \
    pinta \
    blueman \
    grim \
    slurp \
    cliphist \
    nwg-look \
    qt6ct \
    waybar \
    rofi-wayland \
    zsh \
    fzf \
    pavucontrol

# Installing required ml4w packages - BATCH 2: Theming, fonts, and remaining apps
dnf5 install -y \
    papirus-icon-theme \
    papirus-icon-theme-dark \
    breeze \
    swaync \
    wlogout \
    hyprshade \
    waypaper \
    grimblast-git \
    bibata-cursor-theme \
    fontawesome-6-free-fonts \
    fira-code-fonts \
    oh-my-posh \
    NetworkManager-tui \
    nwg-dock-hyprland \
    matugen \
    wallust \
    eza \
    mpv \
    imv \
    ffmpegthumbnailer

# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable solopasha/hyprland

#### Example for enabling a System Unit File
systemctl enable podman.socket
