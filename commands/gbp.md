---
name: gbp
description: Optimize Google Business Profile, create posts, or manage Q&A strategy
argument-hint: "[business name or task]"
allowed-tools:
  - WebSearch
  - WebFetch
  - Read
  - Write
  - Glob
  - Grep
  - AskUserQuestion
  - TaskCreate
  - TaskUpdate
  - TaskList
  - Bash
  - ToolSearch
---

Optimize a Google Business Profile using the `local-seo:local-seo-gbp` skill. Invoke the skill, then follow its four-phase process exactly: Discovery → Execute → Compile Results → Output.

CRITICAL: Follow the HARD-GATE enforcement in each phase. Do not dump checklists or posts into the terminal — generate the HTML deliverable.

If the user provided a business name or specific task as an argument, use that to begin Phase 1 discovery. Otherwise, use AskUserQuestion to identify the business and GBP task.
