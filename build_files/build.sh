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
dnf5 install -y \
    hyprland \
    hyprpaper \
    hyprlock \
    hypridle \
    hyprpicker \
    noto-fonts \
    xdg-desktop-portal-hyprland \
    libnotify \
    kitty \
    qt5-qtwayland \
    qt6-qtwayland \

# Installer packages for ml4w (might not be needed, review later):
dnf5 install -y \
    wget \
    zip \
    unzip \
    gum \
    rsync \
    git \
    figlet \
    sed \
    vim \
    xdg-user-dirs \
    man-pages \
    python3-pip \

# Installing required ml4w packages:
dnf5 install -y \
    fastfetch \
    xdg-desktop-portal-gtk \
    python3-gobject \
    python-screeninfo \
    tumbler \
    brightnessctl \
    nm-connection-editor \
    network-manager-applet \
    gtk4 \
    libadwaita \
    fuse \
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
    pavucontrol \
    papirus-icon-theme \
    papirus-icon-theme-dark \
    breeze \
    swaync \
    gvfs \
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
    flatpak \
    wallust \
    eza \
    nautilus \
    gnome-text-editor \
    gnome-calculator \
    mpv \
    imv \
    ffmpegthumbnailer \

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging
dnf5 -y copr disable solopasha/hyprland

#### Example for enabling a System Unit File

systemctl enable podman.socket
