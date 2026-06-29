---
name: github-gh
description: GitHub PR, pull request, issue, and gh CLI access. Use ONLY when the user wants to read GitHub PRs, read GitHub issues, or create a draft PR with gh.
---

# GitHub GH

Use this skill only for tightly scoped GitHub CLI work.

When to use it:
- The user asks to read a GitHub pull request.
- The user asks to list or inspect pull requests in a repository.
- The user asks to read a GitHub issue.
- The user asks to create a pull request in draft mode.
- The user explicitly asks to use `gh`.

How to use it:
- Delegate the request to the `github-gh` subagent.
- Keep the request limited to reading PRs, reading issues, or creating draft PRs.
- Prefer `gh pr view ... --json ...` and `gh issue view ... --json ...` when structured output helps.
- Prefer `gh pr list ... --json ...` and `gh issue list ... --json ...` for search or listing requests.
- Before creating a draft PR, always look for a pull request template in the repository. Start with the worktree root and standard GitHub template locations, then use that template to shape the PR body.
- For PR creation, always use `gh pr create --draft`.

Do not do these things:
- Do not create a non-draft PR.
- Do not edit, close, reopen, merge, review, comment on, label, assign, or otherwise mutate issues or PRs.
- Do not use `--web`.
- Do not run `gh auth login`, `gh config`, or any interactive setup command.

Expected behavior:
- If the user gives a PR number or URL, read that PR.
- If the user gives an issue number or URL, read that issue.
- If the user asks for open PRs or issues, list the most relevant results concisely.
- If the user asks to create a PR, ensure it is a draft PR only.
- If the request is ambiguous, ask for the smallest missing detail.
