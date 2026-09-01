# dotfiles

Personal macOS and Linux configuration files managed with [Chezmoi](https://www.chezmoi.io/).

## Get started

Install Chezmoi with a package manager, then run:

```sh
git clone https://github.com/matheuseabra/dotfiles.git ~/dotfiles
chezmoi init --source="$HOME/dotfiles"
chezmoi diff
chezmoi apply
```

## Everyday use

Edit files in `~/dotfiles`, not the generated files under `$HOME`:

```sh
chezmoi diff
chezmoi apply
chezmoi source-path ~/.zshrc
chezmoi update
```

Chezmoi prefixes such as `dot_`, `private_`, and `executable_` control target names and permissions. Templates (`.tmpl`) are rendered before they are applied.

## Commits

Enable the safety hook once:

```sh
git config core.hooksPath .githooks
```

It checks the working tree and applies Chezmoi before each commit. A target conflict stops the commit instead of overwriting local changes.

## Themes

On macOS, preview or switch supported themes with:

```sh
change_theme <theme> --dry-run
change_theme <theme>
```

## Secrets

Keep credentials, private keys, and local environment files out of Git. Use Chezmoi encryption or a password manager when a managed file needs a secret.
