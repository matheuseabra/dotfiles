#!/usr/bin/env sh
# Symlink all supported packages into $HOME without overwriting existing files.
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
packages='btop cava druk fastfetch gh git ghostty herdr karabiner opencode skhd starship yazi zsh'

if ! command -v stow >/dev/null 2>&1; then
	printf '%s\n' 'GNU Stow is required. Install it first (for example: brew install stow).' >&2
	exit 1
fi

cd "$repo_dir"
# Stow stops on conflicts; it does not overwrite an existing local file.
# shellcheck disable=SC2086
stow --target "$HOME" --restow $packages
