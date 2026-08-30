# Dotfiles Repository Guide

## Scope

This repository is the Chezmoi source state for the user's macOS and Linux configuration.

- Source repository: `$HOME/dotfiles`
- Destination directory: `$HOME`
- Chezmoi config: `$HOME/.config/chezmoi/chezmoi.toml`
- Configured source: `$HOME/dotfiles`
- Project skill: `.agents/skills/dotfiles/SKILL.md`

Read this file and the project skill before changing source state. Files such as `~/.zshrc` and `~/.config/*` are generated targets; `$HOME/dotfiles` is the normal editing surface.

## Source Rules

- Edit files under `$HOME/dotfiles`, never generated targets, for source-owned changes.
- `dot_` in a source path becomes `.` in the target path. For example, `dot_config/ghostty/config` becomes `~/.config/ghostty/config`.
- `private_` changes target permissions and is removed from the target name. It does not encrypt or hide a file.
- `executable_` makes a target executable.
- `.tmpl` files are rendered with Chezmoi data. Validate the rendered output, not only the template text.
- `.chezmoiignore` controls repository files that must not become home-directory targets. Keep `AGENTS.md`, `.agents`, `docs`, and `.githooks` ignored.
- Treat `~/.worktree-aliases/worktree.sh` as an external user dependency. Preserve its source line unless the user asks to change that integration.

## Editing Workflow

1. Start by checking `git status --short --branch` and preserve unrelated user changes.
2. Confirm the mapping with `chezmoi source-path <target>`.
3. Edit the source file directly with `patch` or from Druk at `$HOME/dotfiles`.
4. Use `chezmoi cat <target>` for rendered templates and `chezmoi diff <target>` for a focused preview.
5. Run `chezmoi diff --no-pager` and inspect every remaining target change.
6. Run `chezmoi apply --dry-run --no-tty --error-on-conflict`. Never add `--force` automatically.
7. Validate affected files, then stage only the intended source changes.
8. Commit with the repository convention, such as `chore(zsh): update shell configuration`.

`chezmoi add <target>` is only for importing an intentional direct edit made to a generated target. It is not the normal workflow for an agent.

## Commit Hook

Git uses the tracked hook in `.githooks/pre-commit`. Enable it once per clone:

```sh
git config core.hooksPath .githooks
```

The hook refuses unstaged and untracked files, including ignored files. It runs:

```sh
chezmoi apply --source="$repo_root" --no-tty --error-on-conflict
```

The hook must fail rather than prompt or overwrite a modified target. Do not bypass it with `--no-verify` unless the user explicitly requests that exception.

## Validation

- Shell templates: `chezmoi cat ~/.zshrc | zsh -n`
- Shell hook: `sh -n .githooks/pre-commit`
- JSON and JSONC: `jq empty <file>` when the file is valid JSON
- All source changes: `git diff --check`
- Chezmoi state: `chezmoi diff --no-pager` and `chezmoi apply --dry-run --no-tty --error-on-conflict`

Do not push, deploy, or change unrelated files without an explicit request.

## Secrets

Never commit credentials, tokens, private keys, or local environment files. Use Chezmoi encryption or a password-manager integration for managed secrets. The `private_` prefix only controls filesystem permissions.
