---
name: local-seo-audit
description: Comprehensive local SEO audit for service-area and local businesses. Use when the user wants to audit, review, diagnose, or assess local SEO performance, Google Business Profile optimization, citation consistency, review health, local rankings, or AI search visibility. Also triggers for "local SEO check", "how's my local SEO", "GBP audit", "map pack analysis", "local visibility report", or any mention of auditing a local business website.
---

# Local SEO Audit Skill

## Iron Law

NO AUDIT OUTPUT WITHOUT COMPLETING ALL FOUR PHASES. Do not skip discovery. Do not generate a report without scoring. Do not dump findings into the terminal. Every audit follows the four phases below in order.

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
4. Save to `~/Desktop/YYYY-MM-DD-audit-[business-slug].html`
5. Run `open ~/Desktop/[filename].html` via Bash to auto-open in browser
6. Print to terminal ONLY: 3-5 bullet summary + file path

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

- **DataForSEO MCP** (if available) — SERP rankings, Google Maps data, keyword volumes, GBP data, backlinks, on-page crawl. Preferred source for quantitative data.
- **Ahrefs MCP** (if available) — Domain rating, backlinks, organic keywords, competitor analysis
- **WebSearch / WebFetch** — Crawl competitor pages, discover citations, check listings, verify GBP data
- **Google Rich Results Test** — Schema validation (via WebFetch)

Use whichever data tools are available. DataForSEO and Ahrefs complement each other — use both when available.
