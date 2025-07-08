#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y \
#   app1 \
#   app2 \

# Enable solopasha/hyprland COPR (optional, but recommended for latest features)
RUN dnf5 -y copr enable solopasha/hyprland

# Install Hyprland and its development packages (for plugins/tools)
RUN dnf5 -y install hyprland hyprland-devel xdg-desktop-portal-hyprland

# Install git and chezmoi
RUN dnf5 -y install git chezmoi

# Clone ML4W dotfiles and apply them to /etc/skel
# This ensures new users get these dotfiles
RUN mkdir -p /etc/skel/.config && \
    git clone https://github.com/mylinuxforwork/dotfiles.git /tmp/ml4w-dotfiles && \
    cd /tmp/ml4w-dotfiles && \
    chezmoi init --apply --destination /etc/skel && \
    rm -rf /tmp/ml4w-dotfiles

dnf5 copr -y disable solopasha/hyprland

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging



#### Example for enabling a System Unit File

systemctl enable podman.socket
