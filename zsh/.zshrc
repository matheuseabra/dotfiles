export PATH="/opt/homebrew/bin:$PATH"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(git)
source $ZSH/oh-my-zsh.sh

# Aliases
alias d='druk'

# Keep normal Pi sessions off the startup update/network checks. Package
# management commands still run normally so `pi update` and `pi install`
# remain available.
pi() {
  case "${1:-}" in
    update|install|remove|uninstall)
      command pi "$@"
      ;;
    *)
      local cache_dir="${PI_NODE_COMPILE_CACHE:-$HOME/.cache/pi/node-compile}"
      NODE_COMPILE_CACHE="$cache_dir" command pi --offline "$@"
      ;;
  esac
}
alias reload-zsh="source ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls='logo-ls'
alias spotify='spotify_player'
alias s2s='speech-to-speech'
alias ff='fastfetch'
alias mf='minfetch'
alias cv='cava'
alias cm='cmatrix -C blue'
alias oc='opencode2'
alias change_theme="$HOME/dotfiles/scripts/change_theme"
"!cp"() { print -r -- "commit and push"; }
"!cpr"() { print -r -- "commit, push and release"; }

# OpenCode v2
case ":$PATH:" in
  *":$HOME/.opencode/bin:"*) ;;
  *) export PATH="$HOME/.opencode/bin:$PATH" ;;
esac

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# npm global prefix
case ":$PATH:" in
  *":$HOME/.npm-global/bin:"*) ;;
  *) export PATH="$HOME/.npm-global/bin:$PATH" ;;
esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# Herdr dev layout: Pi on the left and Druk on the right.
dev() {
  local herdr_bin right_split druk_pane

  if [[ -z "${HERDR_PANE_ID:-}" || -z "${HERDR_TAB_ID:-}" ]]; then
    print -u2 'dev must be run inside a Herdr pane.'
    return 1
  fi

  herdr_bin="${HERDR_BIN_PATH:-herdr}"

  "$herdr_bin" tab rename "$HERDR_TAB_ID" dev || return

  right_split="$("$herdr_bin" pane split "$HERDR_PANE_ID" --direction right --ratio 0.15 --no-focus)" || return
  druk_pane="$(jq -er '.result.pane.pane_id' <<< "$right_split")" || return

  "$herdr_bin" pane run "$HERDR_PANE_ID" 'exec pi'
  "$herdr_bin" pane run "$druk_pane" 'exec druk'
}

# Herdr index layout: four equal panes with system and terminal monitors.
index() {
  local herdr_bin right_split top_right bottom_left_split bottom_left bottom_right_split bottom_right

  if [[ -z "${HERDR_PANE_ID:-}" || -z "${HERDR_TAB_ID:-}" ]]; then
    print -u2 'index must be run inside a Herdr pane.'
    return 1
  fi

  herdr_bin="${HERDR_BIN_PATH:-herdr}"

  "$herdr_bin" tab rename "$HERDR_TAB_ID" index || return

  right_split="$("$herdr_bin" pane split "$HERDR_PANE_ID" --direction right --ratio 0.5 --no-focus)" || return
  top_right="$(jq -er '.result.pane.pane_id' <<< "$right_split")" || return

  bottom_left_split="$("$herdr_bin" pane split "$HERDR_PANE_ID" --direction down --ratio 0.5 --no-focus)" || return
  bottom_left="$(jq -er '.result.pane.pane_id' <<< "$bottom_left_split")" || return

  bottom_right_split="$("$herdr_bin" pane split "$top_right" --direction down --ratio 0.5 --no-focus)" || return
  bottom_right="$(jq -er '.result.pane.pane_id' <<< "$bottom_right_split")" || return

  "$herdr_bin" pane run "$HERDR_PANE_ID" 'exec fastfetch'
  "$herdr_bin" pane run "$top_right" 'exec cmatrix -C blue'
  "$herdr_bin" pane run "$bottom_right" 'exec cava'
}

# Herdr system layout: macmon on the left and btop on the right.
system() {
  local herdr_bin right_split right_pane

  if [[ -z "${HERDR_PANE_ID:-}" || -z "${HERDR_TAB_ID:-}" ]]; then
    print -u2 'system must be run inside a Herdr pane.'
    return 1
  fi

  herdr_bin="${HERDR_BIN_PATH:-herdr}"

  "$herdr_bin" tab rename "$HERDR_TAB_ID" system || return

  right_split="$("$herdr_bin" pane split "$HERDR_PANE_ID" --direction right --ratio 0.35 --no-focus)" || return
  right_pane="$(jq -er '.result.pane.pane_id' <<< "$right_split")" || return

  "$herdr_bin" pane run "$HERDR_PANE_ID" 'exec macmon'
  "$herdr_bin" pane run "$right_pane" 'exec btop'
}

# Herdr AI layout: OpenCode on top with a small lower pane.
ai() {
  local herdr_bin

  if [[ -z "${HERDR_PANE_ID:-}" || -z "${HERDR_TAB_ID:-}" ]]; then
    print -u2 'ai must be run inside a Herdr pane.'
    return 1
  fi

  herdr_bin="${HERDR_BIN_PATH:-herdr}"

  "$herdr_bin" tab rename "$HERDR_TAB_ID" ai || return

  "$herdr_bin" pane split "$HERDR_PANE_ID" --direction down --ratio 0.85 --no-focus || return
  "$herdr_bin" pane run "$HERDR_PANE_ID" 'exec codex'
}

# Herdr editor layout: Druk on top with a small lower pane.
editor() {
  local herdr_bin

  if [[ -z "${HERDR_PANE_ID:-}" || -z "${HERDR_TAB_ID:-}" ]]; then
    print -u2 'editor must be run inside a Herdr pane.'
    return 1
  fi

  herdr_bin="${HERDR_BIN_PATH:-herdr}"

  "$herdr_bin" tab rename "$HERDR_TAB_ID" editor || return

  "$herdr_bin" pane split "$HERDR_PANE_ID" --direction down --ratio 0.85 --no-focus || return
  "$herdr_bin" pane run "$HERDR_PANE_ID" 'exec druk .'
}

# Herdr home layout: 6-pane dashboard with monitors, clock, and shells.
home() {
  local herdr_bin pane_count root bottom rightcol bottomleft rest bottomshell

  if [[ -z "${HERDR_PANE_ID:-}" || -z "${HERDR_TAB_ID:-}" ]]; then
    print -u2 'home must be run inside a Herdr pane.'
    return 1
  fi

  herdr_bin="${HERDR_BIN_PATH:-herdr}"

  # Refuse to rebuild a tab that already has more than one pane, unless --force.
  if [[ "${1:-}" != "--force" ]]; then
    pane_count=$("$herdr_bin" tab list --workspace "$HERDR_WORKSPACE_ID" 2>/dev/null \
      | jq -r --arg tab "$HERDR_TAB_ID" '.result.tabs[] | select(.tab_id == $tab) | .pane_count // 1')
    if [[ "${pane_count:-1}" -gt 1 ]]; then
      print -u2 "home: current tab has $pane_count panes; run 'home --force' to rebuild anyway."
      return 1
    fi
  fi

  root=$("$herdr_bin" pane layout --pane "$HERDR_PANE_ID" 2>/dev/null \
    | jq -er '.result.layout.panes[0].pane_id') || {
    print -u2 'home: could not resolve current pane as layout root.'
    return 1
  }

  # 1. strip across the top; bottom area is the new pane
  bottom=$("$herdr_bin" pane split "$root" --direction down --ratio 0.10 --no-focus --cwd "$HOME" \
    | jq -er '.result.pane.pane_id') || return

  # 2. split the bottom area: big shell (left) | right column
  rightcol=$("$herdr_bin" pane split "$bottom" --direction right --ratio 0.755 --no-focus --cwd "$HOME" \
    | jq -er '.result.pane.pane_id') || return

  # 3. left column: big shell on top, bottom-left shell below
  bottomleft=$("$herdr_bin" pane split "$bottom" --direction down --ratio 0.881 --no-focus --cwd "$HOME" \
    | jq -er '.result.pane.pane_id') || return

  # 4. right column: clock on top, rest below
  rest=$("$herdr_bin" pane split "$rightcol" --direction down --ratio 0.262 --no-focus --cwd "$HOME" \
    | jq -er '.result.pane.pane_id') || return

  # 5. rest: cava on top, shell below
  bottomshell=$("$herdr_bin" pane split "$rest" --direction down --ratio 0.452 --no-focus --cwd "$HOME" \
    | jq -er '.result.pane.pane_id') || return

  "$herdr_bin" pane run "$root" 'cmatrix -C blue'
  "$herdr_bin" pane run "$bottom" 'exec opencode2'
  "$herdr_bin" pane run "$rightcol" 'tty-clock'
  "$herdr_bin" pane run "$rest" 'cava'

  print "home: layout built (cmatrix, oc, tty-clock, cv) in $HERDR_TAB_ID"
}

# fzf init (no process substitution)
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

vf() {
  local file query

  query="$*"

  file="$(fd --type f --hidden --follow -E .git . | fzf --height=60% --layout=reverse --scheme=path --query "$query" --preview 'bat --style=numbers --color=always --line-range=:200 -- {}' --preview-window='right,60%,border-left')" || return
  druk -- "$file"
}

pj() {
  local dir repo_root query
  local -a roots existing_roots zoxide_dirs repo_dirs candidates
  typeset -A seen

  roots=(
    "$HOME/Desktop"
    "$HOME/Documents"
    "$HOME/go"
    "$HOME/Superapp-Projects"
    "$HOME/dotfiles"
  )

  for root in "${roots[@]}"; do
    [[ -d "$root" ]] && existing_roots+=("$root")
  done

  (( ${#existing_roots[@]} )) || return 1

  query="$*"

  zoxide_dirs=("${(@f)$(zoxide query -l --all 2>/dev/null)}")
  repo_dirs=("${(@f)$(fd --hidden --no-ignore --type d --glob '.git' "${existing_roots[@]}" -E node_modules -E .next -E dist -E build -x dirname)}")

  for dir in "${zoxide_dirs[@]}"; do
    repo_root="$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null)" || continue
    [[ -n "${seen[$repo_root]}" ]] && continue
    seen[$repo_root]=1
    candidates+=("$repo_root")
  done

  for dir in "${repo_dirs[@]}"; do
    [[ -n "${seen[$dir]}" ]] && continue
    seen[$dir]=1
    candidates+=("$dir")
  done

  (( ${#candidates[@]} )) || return 1

  dir="$(printf '%s\n' "${candidates[@]}" | fzf --height=60% --layout=reverse --scheme=path --query "$query" --preview 'if git -C {} rev-parse --show-toplevel >/dev/null 2>&1; then git -C {} status --short --branch; printf "\n"; fi; eza --all --group-directories-first --color=always -- {}' --preview-window='right,60%,border-left')" || return
  builtin cd -- "$dir"
}

# starship / zoxide / cargo
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section

# druk
export PATH="$HOME/.druk/bin:$PATH"

# Go
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"
