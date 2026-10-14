---
name: git-operations
description: Git add, commit, status, diff, log, branch, tag, stash, merge, rebase, fetch, pull, push, restore, reset, and other Git operations. Use ONLY when the user asks to perform Git repository operations without changing file contents.
---

# Git Operations

Delegate Git-only requests to the `git-operations` subagent.

## Use This Skill

Use it when the requested result is a Git repository operation, including:

- Inspecting status, diffs, history, commits, branches, tags, or remotes.
- Staging or unstaging existing changes.
- Creating a commit from existing changes.
- Branching, switching, stashing, merging, rebasing, cherry-picking, or reverting.
- Fetching, pulling, or pushing when explicitly requested.
- Restoring, resetting, cleaning, moving, or removing through Git when explicitly requested.

## Do Not Use This Skill

- Do not use it to edit source code or file contents.
- Do not use it to run tests, builds, formatters, package managers, or arbitrary shell commands.
- Do not use it for GitHub issues or pull requests; use the GitHub-specific skill instead.
- Do not use it merely because another task happens inside a Git repository.

## Delegation Contract

- Give the subagent the user's exact requested operation, repository context, path scope, and commit message requirements.
- Do not broaden the requested scope.
- Let the subagent inspect repository state through Git before mutating it.
- If the request combines file edits with Git operations, complete the edits elsewhere and delegate only the Git portion.
- Return the subagent's result concisely, including affected paths and commit hash when applicable.

## Safety Defaults

- Preserve unrelated work.
- Stage explicit paths rather than all changes.
- Review staged changes before every commit.
- Never amend, bypass hooks, discard work, rewrite history, or modify a remote unless explicitly requested.
- Never force-push, hard-reset, or force-clean.
