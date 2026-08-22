# dotfiles

My macOS-oriented shell and application configuration, managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a Stow package whose contents mirror the destination under `$HOME`—for example, `zsh/.zshrc` becomes `~/.zshrc` and `ghostty/.config/ghostty` becomes `~/.config/ghostty`.

## Install

Prerequisite: [GNU Stow](https://www.gnu.org/software/stow/) (`brew install stow` on macOS).

```sh
git clone https://github.com/matheuseabra/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Stow refuses conflicts and never overwrites an existing file. Review, move, or back up any conflicting local configuration before rerunning the command. To install one package only, run `stow --target "$HOME" <package>` (for example, `stow --target "$HOME" zsh`).

The tracked packages are: `btop`, `cava`, `druk`, `fastfetch`, `gh`, `git`, `ghostty`, `herdr`, `karabiner`, `opencode`, `skhd`, `starship`, `yazi`, and `zsh`. The SpaceX Terrafab palette reference is in `docs/theme/`.