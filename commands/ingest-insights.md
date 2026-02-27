---
name: ingest-insights
description: Process inbox items and sync new knowledge into plugin skills
argument-hint: "[apply]"
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

Process the knowledge inbox using the `local-seo:ingest-insights` skill. Invoke the skill, then follow its six-phase process exactly: Ingest → Evaluate → Analyze → Diff → Recommend → Apply.

CRITICAL: Follow the HARD-GATE enforcement in each phase. Default mode is dry-run (Phases 1-5 only). Do not execute Phase 6 (Apply) unless the user explicitly says "apply", "implement", "go", or similar.

If the user provided "apply" as an argument, this indicates intent to apply a previously generated sync report — check for the most recent report in `inbox/reports/` and proceed to Phase 6.
