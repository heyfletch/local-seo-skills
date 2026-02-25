---
name: audit
description: Run a comprehensive local SEO audit for a local or service-area business
argument-hint: "[business URL or name]"
allowed-tools:
  - WebSearch
  - WebFetch
  - Read
  - Write
  - Glob
  - Grep
---

Perform a comprehensive local SEO audit using the `local-seo:local-seo-audit` skill. Invoke the skill, then follow its full audit process.

If the user provided a business URL or name as an argument, use that to begin the audit. Otherwise, ask the user for the required business information as specified in the skill's Step 1.
