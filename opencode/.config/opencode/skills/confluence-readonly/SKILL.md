---
name: confluence-readonly
description: Confluence page, blog, and space read-only access via acli. Use ONLY when the user wants to list/read Confluence spaces, pages, or blog posts without making changes.
---

# Confluence Read-Only

Use this skill only for read-only Confluence access through the Atlassian CLI.

When to use it:
- The user asks to read a Confluence page by ID.
- The user asks to read a Confluence blog post by ID.
- The user asks to list or view Confluence spaces.
- The user asks to list Confluence blog posts.
- The user explicitly asks for read-only Confluence access via `acli`.

How to use it:
- Keep all requests read-only.
- Prefer `acli confluence page view PAGE-ID --json` for specific pages when structured output is useful.
- Prefer `acli confluence blog view BLOG-ID --json` for specific blog posts when structured output is useful.
- Prefer `acli confluence blog list --json` for blog listing requests.
- Prefer `acli confluence space list --json` for space listing requests.
- Prefer `acli confluence space view SPACE-KEY --json` for specific spaces when structured output is useful.
- Use non-JSON output only when it is more readable or the command does not support `--json`.

Allowed command families:
- `acli confluence page view ...`
- `acli confluence blog list ...`
- `acli confluence blog view ...`
- `acli confluence space list ...`
- `acli confluence space view ...`
- `acli confluence ... --help`

Do not do these things:
- Do not use `acli confluence auth`.
- Do not use `acli confluence blog create`.
- Do not use `acli confluence space create`, `update`, `archive`, or `restore`.
- Do not use any Confluence command that creates, updates, archives, restores, deletes, comments on, labels, watches, shares, moves, copies, or otherwise mutates content.
- Do not open browser flows with `--web`.
- Do not run `acli auth login` or any interactive auth/config commands.
- Do not run `curl`, `pass`, `gpg`, `env`, `printenv`, or secret-manager commands directly.

Expected behavior:
- If the user gives a Confluence page URL, extract the page ID when present and view it.
- If the user gives a page ID, read that page.
- If the user gives a blog post ID, read that blog post.
- If the user gives a space key, view that space.
- If the user asks for spaces or blog posts, list the most relevant results concisely.
- If Confluence authorization fails, stop immediately and tell the user to authenticate manually outside the agent.
- If the request is ambiguous, ask for the smallest missing detail.
- Return concise summaries first, then relevant Confluence details.
