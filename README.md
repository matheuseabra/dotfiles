# dotfiles

User-level configuration for macOS and Linux, managed with [chezmoi](https://www.chezmoi.io/). Machine packages, users, SSH, services, and binaries belong in [`vps-environment`](https://github.com/matheuseabra/vps-environment).

chezmoi renders this source state into `$HOME`. It selects macOS-only files automatically and renders platform-specific Zsh, Git, and OpenCode configuration.

## Install on macOS

```sh
brew install chezmoi
git clone https://github.com/matheuseabra/dotfiles.git ~/.local/share/chezmoi
chezmoi apply --force
```

`--force` replaces the legacy GNU Stow symlinks during this one-time migration. Commit or back up local edits first.

For a new machine, the equivalent bootstrap command is:

```sh
chezmoi init --apply https://github.com/matheuseabra/dotfiles.git
```

## Use

```sh
chezmoi diff             # preview rendered changes
chezmoi apply            # apply source state
chezmoi edit ~/.zshrc    # edit a source file
chezmoi update           # pull the source repository and apply it
```

Run `chezmoi add <path>` to import an intentional local change. Do not edit a generated file without adding it back to the source state.

## Platform ownership

All platforms receive:

- Zsh, Git, Starship, btop, Druk, Yazi, and OpenCode configuration.
- Shared terminal-theme assets where they are used.

macOS also receives Ghostty, Karabiner, skhd, Herdr, Cava, Fastfetch, GitHub CLI, the theme switcher, and wallpapers. The OpenCode configuration enables the local Xcode and grep.app MCP servers only on macOS.

The Linux VPS receives the portable configuration through Ansible after Ansible installs its packages and binaries. It does not receive macOS desktop configuration.

## Themes

On macOS, switch each supported tool to one palette:

```sh
change_theme <theme>
change_theme <theme> --dry-run
```

Theme assets are installed into their application configuration directories. Wallpapers are installed in `~/.local/share/wallpapers`. `change_theme` persists each changed configuration file into the chezmoi source state; commit those source changes before running `chezmoi update`.

## Secrets

Do not commit credentials, tokens, private keys, or local environment files. OpenCode reads `FIRECRAWL_API_KEY` from the environment. Add encrypted chezmoi files or a password-manager integration only when a configuration file must contain a secret.
