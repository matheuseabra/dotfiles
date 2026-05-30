---
description: Commit local changes, then push main to origin/main
agent: build
---

Work in the current project root and handle git safely.

Phase 1 — commit
1. Confirm the current directory is a git repository. If it is not, stop and explain.
2. Inspect the full repository state first:
   - `git status`
   - `git diff --staged`
   - `git diff`
   - `git log -10 --pretty=format:%s`
3. Consider both staged and unstaged changes. If there are no tracked or untracked changes to commit, stop and explain that there is nothing to commit or push.
4. Stage the relevant changed files that belong in this commit. Do not stage likely secret files such as `.env`, credential files, tokens, or private keys.
5. Write a concise commit message that matches the repository's recent commit style and reflects why the change exists.
6. Create exactly one normal git commit.
7. Run `git status` after the commit. If the commit failed, stop and explain.

Phase 2 — push
8. Confirm the current branch is `main`. If it is not `main`, stop and explain that pushing to `main` requires being on `main` first.
9. Confirm `origin` exists.
10. Push `main` to `origin/main` with a normal push only.
11. Report clearly whether the command committed and pushed, refused, or failed, including the new commit hash and the push destination when successful.

Safety rules:
- Never use `--force`, `--force-with-lease`, or any destructive flag.
- Never change git config.
- Never create an empty commit.
- If hooks fail or the push is rejected, explain the failure and stop.
