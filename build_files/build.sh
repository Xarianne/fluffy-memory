#!/bin/bash

set -ouex pipefail

### Manual Installation of Hyprland and ML4W Dotfiles

# 1. Enable COPR repository for Hyprland
dnf5 -y copr enable solopasha/hyprland

# 2. Install Hyprland and git
dnf5 -y install hyprland hyprland-devel xdg-desktop-portal-hyprland git

# 3. Install chezmoi binary
# This downloads the chezmoi binary and places it in /usr/local/bin
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

# 4. Clone and apply the dotfiles
# First, clone the dotfiles repository to a temporary location
git clone https://github.com/mylinuxforwork/dotfiles.git /tmp/ml4w-dotfiles
cd /tmp/ml4w-dotfiles

# Now, use chezmoi to apply the configuration to the /etc/skel directory.
# This ensures that any new user created will get these dotfiles.
/usr/local/bin/chezmoi init --apply --destination /etc/skel

# 5. Clean up
# Remove the temporary dotfiles clone
rm -rf /tmp/ml4w-dotfiles

# Disable the COPR repo to keep the final image clean
dnf5 -y copr disable solopasha/hyprland

# --- End Manual Installation ---

# Enable other services as needed
systemctl enable podman.socket
