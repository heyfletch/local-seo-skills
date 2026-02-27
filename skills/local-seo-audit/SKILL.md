---
name: local-seo-audit
description: This skill should be used when the user asks to "audit my local SEO", "review my local rankings", "diagnose local SEO issues", "assess local SEO performance", "local SEO check", "how's my local SEO", "GBP audit", "map pack analysis", "local visibility report", or any mention of auditing a local business website. Covers GBP optimization, citation consistency, review health, local rankings, and AI search visibility as part of a comprehensive audit. For standalone GBP optimization without a full audit, use the local-seo-gbp skill instead.
---

# Local SEO Audit Skill

## Iron Law

NO AUDIT OUTPUT WITHOUT COMPLETING ALL FOUR PHASES. Do not skip discovery. Do not generate a report without scoring. Do not dump findings into the terminal. Every audit follows the four phases below in order.

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
DO NOT proceed to Phase 2 until all discovery questions are answered and confirmed.
</HARD-GATE>

### Step 1: Identify the business

Use AskUserQuestion with these options:

**Question:** "What business should I audit?"
- Options: "I'll provide a URL", "I'll provide a business name + city", "Both URL and name"

### Step 2: Auto-discover

Once the business is identified, use WebSearch to discover:
- Website URL, GBP listing, industry, location, services, competitors

Present findings and ask the user to confirm or correct via AskUserQuestion.

### Step 3: Determine scope

Use AskUserQuestion:

**Question:** "What audit scope do you want?"
- "Full audit (all categories)" — recommended
- "Focused: GBP + Reviews only"
- "Focused: On-Page + Technical only"
- "Focused: AI Visibility + Citations only"

### Step 4: Data tools

Use AskUserQuestion:

**Question:** "Do you want to use enhanced data tools for this audit?"
- "Yes — use Ahrefs and DataForSEO"
- "Just Ahrefs"
- "Just DataForSEO"
- "No — WebSearch is fine"

For each selected tool, verify the MCP is responding. If it fails, inform the user and offer setup help or fall back to WebSearch. See [references/prerequisites.md](../../references/prerequisites.md).

### Information needed (discover via research, only ask user if undiscoverable)
- Business website URL
- Google Business Profile URL or business name + city
- Business type / industry
- Service area (cities/regions served)
- Primary services offered
- Top 3-5 competitors (or discover them)
- Current monthly organic traffic (if available from GA4/GSC)
- Number of locations (single vs multi-location)

---

## Phase 2: Audit Execution

<HARD-GATE>
DO NOT proceed to Phase 3 until all audit categories (per the selected scope) are complete with scores.
</HARD-GATE>

Create a TaskCreate item for each audit category being executed. Mark each in_progress when starting and completed when done.

Read the full checklists from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-audit/references/audit-checklists.md` and execute each applicable category:

| Task | Category | Weight (Local Pack) |
|---|---|---|
| GBP Audit | A: Google Business Profile | 32% |
| Review Audit | B: Reviews | 20% |
| On-Page Audit | C: On-Page / Website | 15% (33% organic) |
| Link Profile Audit | D: Links | 12% (24% organic) |
| Citation Audit | E: Citations | 7% |
| AI Visibility Audit | F: AI Search Visibility | — |
| SERP Landscape | F2: SERP Layout Check | — |
| Competitor Analysis | G: Competitor Comparison | — |
| Analytics Audit | H: Analytics & ROI Tracking | — |

For each category: research using available tools (WebSearch, WebFetch, DataForSEO MCP, Ahrefs MCP), score 0-100, and flag specific issues with actionable recommendations.

---

## Phase 3: Scoring & Prioritization

Read the scoring framework from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-audit/references/audit-scoring.md`.

1. Score each category 0-100
2. Calculate weighted overall score using the algorithm weighting table
3. Apply the priority matrix (Impact × Effort) to every recommendation
4. Sort recommendations by priority score (10 = DO NOW, 1 = SKIP)

---

## Phase 4: Report Generation

<HARD-GATE>
DO NOT skip report generation. ALWAYS produce an HTML report. Do not dump findings into the terminal.
</HARD-GATE>

1. Read the HTML template at `${CLAUDE_PLUGIN_ROOT}/references/html-report-template.html`
2. Generate a self-contained HTML report with all findings, scores, and recommendations
3. Follow the output format from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-audit/references/audit-scoring.md`
4. Save to `[output_dir]/YYYY-MM-DD-audit-[business-slug].html` (default `output_dir`: `~/Desktop/`)
5. If `auto_open` is true (default), run `open [filepath]` via Bash to auto-open in browser
6. Print to terminal ONLY: 3-5 bullet summary + file path

---

## Phase 3.5: Client Profile Update

Follow the instructions in [references/client-context-phases.md](../../references/client-context-phases.md) — Phase 3.5 section.

Only runs when client context is active. Offers to update the work log, save a reference doc, track the deliverable, and suggest related standard deliverables.

---

## Red Flags

| Thought | Reality |
|---|---|
| "I have enough info to start the audit" | Complete ALL discovery questions first. Assumptions create wrong recommendations. |
| "I'll just check a few categories" | Run ALL categories in the selected scope. Partial audits miss critical issues. |
| "I'll output findings as I go" | Findings go in the HTML report, not the terminal. |
| "The user didn't ask for a report" | The report IS the deliverable. Always generate it. |
| "I'll skip scoring, the findings speak for themselves" | Without scoring, the client can't prioritize. Always score. |

---

## Tools to Use

> **Optional MCPs:** ahrefs and dataforseo — user chooses in Phase 1, Step 4. See [references/prerequisites.md](../../references/prerequisites.md).

- **DataForSEO MCP** (if available) — SERP rankings, Google Maps data, keyword volumes, GBP data, backlinks, on-page crawl. Preferred source for quantitative data.
- **Ahrefs MCP** (if available) — Domain rating, backlinks, organic keywords, competitor analysis
- **WebSearch / WebFetch** — Crawl competitor pages, discover citations, check listings, verify GBP data
- **Google Rich Results Test** — Schema validation (via WebFetch)

Use whichever data tools are available. DataForSEO and Ahrefs complement each other — use both when available.

## Self-Improvement
- After the user approves final output, offer to save it as an approved example for future reference
- If the user gives explicit negative feedback, offer to add it as a learned rule
- If approved examples exist in references/approved-examples/, review them before generating new output to match established quality
