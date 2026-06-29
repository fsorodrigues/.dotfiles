---
name: jira-name-email-extractor
description: Extract name and email from Jira tickets and format them into a CSV-like file. Use when the user wants to read Jira tickets and export name/email information.
---

# Jira Name and Email Extractor

Use this skill to extract name and email information from Jira tickets and save them in a structured format.

## When to use it:
- The user asks to read Jira tickets and extract name/email information.
- The user asks to save user information from Jira tickets to a file.
- The user provides Jira ticket keys (e.g., PTUS-2200, PTUS-2203) and wants user data extracted.

## Workflow:

1. **Read the Jira tickets**
   - Extract all name and email information from the ticket description and custom fields.
   - Look for patterns like:
     - Name: [Full Name]
     - Email: [email@domain.com]
     - Or any variations in the ticket description.

2. **Extract and format the data**
   - Parse the ticket content to extract name and email pairs.
   - Format each entry as: `name:Full Name,email:user@domain.tld`
   - One entry per line.

3. **Save to file**
   - Save the output to a file in the current working directory.
   - Default filename: `users.txt`
   - Unless the user specifies a different filename or location.

## Output format:

```
name:Full Name,email:user@domain.tld
name:Another Person,email:person@company.com
```

## Important notes:
- Remove any example comments or template text unless the user explicitly wants them included.
- Handle multiple users per ticket (some tickets may contain multiple name/email pairs).
- Preserve the exact email formatting from the tickets (case sensitivity, domain names).

## Do not:
- Modify or update the Jira tickets themselves.
- Add users to any systems - this skill only extracts and formats data.
- Include ticket metadata (status, assignee, etc.) unless specifically requested.
