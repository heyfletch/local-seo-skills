---
name: area-page
description: Build a unique service area or location page for a local business
argument-hint: "[city or area name] [--quick | --deliverable]"
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

Build a genuinely unique service area page using the `local-seo:local-seo-area-page` skill. Invoke the skill, then follow its four-phase process exactly: Discovery → Local Research → Content Generation → Output.

CRITICAL: Follow the HARD-GATE enforcement in each phase. Enforce the quality gate in Phase 1 — do not create thin/template pages that just swap city names. Do not dump the page into the terminal — save as semantic HTML file.

If the user provided a city or area name as an argument, use that to begin Phase 1 discovery. Otherwise, use AskUserQuestion to identify the target area.

**Client context flags:**
- `--quick` — Skip client lookup, run in stateless mode (today's default behavior)
- `--deliverable` — Force client context mode, create a client profile if none exists

If no flags are provided, the skill infers the mode: if a client registry exists with entries, it asks which client; otherwise it runs in quick mode.
