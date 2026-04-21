#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Dotfiles Installer ==="
echo "Source: $DOTFILES_DIR"
echo ""

# Prime sudo credentials upfront and keep them alive while the installer runs.
# Long downloads (luau-lsp, keymapp) can otherwise exceed the 5-minute sudo cache
# and leave later `sudo` calls to fail non-interactively.
sudo -v
(while true; do sudo -n true; sleep 60; kill -0 "$$" 2>/dev/null || exit; done) &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID 2>/dev/null' EXIT

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
if ! command -v zed &>/dev/null; then
    echo "  Installing Zed (native)..."
    curl -f https://zed.dev/install.sh | sh
else
    echo "  Zed already installed: $(zed --version 2>/dev/null || echo 'unknown version')"
fi
mkdir -p "$HOME/.config/zed"
link_file "$DOTFILES_DIR/zed/settings.json" "$HOME/.config/zed/settings.json"

# --------------------------------------------------------------------------- #
# Rust (via rustup)
# --------------------------------------------------------------------------- #
echo ""
echo "[rust]"
if command -v rustup &>/dev/null; then
    echo "  Rust already installed: $(rustc --version)"
    echo "  Updating toolchain..."
    rustup update
else
    echo "  Installing Rust via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    echo "  Installed: $(rustc --version)"
fi

# --------------------------------------------------------------------------- #
# Claude Code (global)
# --------------------------------------------------------------------------- #
echo ""
echo "[claude]"
mkdir -p "$HOME/.claude"
link_file "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
link_file "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"

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
        echo "  [OK] $pkg (already installed)"
    else
        echo "  Installing $pkg..."
        if output=$(sudo dnf install -y "$pkg" 2>&1); then
            echo "  [OK] $pkg (installed)"
        else
            echo "  [FAIL] $pkg"
            echo "$output" | sed 's/^/    /'
        fi
    fi
done < <(grep -v '^#' "$DOTFILES_DIR/packages/dnf-packages.txt" | grep -v '^$')


# --------------------------------------------------------------------------- #
# Flatpak apps
# --------------------------------------------------------------------------- #
echo ""
echo "[packages] Installing Flatpak apps..."
grep -v '^#' "$DOTFILES_DIR/packages/flatpaks.txt" | grep -v '^$' | while read -r app; do
    if output=$(flatpak install -y flathub "$app" 2>&1); then
        echo "  [OK] $app"
    else
        echo "  [FAIL] $app"
        echo "$output" | sed 's/^/    /'
    fi
done

# --------------------------------------------------------------------------- #
# Luau LSP (JohnnyMorganz/luau-lsp) + Roblox type definitions
# --------------------------------------------------------------------------- #
echo ""
echo "[luau-lsp]"
LUAU_BIN_DIR="$HOME/.local/bin"
LUAU_LSP_URL="https://github.com/JohnnyMorganz/luau-lsp/releases/latest/download/luau-lsp-linux-x86_64.zip"
LUAU_CACHE_DIR="$HOME/.cache/luau-lsp"
mkdir -p "$LUAU_BIN_DIR" "$LUAU_CACHE_DIR"

echo "  Downloading luau-lsp..."
curl -fSL "$LUAU_LSP_URL" -o /tmp/luau-lsp.zip
rm -rf /tmp/luau-lsp && mkdir -p /tmp/luau-lsp
unzip -o /tmp/luau-lsp.zip -d /tmp/luau-lsp >/dev/null
mv /tmp/luau-lsp/luau-lsp "$LUAU_BIN_DIR/luau-lsp"
chmod +x "$LUAU_BIN_DIR/luau-lsp"
rm -rf /tmp/luau-lsp.zip /tmp/luau-lsp
echo "  Installed luau-lsp to $LUAU_BIN_DIR/luau-lsp"

echo "  Fetching Roblox type definitions..."
# globalTypes.None.d.luau is the security context for standard game scripts.
# Other flavors in that directory are for plugins and elevated contexts.
curl -fSL "https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.None.d.luau" \
    -o "$LUAU_CACHE_DIR/globalTypes.Roblox.d.luau"
curl -fSL "https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/roblox/api-docs/en-us.json" \
    -o "$LUAU_CACHE_DIR/apiDocs.json" || echo "  WARN: apiDocs.json fetch failed (non-fatal)"
echo "  Definitions cached in $LUAU_CACHE_DIR"

link_file "$DOTFILES_DIR/luau-lsp/luau-check" "$LUAU_BIN_DIR/luau-check"

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

echo ""
echo "=== Done! ==="
echo "NOTE: You may need to log out and back in for all changes to take effect."
