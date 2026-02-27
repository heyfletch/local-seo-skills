---
name: schema
description: Generate JSON-LD schema markup for a local business website
argument-hint: "[page type or URL] [--quick | --deliverable]"
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

Generate valid JSON-LD schema markup using the `local-seo:local-seo-schema` skill. Invoke the skill, then follow its three-phase process exactly: Discovery → Generate Schema → Output.

CRITICAL: Follow the HARD-GATE enforcement in each phase. Do not generate generic templates — populate with real business data. Always save the output as a file.

If the user provided a page type (homepage, service page, etc.) or URL as an argument, use that to begin Phase 1 discovery. Otherwise, use AskUserQuestion to identify the page type.

**Client context flags:**
- `--quick` — Skip client lookup, run in stateless mode (today's default behavior)
- `--deliverable` — Force client context mode, create a client profile if none exists

If no flags are provided, the skill infers the mode: if a client registry exists with entries, it asks which client; otherwise it runs in quick mode.
