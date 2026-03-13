# Dotfiles Repo Instructions

This is a dotfiles repo for a Fedora GNOME workstation. Read the README.md for the
full philosophy. The short version: powerful simplicity, stay close to fundamentals,
no unnecessary abstraction.

## Rules

- Keep configs minimal. If a default works, do not override it.
- Do not add tools, plugins, or dependencies that require their own configuration
  ecosystem to function.
- Every config file should be short and readable. If it is getting long, something
  is wrong.
- Do not add secrets, SSH keys, API tokens, or machine-specific paths.
- The install.sh script uses symlinks -- configs live in this repo, not scattered
  across the home directory. Any new config must be added to both the repo and the
  install script.
- GNOME settings go in gnome/dconf-settings.ini as dconf key-value pairs. Only
  include settings that differ from Fedora defaults.
- Package lists are plain text with comments. Keep them categorized.
- Zed LSP config for luau-lsp is work-specific (Splitting Point / Roblox). It is
  not part of the permanent setup.
