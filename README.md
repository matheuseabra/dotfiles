# dotfiles

User-level configuration for macOS and Linux, managed with [chezmoi](https://www.chezmoi.io/). Machine packages, users, SSH, services, and binaries belong in [`vps-environment`](https://github.com/matheuseabra/vps-environment).

The source repository lives at `~/dotfiles`. Chezmoi renders this source state into `$HOME`. It selects macOS-only files automatically and renders platform-specific Zsh, Git, and OpenCode configuration.

## Install on macOS

```sh
brew install chezmoi
chezmoi init --source="$HOME/dotfiles" --apply https://github.com/matheuseabra/dotfiles.git
```

For a one-time migration from GNU Stow, review `chezmoi diff`, then use `chezmoi apply --force` only after committing or backing up local edits. This replaces the legacy symlinks.

If `~/dotfiles` is already cloned, initialize Chezmoi from that directory, review the rendered changes, and apply it:

```sh
chezmoi init --source="$HOME/dotfiles"
chezmoi diff
chezmoi apply
```

The `.chezmoi.toml.tmpl` source file generates the local Chezmoi configuration with `~/dotfiles` as its source directory.

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
