---
name: jira-readonly
description: Jira ticket search, Jira issue search, Jira ticket read, Jira issue read via acli. Use ONLY when the user wants to search Jira work items or read a Jira work item without making changes.
---

# Jira Read-Only

Use this skill only for read-only Jira access through the Atlassian CLI.

When to use it:
- The user asks to find Jira tickets.
- The user asks to search Jira with text or JQL.
- The user asks to read a Jira ticket by key.
- The user asks for ticket status, assignee, summary, description, or comments.

How to use it:
- Delegate the request to the `jira-reader` subagent.
- Keep the request read-only.
- Prefer `acli jira workitem search --json` for searches.
- Prefer `acli jira workitem view KEY --json` for specific tickets when structured output is useful.

Do not do these things:
- Do not use `acli jira workitem create`, `edit`, `comment`, `transition`, `delete`, `assign`, `watcher`, `attachment`, `clone`, `link`, `archive`, or `unarchive`.
- Do not use broader Jira commands outside strict ticket search/read.
- Do not open browser flows with `--web`.
- Do not run `acli auth login` or any interactive auth/config commands.

Expected behavior:
- If the user gives a ticket key, read that ticket.
- If the user gives search terms, convert them into a minimal Jira search request.
- If the user already provides JQL, use it directly.
- If the request is ambiguous, ask for the smallest missing detail.
- Return concise summaries first, then relevant ticket details.
