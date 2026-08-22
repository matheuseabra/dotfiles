# dotfiles

macOS terminal environment managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a Stow package whose contents mirror `$HOME` — `zsh/.zshrc` becomes `~/.zshrc`.

## Install

```sh
brew install stow
git clone https://github.com/matheuseabra/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Stows every package without overwriting existing files. Install a single package with `stow --target "$HOME" <package>`.

## Packages

`btop` `cava` `druk` `fastfetch` `gh` `git` `ghostty` `herdr` `karabiner` `opencode` `skhd` `starship` `yazi` `zsh`

## Themes

Four shared palettes — `spacex-terrafab`, `nord`, `stills-in-motion`, `venice-from-above` — with color references in `docs/theme/` and theme files inside each tool's package.

Switch every tool at once:

```sh
scripts/change_themes.sh <theme>   # add --dry-run to preview
```
