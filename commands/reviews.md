---
name: reviews
description: Create review strategy, response templates, or monitoring system for a local business
argument-hint: "[task or review text to respond to] [--quick | --deliverable]"
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

Build a review strategy using the `local-seo:local-seo-reviews` skill. Invoke the skill, then follow its three-phase process exactly: Discovery → Execute → Output.

CRITICAL: Follow the HARD-GATE enforcement in each phase. Do not dump templates into the terminal without customization. Produce an HTML deliverable for strategy and monitoring outputs.

If the user provided a specific review to respond to, craft a customized response following the skill's templates and rules. Otherwise, use AskUserQuestion to identify what review work is needed.

**Client context flags:**
- `--quick` — Skip client lookup, run in stateless mode (today's default behavior)
- `--deliverable` — Force client context mode, create a client profile if none exists

If no flags are provided, the skill infers the mode: if a client registry exists with entries, it asks which client; otherwise it runs in quick mode.
