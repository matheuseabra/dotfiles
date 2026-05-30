---
description: Push the local main branch to origin/main
agent: build
---

Work in the current project root and handle git safely.

1. Confirm the current directory is a git repository. If it is not, stop and explain.
2. Inspect branch and remote state before acting:
   - `git status -sb`
   - `git branch --show-current`
   - `git remote -v`
3. This command is for pushing to `main`. If the current branch is not `main`, stop and explain that switching or merging to `main` is required first.
4. If `origin` is missing, stop and explain.
5. Push `main` to `origin/main` with a normal push only.
6. Report clearly whether the command pushed, refused, or failed, and include the destination `origin/main` when a push happens.

Safety rules:
- Never use `--force`, `--force-with-lease`, or any destructive flag.
- Never change git config.
- Never create commits.
- If the push is rejected, explain why and stop.
