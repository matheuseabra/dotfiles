---
description: Scan staged or unstaged changes and create a commit
agent: build
---

Work in the current project root and handle git safely.

1. Confirm the current directory is a git repository. If it is not, stop and explain.
2. Inspect the full repository state before acting:
   - `git status`
   - `git diff --staged`
   - `git diff`
   - `git log -10 --pretty=format:%s`
3. Consider both staged and unstaged changes. If there are no tracked or untracked changes to commit, stop and explain that there is nothing to commit.
4. Stage the relevant changed files that belong in this commit. Do not stage likely secret files such as `.env`, credential files, tokens, or private keys.
5. Write a concise commit message that matches the repository's recent commit style and reflects why the change exists.
6. Create exactly one normal git commit.
7. Run `git status` after the commit and report clearly whether the command committed, refused, or failed, including the commit hash and remaining working tree state.

Safety rules:
- Never push.
- Never force anything.
- Never change git config.
- Never create an empty commit.
- If hooks fail, explain the failure and stop.
