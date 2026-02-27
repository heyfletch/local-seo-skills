---
name: agency
description: Get help packaging, pricing, selling, and delivering local SEO services as an agency or freelancer
argument-hint: "[topic or question] [--quick | --deliverable]"
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

Build or grow a local SEO agency using the `local-seo:local-seo-agency` skill. Invoke the skill, then follow its four-phase process exactly: Discovery → Contextual Guidance → Action Plan → Output.

CRITICAL: Follow the HARD-GATE enforcement in each phase. Do not dump all agency knowledge at once. Do not skip output generation — produce an HTML deliverable.

If the user provided a specific topic or question as an argument, use that to begin Phase 1 discovery. Otherwise, use AskUserQuestion to identify what they need help with.

**Client context flags:**
- `--quick` — Skip client lookup, run in stateless mode (today's default behavior)
- `--deliverable` — Force client context mode, create a client profile if none exists

If no flags are provided, the skill infers the mode: if a client registry exists with entries, it asks which client; otherwise it runs in quick mode.
