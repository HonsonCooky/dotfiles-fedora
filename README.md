# dotfiles-fedora

Personal workstation config for Fedora (GNOME/Wayland). Clone it, run the
installer, and get back to work. See [Principles](PRINCIPLES.md) for the
philosophy behind this repo.

```bash
git clone git@github.com:HonsonCooky/dotfiles-fedora.git ~/Source/dotfiles
cd ~/Source/dotfiles
./install.sh
```

## What's in here

| Directory    | What it does                                                    |
| ------------ | --------------------------------------------------------------- |
| `bash/`      | bashrc.d snippets (custom PS1 with git branch, exit-code color) |
| `git/`       | Global `.gitconfig` (user, auto push remote setup)              |
| `zed/`       | Zed editor settings (Ayu theme, Luau/Roblox LSP)               |
| `gnome/`     | dconf dump, GNOME extension list, Ptyxis terminal config        |
| `packages/`  | DNF packages and Flatpak app lists                              |
| `install.sh` | Ties it all together (symlinks, dconf load, optional installs)  |

## What the installer does

1. **Symlinks** bash, git, and zed configs into the expected locations
   (backs up any existing files to `*.bak`).
2. **Loads dconf settings** -- keyboard tweaks (Caps/Esc swap), dark mode,
   hidden top panel, and more.
3. **Sets the Ptyxis terminal palette** to Ayu on the default profile.
4. **Lists GNOME extensions** to install manually (Just Perfection,
   Blur My Shell, Alphabetical App Grid).
5. **Optionally installs packages** -- DNF (gcc, go, node, podman, terraform)
   and Flatpaks (Zed, Zen Browser, Bitwarden, Discord, etc.) with a y/N prompt
   for each group.

## Keyboard shortcuts

App focus via dash favorites (Super+N also cycles windows of that app):

| Shortcut      | Action              |
| ------------- | ------------------- |
| `Super+J`     | Discord             |
| `Super+K`     | Zen Browser         |
| `Super+L`     | Zed                 |
| `Super+;`     | Ptyxis              |

Workspace switching (4 static workspaces):

| Shortcut        | Action              |
| --------------- | ------------------- |
| `Super+Alt+J`   | Workspace 1         |
| `Super+Alt+K`   | Workspace 2         |
| `Super+Alt+L`   | Workspace 3         |
| `Super+Alt+;`   | Workspace 4         |

Other remaps: lock screen moved to `Super+Escape`, Caps Lock swapped with Escape.

## Key choices

- **Podman** over Docker (Fedora default, rootless, no daemon).
- **Zed** (Flatpak) as the primary editor.
- **Ayu** theme everywhere it applies (Zed, Ptyxis).
- **4 static workspaces** with vim-style navigation.
