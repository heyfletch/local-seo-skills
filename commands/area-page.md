---
name: area-page
description: Build a unique service area or location page for a local business
argument-hint: "[city or area name]"
allowed-tools:
  - WebSearch
  - WebFetch
  - Read
  - Write
  - Glob
  - Grep
---

Build a genuinely unique service area page using the `local-seo:local-seo-area-page` skill. Invoke the skill, then follow its full page-building process.

If the user provided a city or area name as an argument, use that as the target location. Otherwise, ask for the required information as specified in the skill's "Before Writing" section.

IMPORTANT: Enforce the skill's quality gates — do not create thin/template pages that just swap city names.
