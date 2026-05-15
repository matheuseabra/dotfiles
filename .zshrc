# Prefer Homebrew binaries
export PATH="/opt/homebrew/bin:$PATH"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(git)
source $ZSH/oh-my-zsh.sh

# Aliases
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

# PATH additions (deduplicated)
export PATH="$HOME/.opencode/bin:$HOME/.local/bin:$HOME/.npm-global/bin:$HOME/Library/Python/3.9/bin:$HOME/.lmstudio/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Kror CLI
kror() {
  node "$HOME/Desktop/www/kror-cli/dist/index.js" "$@"
}

# tmux dev layout
dev() {
  local current_dir="${PWD}"
  local editor_pane ai_pane terminal_pane

  tmux kill-session -t dev 2>/dev/null
  tmux new-session -d -s dev -c "$current_dir"
  tmux rename-window -t dev:0 dev

  editor_pane=$(tmux display-message -t dev:0.0 -p '#{pane_id}')
  tmux split-window -v -p 25 -t "$editor_pane" -c "$current_dir"

  terminal_pane=$(tmux display-message -t dev:0.1 -p '#{pane_id}')

  tmux select-pane -t "$editor_pane"
  tmux split-window -h -p 30 -t "$editor_pane" -c "$current_dir"

  ai_pane=$(tmux display-message -p '#{pane_id}')

  tmux send-keys -t "$editor_pane" "nvim" C-m
  tmux send-keys -t "$ai_pane" "opencode" C-m

  tmux select-pane -t "$editor_pane"
  tmux attach-session -t dev
}

# tmux pc layout
pc() {
  local current_dir="${PWD}"
  local stats_pane btop_pane

  tmux kill-session -t pc 2>/dev/null
  tmux new-session -d -s pc -c "$current_dir"
  tmux rename-window -t pc:0 pc

  stats_pane=$(tmux display-message -t pc:0.0 -p '#{pane_id}')
  tmux split-window -h -p 50 -t "$stats_pane" -c "$current_dir"

  btop_pane=$(tmux display-message -t pc:0.1 -p '#{pane_id}')

  tmux send-keys -t "$stats_pane" "fastfetch" C-m
  tmux send-keys -t "$btop_pane" "btop" C-m

  tmux select-pane -t "$stats_pane"
  tmux attach-session -t pc
}

# opencode shortcuts
alias oc='opencode'
alias oc-minmax='opencode --model openrouter/minmax-2.5:free'
alias oc-gpt54='opencode --model openai/gpt-54'
alias oc-gpt54mini='opencode --model openai/gpt-5.4-mini'

# fzf init (no process substitution)
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# starship / atuin / zoxide / cargo / tv
eval "$(starship init zsh)"
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
eval "$(tv init zsh)"
