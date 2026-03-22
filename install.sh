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

    ln -sf "$src" "$dest"
    echo "  Linked $dest -> $src"
}

# --------------------------------------------------------------------------- #
# Bash
# --------------------------------------------------------------------------- #
echo ""
echo "[bash]"
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
read -rp "Install DNF packages? [y/N] " yn
if [[ "$yn" =~ ^[Yy]$ ]]; then
    echo "[packages] Installing DNF packages..."
    while read -r pkg; do
        if rpm -q "$pkg" &>/dev/null; then
            echo "  ✓ $pkg (already installed)"
        else
            echo "  Installing $pkg..."
            sudo dnf install -y "$pkg" || echo "  ✗ $pkg (not found in repos)"
        fi
    done < <(grep -v '^#' "$DOTFILES_DIR/packages/dnf-packages.txt" | grep -v '^$')
fi

# --------------------------------------------------------------------------- #
# Go tools
# --------------------------------------------------------------------------- #
echo ""
read -rp "Install Go tools? [y/N] " yn
if [[ "$yn" =~ ^[Yy]$ ]]; then
    echo "[go] Installing Go tools..."
    go install github.com/cortesi/devd/cmd/devd@latest
fi

# --------------------------------------------------------------------------- #
# Flatpak apps
# --------------------------------------------------------------------------- #
echo ""
read -rp "Install Flatpak apps? [y/N] " yn
if [[ "$yn" =~ ^[Yy]$ ]]; then
    echo "[packages] Installing Flatpak apps..."
    grep -v '^#' "$DOTFILES_DIR/packages/flatpaks.txt" | grep -v '^$' | while read -r app; do
        flatpak install -y flathub "$app" 2>/dev/null || echo "  $app already installed or not found"
    done
fi

# --------------------------------------------------------------------------- #
# Remove unnecessary packages (VM guest tools, unused input methods)
# --------------------------------------------------------------------------- #
echo ""
read -rp "Remove unnecessary packages? (re-run after Fedora upgrades) [y/N] " yn
if [[ "$yn" =~ ^[Yy]$ ]]; then
    echo "[cleanup] Removing unnecessary packages..."
    while read -r pkg; do
        if rpm -q "$pkg" &>/dev/null; then
            echo "  Removing $pkg..."
            sudo dnf remove -y "$pkg"
        else
            echo "  ✓ $pkg (not installed)"
        fi
    done < <(grep -v '^#' "$DOTFILES_DIR/packages/dnf-remove.txt" | grep -v '^$')
fi

echo ""
echo "=== Done! ==="
echo "NOTE: You may need to log out and back in for all changes to take effect."
