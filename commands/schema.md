---
name: schema
description: Generate JSON-LD schema markup for a local business website
argument-hint: "[page type or URL]"
allowed-tools:
  - WebSearch
  - WebFetch
  - Read
  - Write
  - Glob
  - Grep
---

Generate valid JSON-LD schema markup using the `local-seo:local-seo-schema` skill. Invoke the skill, then select the appropriate schema templates based on the page type.

If the user provided a page type (homepage, service page, etc.) or URL as an argument, use that to determine which schema types to generate. Otherwise, ask what pages need schema markup.
