---
name: local-seo-schema
description: This skill should be used when the user asks to "add schema markup", "generate structured data", "create JSON-LD", "add schema.org markup", "LocalBusiness schema", "FAQ schema", "rich snippets", "rich results", or any standalone schema markup generation for a local business website. Also triggers for "schema for service page", "schema for homepage", "validate my structured data", or optimizing for Knowledge Graph through structured data. Use this skill for standalone schema generation. When building a new service page or area page, schema is generated automatically by those skills — this skill is for adding schema to existing pages or generating schema independently.
---

# Local SEO Schema Markup Skill

## Iron Law

NO SCHEMA OUTPUT WITHOUT IDENTIFYING THE PAGE TYPE AND BUSINESS DETAILS. Do not generate generic templates. Every schema must be populated with real business data and validated before delivery.

---

## Settings

Before starting Phase 1, check if `.claude/local-seo.local.md` exists. If it does, read it and extract settings from the YAML frontmatter:

- `output_dir` — directory for saving reports/pages (default: `~/Desktop/`)
- `auto_open` — whether to auto-open files in browser (default: `true`)

Use these values in the output phase. If the file doesn't exist, use defaults.

---

## Phase 0: Client Context

Follow the instructions in [references/client-context-phases.md](../../references/client-context-phases.md) — Phase 0 section.

This determines whether the skill runs in **quick mode** (today's behavior) or **deliverable mode** (with client profile pre-loaded).

If client context is loaded:
- Phase 1 Steps 1-2 are skipped (business already identified)
- Output directory is set to `[client-path]/deliverables/`
- All business context is pre-populated from the profile

---

## Phase 1: Discovery

<HARD-GATE>
DO NOT proceed to Phase 2 until the page type and business details are confirmed.
</HARD-GATE>

### Step 1: Identify the need

Use AskUserQuestion:

**Question:** "What page type needs schema markup?"
- "Homepage (LocalBusiness)"
- "Service page (Service + FAQPage)"
- "Service area page (LocalBusiness + areaServed)"
- "Multiple page types"

### Step 2: Gather business details

Use AskUserQuestion:

**Question:** "How should I get your business details?"
- "I'll provide the website URL — scrape the details"
- "I'll type the details manually"
- "Use details from a previous audit/plan in this session"

If a URL is provided, use WebFetch to extract: business name, address, phone, services, hours, social profiles. Present findings and ask the user to confirm via AskUserQuestion.

### Information needed
- Business name and type (for @type selection)
- Address (or service area if SAB)
- Phone number
- Website URL
- Business hours
- Services offered
- Social media profiles
- Review count and average rating (if applicable)
- Team members (if About/Team page)

---

## Phase 2: Generate Schema

Read the schema templates from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-schema/references/schema-templates.md`.

1. Select the appropriate template(s) for the page type
2. Populate ALL placeholder values with real business data
3. For SABs: omit `address`, use `areaServed` instead
4. Choose the most specific `@type` (e.g., "Dentist" not "LocalBusiness")
5. Include all applicable nested schemas (e.g., Service + FAQPage + BreadcrumbList on service pages)
6. Note any deprecation warnings (HowTo, FAQ rich results restrictions)

---

## Phase 3: Output

<HARD-GATE>
DO NOT skip saving the output. ALWAYS save schema as a file.
</HARD-GATE>

1. Generate valid JSON-LD wrapped in `<script type="application/ld+json">` tags
2. Save to `[output_dir]/YYYY-MM-DD-schema-[page-slug].json` (default `output_dir`: `~/Desktop/`; use `.html` if wrapping in script tags)
3. Print to terminal: the complete JSON-LD code (schema is code, not a report — terminal output is appropriate here) + file path + validation instructions
4. Remind the user to validate at https://search.google.com/test/rich-results

---

## Phase 3.5: Client Profile Update

Follow the instructions in [references/client-context-phases.md](../../references/client-context-phases.md) — Phase 3.5 section.

Only runs when client context is active. Offers to update the work log, save a reference doc, track the deliverable, and suggest related standard deliverables.

---

## Red Flags

| Thought | Reality |
|---|---|
| "I'll generate a generic template" | Populate with REAL business data. Generic templates need extra work from the user. |
| "LocalBusiness type is fine" | Use the most specific @type available (Dentist, Plumber, LegalService, etc.). |
| "I'll include the address for this SAB" | Service area businesses OMIT address and use areaServed instead. |
| "FAQ schema still gets rich results" | FAQ rich results are restricted since 2023. Still implement for Knowledge Graph, but set expectations. |
| "One schema per page is enough" | Multiple schemas per page is fine and recommended (Service + FAQPage + BreadcrumbList). |

---

## Tools to Use

- **WebFetch** — Scrape business details from website
- **WebSearch** — Look up business hours, address, review data

## Self-Improvement
- After the user approves final output, offer to save it as an approved example for future reference
- If the user gives explicit negative feedback, offer to add it as a learned rule
- If approved examples exist in references/approved-examples/, review them before generating new output to match established quality
