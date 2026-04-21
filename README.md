# dotfiles-fedora

Personal workstation config for Fedora (GNOME/Wayland). See [PHILOSOPHY.md](PHILOSOPHY.md) for the reasoning behind
these choices.

## Setup order

The first four steps are manual. They involve browser-extension clicks and password-manager login that cannot be
scripted cleanly. Everything from step five onward is automated by `./install.sh`.

1. **System update**

   ```bash
   sudo dnf upgrade -y
   ```

2. **Install Zen Browser, remove Firefox**

   ```bash
   flatpak install -y flathub app.zen_browser.zen
   sudo dnf remove -y firefox
   ```

3. **Install browser extensions in Zen and log in to Bitwarden**

   Open each link in Zen and click "Add to Firefox":
   - [uBlock Origin](https://addons.mozilla.org/firefox/addon/ublock-origin/)
   - [Bitwarden Password Manager](https://addons.mozilla.org/firefox/addon/bitwarden-password-manager/)

   Then log in to Bitwarden so later steps (GitHub auth, etc.) can paste credentials from it.

4. **Clone this repo**

   Fedora Workstation ships with `git`, so nothing extra is needed to get the dotfiles onto the machine:

   ```bash
   git clone https://github.com/HonsonCooky/dotfiles-fedora.git \
       ~/Projects/honsoncooky/dotfiles-fedora
   cd ~/Projects/honsoncooky/dotfiles-fedora
   ```

5. **Run the installer**

   ```bash
   ./install.sh
   ```

6. **Post-install (one-shot, per machine)**

   - `gh auth login` to authenticate the GitHub CLI.
   - Install GNOME extensions listed by the installer via Extension Manager.
   - Generate an SSH key if you want to sign commits (see `git/.gitconfig` for the expected signing-key path).

## What is in here

| Directory    | What it does                                                      |
| ------------ | ----------------------------------------------------------------- |
| `bash/`      | `.bashrc`, `.inputrc`, and `bashrc.d` snippets (PS1, PATH).       |
| `claude/`    | Global Claude Code config (`CLAUDE.md`, `settings.json`).         |
| `git/`       | Global `.gitconfig` (user, SSH signing, gh credential helper).   |
| `gnome/`     | dconf dump, Ptyxis palette, extension list.                       |
| `luau-lsp/`  | `luau-check` wrapper for strict-mode Roblox Luau analysis.        |
| `packages/`  | DNF and Flatpak package lists.                                    |
| `voyager/`   | ZSA Voyager udev rules, desktop entry, and layout doc.            |
| `zed/`       | Zed editor settings (Ayu theme, Luau/Roblox LSP config).          |
| `install.sh` | Symlinks configs, loads dconf, installs packages and tools.       |

## What the installer does

1. **Primes sudo** and keeps the credential cache warm for the duration of the run.
2. **Symlinks** bash, git, zed, and claude configs into their expected locations (existing files are backed up to
   `*.bak`).
3. **Installs or updates Rust** via rustup.
4. **Loads dconf settings** (keyboard remaps, hidden top panel, workspace shortcuts, app launchers).
5. **Sets the Ptyxis palette** to Ayu on the default profile.
6. **Installs DNF packages** listed in `packages/dnf-packages.txt`.
7. **Installs Flatpak apps** listed in `packages/flatpaks.txt`.
8. **Installs luau-lsp** plus Roblox type definitions and the `luau-check` wrapper.
9. **Installs Keymapp** (ZSA Voyager) with udev rules and a desktop entry.
10. **Prints the GNOME extension list** for manual install via Extension Manager.

## Keyboard shortcuts

App focus via dash favorites (`Super+N` also cycles windows of that app):

| Shortcut  | Action      |
| --------- | ----------- |
| `Super+J` | Zed         |
| `Super+K` | Zen Browser |
| `Super+L` | Discord     |
| `Super+;` | Ptyxis      |

Workspace switching (4 static workspaces):

| Shortcut      | Action      |
| ------------- | ----------- |
| `Super+Alt+J` | Workspace 1 |
| `Super+Alt+K` | Workspace 2 |
| `Super+Alt+L` | Workspace 3 |
| `Super+Alt+;` | Workspace 4 |

Other remaps: lock screen moved to `Super+Escape`; Caps Lock swapped with Escape.

## Key choices

- **Podman** over Docker (Fedora default, rootless, no daemon).
- **Zed** as the primary editor.
- **Zen Browser** (Flatpak) in place of Firefox.
- **Ayu** theme everywhere it applies (Zed, Ptyxis).
- **4 static workspaces** with vim-style navigation.
