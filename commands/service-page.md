---
name: service-page
description: Build an SEO-optimized service page for a local business
argument-hint: "[service name]"
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

Build a high-converting, SEO-optimized service page using the `local-seo:local-seo-service-page` skill. Invoke the skill, then follow its four-phase process exactly: Discovery → Research → Content Generation → Output.

CRITICAL: Follow the HARD-GATE enforcement in each phase. Do not skip research. Do not dump the page into the terminal — save as semantic HTML file.

If the user provided a service name as an argument, use that to begin Phase 1 discovery. Otherwise, use AskUserQuestion to identify the service and business.
