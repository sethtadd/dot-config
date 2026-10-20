# Shared application configuration

This is the live `sethtadd/dot-config` checkout shared by Cyan
(`/home/sethtadd/.config`) and beef (`/home/seth/.config`).

- Before editing, inspect Git status and preserve existing local changes.
- After changing shared configuration, check synchronization status and offer to
  commit, push, and update the other machine. Ask before pushing or updating
  another machine unless the current task explicitly authorizes those actions.
  A request to edit configuration alone does not authorize synchronization.
- Inspect the destination's repository identity, branch, and local changes before
  syncing. Prefer fast-forward updates; never automatically stash, discard,
  force-push, or commit unrelated work to make synchronization succeed.
- Verify relevant configuration and dependencies on each machine. Distinguish
  files synchronized from applications reloaded; report blockers or unreachable
  machines instead of implying synchronization completed.

History, machine-specific context, and recovery details live in the personal
knowledge base's `notes/dotfiles-and-shared-zsh.md`. Consult the global
knowledge-base guide or skill to locate that collection when needed.
