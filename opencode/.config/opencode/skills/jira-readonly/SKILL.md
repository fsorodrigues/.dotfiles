---
name: jira-readonly
description: Jira ticket search, Jira issue search, Jira ticket read, Jira attachment listing, and Jira attachment text reads via acli. Use ONLY when the user wants to search/read Jira work items or read Jira attachment text without making changes.
---

# Jira Read-Only

Use this skill only for read-only Jira access through the Atlassian CLI.

When to use it:
- The user asks to find Jira tickets.
- The user asks to search Jira with text or JQL.
- The user asks to read a Jira ticket by key.
- The user asks for ticket status, assignee, summary, description, or comments.
- The user asks to list Jira ticket attachments or read text from a Jira attachment.

How to use it:
- Delegate the request to the `jira-reader` subagent.
- Keep the request read-only.
- Prefer `acli jira workitem search --json` for searches.
- Prefer `acli jira workitem view KEY --json` for specific tickets when structured output is useful.
- Prefer `acli jira workitem attachment list --key KEY --json` to find attachment IDs.
- Use `jira-attachment-text KEY ATTACHMENT-ID` for attachment text extraction after the attachment ID is known.

Do not do these things:
- Do not use `acli jira workitem create`, `edit`, `comment`, `transition`, `delete`, `assign`, `watcher`, `clone`, `link`, `archive`, or `unarchive`.
- Do not use attachment commands other than `acli jira workitem attachment list`.
- Do not use broader Jira commands outside strict ticket search/read.
- Do not open browser flows with `--web`.
- Do not run `acli auth login` or any interactive auth/config commands.
- Do not run `curl`, `pass`, `gpg`, `env`, `printenv`, or secret-manager commands directly.

Expected behavior:
- If the user gives a ticket key, read that ticket.
- If the user gives search terms, convert them into a minimal Jira search request.
- If the user already provides JQL, use it directly.
- If the user asks for an attachment by name, list attachments first, choose the matching attachment ID, and ask a clarification only if the match is ambiguous.
- If the user asks for an attachment by ID, call `jira-attachment-text` with the Jira key and attachment ID.
- If Jira authorization fails, stop immediately and tell the user to authenticate manually outside the agent.
- If GPG/pass is locked or unavailable, stop immediately and tell the user to run the unlock command reported by `jira-attachment-text`, then retry.
- If the request is ambiguous, ask for the smallest missing detail.
- Return concise summaries first, then relevant ticket details.
- Return attachment text only from `jira-attachment-text`; do not persist downloaded attachment files.
