---
name: herdr-worktree
description: Manage Patrick's Herdr-native Git worktree workflow using dotfiles/bin/herdr-worktree and dotfiles/herdr/projects/*.toml. Use when creating/removing Herdr worktrees, checking out GitHub PRs into worktrees, applying project symlinks, opening Herdr tabs/panes, starting Pi agents, or replacing workmux add/rm workflows.
---

# Herdr Worktree

Use this skill for Patrick's Herdr-native replacement for common `workmux add` / `workmux rm` flows.

## Key files

- Script: `bin/herdr-worktree`
- Project configs: `herdr/projects/*.toml`
- Ketryx config: `herdr/projects/ketryx.toml`

## Safety

- Prefer `--dry-run` first unless the user explicitly asks to execute.
- Do not create/remove worktrees, panes, tabs, or agents without user confirmation.
- For removal, avoid `--force` unless the user explicitly requests it or approves after seeing dirty-worktree status.

## Create or open a worktree

From inside a configured repo or worktree, run:

```bash
herdr-worktree add <branch> [--base <ref>] [--project <name>] [-p <prompt>] [--dry-run]
herdr-worktree add --pr <number> [--name <handle>] [--project <name>] [-p <prompt>] [--dry-run]
```

Examples:

```bash
herdr-worktree add patrick/my-feature --base main --dry-run
herdr-worktree add patrick/my-feature -p "Implement the requested UI change" --dry-run
herdr-worktree add --pr 9039 --dry-run
herdr-worktree add --project ketryx --pr 9039 --dry-run
herdr-worktree add --pr 9039 -p "Review this PR" --dry-run
```

Behavior:

- Infers the matching config from `herdr/projects/*.toml` only when the current directory is inside a configured repo/worktree.
- From unrelated directories, require `--project <name>` or `--config <path>`.
- `--project ketryx` resolves to `herdr/projects/ketryx.toml`.
- Non-PR mode creates a new local branch/worktree from `--base`, or from the current branch if `--base` is omitted.
- PR mode reads PR metadata with `gh pr view` and uses the PR `headRefName` as the local branch.
- Worktree directory names normalize branch slashes to dashes.
- Applies configured file copy/symlink operations.
- Opens a Herdr worktree workspace and creates configured tabs/panes.
- Starts the configured agent and sends `-p/--prompt` if provided.
- If the worktree already exists and is already open in Herdr, focuses the existing workspace instead of recreating tabs/panes.
- Use `--force-layout` only when the user intentionally wants to recreate/run layout setup for an existing workspace.

## Remove a worktree

```bash
herdr-worktree rm [name|branch|path ...] [--project <name>] [--keep-branch] [--force] [--dry-run]
herdr-worktree remove [name|branch|path ...] [--project <name>] [--keep-branch] [--force] [--dry-run]
```

Examples:

```bash
herdr-worktree rm --dry-run
herdr-worktree rm patrick-my-feature --dry-run
herdr-worktree rm patrick/my-feature --keep-branch --dry-run
```

Behavior:

- With no name, targets the current worktree.
- Resolves targets by worktree directory name, branch name, or path.
- Refuses to remove the main checkout.
- Refuses dirty worktrees unless `--force` is passed.
- Closes/removes the matching Herdr worktree workspace when present.
- Removes the Git worktree.
- Deletes the local branch unless `--keep-branch` is passed.

## Ketryx config summary

`herdr/projects/ketryx.toml` currently configures:

- repo: `/Users/ryyppy/Projects/work/ketryx`
- worktree dir: `/Users/ryyppy/Projects/work/ketryx__worktrees`
- symlinks: `node_modules`, `apps/ketryx/.env`, `apps/ketryx/data`, `.pnpm-store`
- tabs:
  1. `dev`: runs `pnpm install && devmux run "ketryx:$(devmux-herdr-name)" -- pnpm exec nx run ketryx:dev -H 0.0.0.0 --no-tui`
  2. `agent`: Pi agent on the left, empty shell on the right
  3. `shell`: empty shell pane
