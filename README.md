# dotfiles

My macOS-oriented shell and application configuration, managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a Stow package whose contents mirror the destination under `$HOME`—for example, `zsh/.zshrc` becomes `~/.zshrc` and `nvim/.config/nvim` becomes `~/.config/nvim`.

## Install

Prerequisite: [GNU Stow](https://www.gnu.org/software/stow/) (`brew install stow` on macOS).

```sh
git clone https://github.com/matheuseabra/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Stow refuses conflicts and never overwrites an existing file. Review, move, or back up any conflicting local configuration before rerunning the command. To install one package only, run `stow --target "$HOME" <package>` (for example, `stow --target "$HOME" zsh`).

The tracked packages are: `druk`, `ghostty`, `herdr`, `karabiner`, `nvim`, `skhd`, `starship`, `television`, `tmux`, and `zsh`. The SpaceX Terrafab palette reference is in `docs/theme/`.

## Optional Herdr plugins

Herdr's plugin registry is intentionally not versioned: it contains machine-specific paths and installed runtime state. Install the optional plugins after Stowing the `herdr` package:

```sh
herdr plugin install smarzban/herdr-file-viewer --ref 96fcc0a2bdd2727ec88c38f8c8806f97b7ca0ea0
herdr plugin install persiyanov/herdr-reviewr --ref 6c304925142b983381e166333d3e9ce403121ef6
```

## Security

No credentials belong in this repository. Runtime credentials are read from environment variables (for example, `FIRECRAWL_API_KEY`) rather than committed. `.gitignore` excludes common secret files, private-key formats, generated application state, backup files, and dependencies.

Before making the GitHub repository public, enable GitHub Secret Scanning and Push Protection in the repository's **Settings → Code security and analysis**. If a credential was ever committed elsewhere, revoke and rotate it before publishing; removing it from the current checkout does not remove it from Git history.
