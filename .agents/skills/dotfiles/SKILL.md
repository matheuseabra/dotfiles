---
name: dotfiles
description: Maintain this repository's Chezmoi source state safely, including rendered targets, permissions, templates, and the guarded commit workflow.
---

# Dotfiles Skill

Use this skill when changing configuration managed by the Chezmoi source repository at `$HOME/dotfiles`.

## Interface

- Source state lives in `$HOME/dotfiles`.
- Generated targets live under `$HOME`.
- Chezmoi reads `$HOME/.config/chezmoi/chezmoi.toml`.
- `chezmoi source-path <target>` maps a home target back to its source file.
- `chezmoi cat <target>` renders a source file without changing the target.

## Non-Negotiables

- Inspect `git status --short --branch` before editing and preserve unrelated changes.
- Edit source files directly. Do not edit generated targets unless importing a deliberate target-side change with `chezmoi add`.
- Do not use `chezmoi apply --force` unless the user explicitly approves replacing a target.
- Do not use `git commit --no-verify` to bypass the repository hook.
- Keep secrets out of Git. `private_` sets permissions; it is not encryption.
- Keep repository instructions and skills ignored by Chezmoi through `.chezmoiignore`.

## Source Naming

- `dot_` maps to a leading dot in the target path.
- `private_` is removed from the target name and removes group/world permissions.
- `executable_` is removed from the target name and adds executable permissions.
- `.tmpl` marks a template and must be validated after rendering.
- `empty_` preserves an empty target file.

For example, `dot_config/opencode/private_cli.json` targets `~/.config/opencode/cli.json` with private file permissions. `dot_config/private_karabiner` targets `~/.config/karabiner` with private directory permissions.

## Agent Loop

1. Map the requested target with `chezmoi source-path <target>`.
2. Edit the mapped source file with `patch`.
3. Preview the focused target with `chezmoi diff <target>`.
4. Inspect rendered template output with `chezmoi cat <target>`.
5. Run focused syntax or format checks.
6. Run `chezmoi diff --no-pager` and resolve every unintended change.
7. Run `chezmoi apply --dry-run --no-tty --error-on-conflict`.
8. Stage only intended files and commit. The pre-commit hook applies the complete source state before the commit is accepted.

The hook requires a clean working tree outside the index. Do not partially stage a change while leaving other source edits or untracked source files in the working tree.

## Target Drift

If Chezmoi reports that a target changed since it last wrote it, do not force the apply. Compare the target and source, preserve the intended value in the source, then rerun the preview and dry-run. A conflict is a decision point, not a formatting error.

## Useful Checks

```sh
chezmoi source-path ~/.zshrc
chezmoi diff ~/.zshrc
chezmoi cat ~/.zshrc | zsh -n
chezmoi apply --dry-run --no-tty --error-on-conflict
git diff --check
```

Use `git -C "$HOME/dotfiles"` when the current directory is not the repository. Do not push unless the user explicitly asks.
