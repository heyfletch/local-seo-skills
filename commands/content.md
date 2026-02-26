---
name: content
description: Plan content strategy, calendar, blog topics, or social media for a local business
argument-hint: "[business name or content type]"
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

Create a content strategy using the `local-seo:local-seo-content` skill. Invoke the skill, then follow its four-phase process exactly: Discovery → Topic Generation & Prioritization → Calendar Building → Report Generation.

CRITICAL: Follow the HARD-GATE enforcement in each phase. Do not skip discovery. Do not dump the calendar into the terminal — generate the HTML report.

If the user provided a business name or specific content type as an argument, use that to begin Phase 1 discovery. Otherwise, use AskUserQuestion to gather the required information.
