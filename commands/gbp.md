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
---

Optimize a Google Business Profile using the `local-seo:local-seo-gbp` skill. Invoke the skill, then follow the relevant section based on what the user needs (full optimization, posting strategy, Q&A setup, etc.).

If the user provided a business name or specific task as an argument, use that to begin. Otherwise, determine what GBP work is needed.
