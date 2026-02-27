---
name: client
description: Set up, view, or manage client profiles for persistent context across skills
argument-hint: "[new | client-slug | list]"
allowed-tools:
  - WebSearch
  - WebFetch
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - AskUserQuestion
  - TaskCreate
  - TaskUpdate
  - TaskList
  - Bash
  - ToolSearch
---

Manage client profiles using the `local-seo:client-management` skill. Invoke the skill, then follow its process for the requested mode.

**Modes:**
- `/client` or `/client list` — List all registered clients and their status
- `/client new` — Start the new client interview to create a profile
- `/client [slug]` — View a specific client's profile, work log, and deliverables

If the user provided an argument, pass it to determine the mode. If no argument, default to list mode (or create mode if no clients exist yet).
