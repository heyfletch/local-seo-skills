---
name: plan
description: Create a strategic local SEO plan with site architecture, keywords, and 90-day roadmap
argument-hint: "[business URL or name] [--quick | --deliverable]"
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

Create a comprehensive local SEO strategic plan using the `local-seo:local-seo-plan` skill. Invoke the skill, then follow its five-phase process exactly: Discovery → Keyword Research → Site Architecture → Traffic Projections & Action Plan → Report Generation.

CRITICAL: Follow the HARD-GATE enforcement in each phase. Do not skip discovery. Do not dump the plan into the terminal — generate the HTML report.

If the user provided a business URL or name as an argument, use that to begin Phase 1 discovery. Otherwise, use AskUserQuestion to gather the required business information.

**Client context flags:**
- `--quick` — Skip client lookup, run in stateless mode (today's default behavior)
- `--deliverable` — Force client context mode, create a client profile if none exists

If no flags are provided, the skill infers the mode: if a client registry exists with entries, it asks which client; otherwise it runs in quick mode.
