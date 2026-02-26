---
name: audit
description: Run a comprehensive local SEO audit for a local or service-area business
argument-hint: "[business URL or name]"
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

Perform a comprehensive local SEO audit using the `local-seo:local-seo-audit` skill. Invoke the skill, then follow its four-phase process exactly: Discovery → Audit Execution → Scoring → Report Generation.

CRITICAL: Follow the HARD-GATE enforcement in each phase. Do not skip discovery. Do not output findings to the terminal — generate the HTML report.

If the user provided a business URL or name as an argument, use that to begin Phase 1 discovery. Otherwise, use AskUserQuestion to gather the required business information.
