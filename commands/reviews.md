---
name: reviews
description: Create review strategy, response templates, or monitoring system for a local business
argument-hint: "[task or review text to respond to]"
allowed-tools:
  - WebSearch
  - WebFetch
  - Read
  - Write
  - Glob
  - Grep
---

Build a review strategy using the `local-seo:local-seo-reviews` skill. Invoke the skill, then follow the relevant section based on what the user needs (generation system, response templates, monitoring setup, or responding to a specific review).

If the user provided a specific review to respond to, craft a response following the skill's templates and rules. Otherwise, determine what review work is needed.
