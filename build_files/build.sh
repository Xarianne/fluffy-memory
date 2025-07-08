#!/bin/bash

set -ouex pipefail

### Install packages & Run ML4W Installer

# Enable solopasha/hyprland COPR for newer versions
dnf5 -y copr enable solopasha/hyprland

# Clone ml4w dotfiles repository
git clone https://github.com/mylinuxforwork/dotfiles.git /tmp/ml4w-dotfiles

# Run your Fedora-specific installer script
# The -i flag is used to accept all confirmations
/tmp/ml4w-dotfiles/setup-fedora.sh -i

# Clean up the cloned repository
rm -rf /tmp/ml4w-dotfiles

# Disable the COPR repo
dnf5 -y copr disable solopasha/hyprland

# ... (your other build.sh content like systemctl enable) ...
systemctl enable podman.socket
