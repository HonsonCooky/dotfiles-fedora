# dotfiles-fedora

My Fedora workstation config. Clone, run the script, get back to work.

## Philosophy

Computing is not hard. People have abstracted it until it feels hard.

I value **powerful simplicity** -- small surface area, large depth. Every tool I use
should keep me close to the fundamentals of what is actually happening. If I can't
trace a concept back to something concrete, the abstraction has failed me.

This means:

- **Go over TypeScript/C#.** You type more, but you understand more. The standard
  library is the ecosystem. There are no layers hiding what the machine is doing.
- **C99/C23 for understanding.** Pointers and memory are not hard -- they are how
  computers work. Understanding them makes everything above click.
- **Zed over Neovim.** Vim motions matter. Plugin management does not. Zed gives me
  a real editor without asking me to become a toolchain maintainer.
- **Zen over Firefox/Chrome.** Browsers are noisy. Zen strips it back. If I could do
  everything from a terminal, I would.
- **Fedora over Arch.** I do not get paid to configure my OS. Fedora's GNOME works,
  stays out of the way, and updates itself. The time I would spend on Hyprland
  configs is time I am not spending writing code.
- **Forge (tiling) with vim keybindings.** Keyboard-driven window management, but
  through a GNOME extension -- not a whole compositor I have to maintain.

The test for any tool or config: **does this bring me closer to the work, or further
from it?** If it adds a layer I have to learn and maintain without making me
meaningfully faster, it does not belong here.

## What is here

```
bash/        Shell config (stock Fedora defaults, kept clean)
git/         Git identity and global ignores
gnome/       dconf settings (keybindings, Forge, Ptyxis, dark mode, etc.)
claude/      Claude Code global config
zed/         Zed editor settings (Ayu theme, line length, LSP config)
packages/    DNF and Flatpak package lists
install.sh   Symlinks configs, loads GNOME settings, installs packages
```

## Setup

```bash
git clone git@github.com:HonsonCooky/dotfiles-fedora.git ~/Source/dotfiles
cd ~/Source/dotfiles
./install.sh
```

The script will:
1. Symlink config files into place (backs up existing files as .bak)
2. Load GNOME/dconf settings
3. Optionally install DNF packages (including Docker CE repo setup)
4. Optionally install Flatpak apps
5. Print which GNOME extensions to install via Extension Manager

## Principles for changes

- If a default works, do not override it.
- If a config entry is not doing something specific, remove it.
- Do not add tools that require their own config ecosystem.
- Every file here should be short enough to read in one sitting.
