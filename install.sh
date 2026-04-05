#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Dotfiles Installer ==="
echo "Source: $DOTFILES_DIR"
echo ""

# --------------------------------------------------------------------------- #
# Helper: create a symlink, backing up any existing file
# --------------------------------------------------------------------------- #
link_file() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "  Backing up existing $dest -> ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi

    ln -sfn "$src" "$dest"
    echo "  Linked $dest -> $src"
}

# --------------------------------------------------------------------------- #
# Bash
# --------------------------------------------------------------------------- #
echo ""
echo "[bash]"
link_file "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
link_file "$DOTFILES_DIR/bash/.inputrc" "$HOME/.inputrc"
link_file "$DOTFILES_DIR/bash/bashrc.d" "$HOME/.bashrc.d"

# --------------------------------------------------------------------------- #
# Git
# --------------------------------------------------------------------------- #
echo ""
echo "[git]"
link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# --------------------------------------------------------------------------- #
# Zed (Flatpak)
# --------------------------------------------------------------------------- #
echo ""
echo "[zed]"
mkdir -p "$HOME/.var/app/dev.zed.Zed/config/zed"
link_file "$DOTFILES_DIR/zed/settings.json" "$HOME/.var/app/dev.zed.Zed/config/zed/settings.json"

# --------------------------------------------------------------------------- #
# GNOME dconf settings
# --------------------------------------------------------------------------- #
echo ""
echo "[gnome] Loading dconf settings..."
if command -v dconf &>/dev/null; then
    dconf load / < "$DOTFILES_DIR/gnome/dconf-settings.ini"

    # Ptyxis palette: apply to whatever the current default profile is
    PTYXIS_UUID=$(dconf read /org/gnome/Ptyxis/default-profile-uuid 2>/dev/null | tr -d "'")
    if [ -n "$PTYXIS_UUID" ]; then
        dconf write "/org/gnome/Ptyxis/Profiles/${PTYXIS_UUID}/palette" "'Ayu'"
        echo "  Ptyxis Ayu palette applied to profile $PTYXIS_UUID"
    fi

    echo "  dconf settings loaded."
else
    echo "  WARNING: dconf not found, skipping GNOME settings."
fi

# --------------------------------------------------------------------------- #
# GNOME extensions (informational)
# --------------------------------------------------------------------------- #
echo ""
echo "[gnome] Extensions to install (use Extension Manager or extensions.gnome.org):"
grep -v '^#' "$DOTFILES_DIR/gnome/extensions.txt" | grep -v '^$' | while read -r ext; do
    echo "  - $ext"
done

# --------------------------------------------------------------------------- #
# DNF packages
# --------------------------------------------------------------------------- #
echo ""
echo "[packages] Installing DNF packages..."
while read -r pkg; do
    if rpm -q "$pkg" &>/dev/null; then
        echo "  ✓ $pkg (already installed)"
    else
        echo "  Installing $pkg..."
        sudo dnf install -y "$pkg" || echo "  ✗ $pkg (not found in repos)"
    fi
done < <(grep -v '^#' "$DOTFILES_DIR/packages/dnf-packages.txt" | grep -v '^$')


# --------------------------------------------------------------------------- #
# Flatpak apps
# --------------------------------------------------------------------------- #
echo ""
echo "[packages] Installing Flatpak apps..."
grep -v '^#' "$DOTFILES_DIR/packages/flatpaks.txt" | grep -v '^$' | while read -r app; do
    flatpak install -y flathub "$app" 2>/dev/null || echo "  $app already installed or not found"
done

# --------------------------------------------------------------------------- #
# Keymapp (ZSA Voyager keyboard configurator)
# --------------------------------------------------------------------------- #
echo ""
echo "[voyager] Installing Keymapp..."
KEYMAPP_DIR="$HOME/.local/bin"
KEYMAPP_URL="https://oryx.nyc3.cdn.digitaloceanspaces.com/keymapp/keymapp-latest.tar.gz"
mkdir -p "$KEYMAPP_DIR"

if [ -x "$KEYMAPP_DIR/keymapp" ]; then
    echo "  Keymapp already installed at $KEYMAPP_DIR/keymapp"
    echo "  Re-downloading to update..."
fi

echo "  Downloading Keymapp..."
curl -fSL "$KEYMAPP_URL" -o /tmp/keymapp.tar.gz
tar -xzf /tmp/keymapp.tar.gz -C "$KEYMAPP_DIR"
chmod +x "$KEYMAPP_DIR/keymapp"
rm -f /tmp/keymapp.tar.gz
echo "  Installed keymapp to $KEYMAPP_DIR/keymapp"

KEYMAPP_ICON_DIR="$HOME/.local/share/icons"
mkdir -p "$KEYMAPP_ICON_DIR"
if [ -f "$KEYMAPP_DIR/icon.png" ]; then
    mv "$KEYMAPP_DIR/icon.png" "$KEYMAPP_ICON_DIR/keymapp.png"
    echo "  Icon installed to $KEYMAPP_ICON_DIR/keymapp.png"
fi

echo "  Installing udev rules for ZSA keyboards..."
sudo cp "$DOTFILES_DIR/voyager/50-zsa.rules" /etc/udev/rules.d/50-zsa.rules
sudo udevadm control --reload-rules
echo "  udev rules installed and reloaded."

if ! groups "$USER" | grep -q plugdev; then
    echo "  Adding $USER to plugdev group..."
    sudo groupadd -f plugdev
    sudo usermod -aG plugdev "$USER"
    echo "  NOTE: Log out and back in for group membership to take effect."
fi

echo "  Installing desktop entry..."
mkdir -p "$HOME/.local/share/applications"
cp "$DOTFILES_DIR/voyager/keymapp.desktop" "$HOME/.local/share/applications/keymapp.desktop"
echo "  Desktop entry installed."

# --------------------------------------------------------------------------- #
# Remove unnecessary packages (VM guest tools, unused input methods)
# --------------------------------------------------------------------------- #
echo ""
echo "[cleanup] Removing unnecessary packages..."
while read -r pkg; do
    if rpm -q "$pkg" &>/dev/null; then
        echo "  Removing $pkg..."
        sudo dnf remove -y "$pkg"
    else
        echo "  ✓ $pkg (not installed)"
    fi
done < <(grep -v '^#' "$DOTFILES_DIR/packages/dnf-remove.txt" | grep -v '^$')

echo ""
echo "=== Done! ==="
echo "NOTE: You may need to log out and back in for all changes to take effect."
