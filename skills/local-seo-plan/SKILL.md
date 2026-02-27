---
name: local-seo-plan
description: This skill should be used when the user asks to "create an SEO roadmap", "plan my site architecture", "do keyword research for my local business", "keyword strategy", "what pages should I create", "build a sitemap", "marketing plan for [local business type]", "90-day action plan", or any strategic planning for a local or multi-location business. Covers keyword research, site structure, traffic projections, and action planning. For ongoing content calendars and blog topic planning, use the local-seo-content skill instead.
---

# Local SEO Strategic Plan Skill

## Iron Law

NO PLAN OUTPUT WITHOUT COMPLETING ALL FIVE PHASES. Do not skip discovery. Do not generate a roadmap without keyword research. Do not dump the plan into the terminal. Every plan follows the five phases below in order.

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

Use AskUserQuestion:

**Question:** "What business are we planning for?"
- Options: "I'll provide a URL", "I'll provide a business name + city", "Both URL and name"

### Step 2: Auto-discover

Use WebSearch to discover: website, industry, services, locations, service area, competitors. Present findings and ask the user to confirm or correct via AskUserQuestion.

### Step 3: Gather goals and context

Use AskUserQuestion for each remaining piece of information (skip any already answered):

**Question:** "What are your primary business goals?"
- "More phone calls / leads"
- "More online bookings"
- "Brand awareness / visibility"
- "Compete with a specific competitor"

**Question:** "What's your monthly SEO budget?"
- "$0 (DIY only)"
- "$1-50/month (basic tools)"
- "$51-200/month (tools + some services)"
- "$200+/month (managed services)"

**Question:** "Any seasonal patterns in your business?"
- "Yes — busy and slow seasons"
- "Fairly consistent year-round"
- "Not sure"

### Step 4: Data tools

Use AskUserQuestion:

**Question:** "Do you want to use enhanced data tools for this plan?"
- "Yes — use Ahrefs and DataForSEO"
- "Just Ahrefs"
- "Just DataForSEO"
- "No — WebSearch is fine"

For each selected tool, verify the MCP is responding. If it fails, inform the user and offer setup help or fall back to WebSearch. See [references/prerequisites.md](../../references/prerequisites.md).

### Information needed (discover via research, only ask user if undiscoverable)
- Business name, website URL, industry
- Services offered (complete list)
- Service area (all cities/regions)
- Number of locations (single vs multi)
- Target audience / ideal client profile
- Current monthly traffic (GA4/GSC if available)
- Budget tier
- Competitors (or discover via search)
- Business goals
- Unique selling propositions
- Seasonal patterns

---

## Phase 2: Keyword Research

<HARD-GATE>
DO NOT proceed to Phase 3 until keyword research is complete with metrics documented.
</HARD-GATE>

Read the keyword research guide from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-plan/references/keyword-research-guide.md`.

Create TaskCreate items for:
- Service keyword research
- Location keyword research
- Long-tail / informational keyword research
- KGR quick-win identification

Use available data tools (DataForSEO MCP, Ahrefs MCP, WebSearch) to gather keyword volumes, difficulty scores, and current rankings.

Organize keywords into the five categories (Service, Location, Long-tail, Zero-volume, AI/LLM sub-queries). Apply ICE scoring for prioritization.

---

## Phase 3: Site Architecture

Read the site architecture guide from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-plan/references/site-architecture-guide.md`.

1. Design the optimal sitemap structure based on keyword research
2. Map each keyword to a target page
3. Define page-level specifications (title, meta, H1, content requirements, schema)
4. Plan internal linking strategy with topic silos
5. Apply quality gates for service area pages (warn at 30+, hard stop at 50+)

---

## Phase 4: Traffic Projections & Action Plan

Read the traffic projections guide from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-plan/references/traffic-projections.md`.

1. Calculate projected traffic at 3, 6, and 12 months
2. Apply adjustment factors for domain authority and competition
3. Build the week-by-week 90-day action plan
4. Score each action item with the Impact × Effort priority matrix

---

## Phase 5: Report Generation

<HARD-GATE>
DO NOT skip report generation. ALWAYS produce an HTML report. Do not dump the plan into the terminal.
</HARD-GATE>

1. Read the HTML plan template at `${CLAUDE_PLUGIN_ROOT}/references/html-plan-template.html`
2. Generate a self-contained HTML roadmap with all sections: executive summary, competitor analysis, keyword strategy, sitemap, traffic projections, 90-day action plan
3. Save to `[output_dir]/YYYY-MM-DD-plan-[business-slug].html` (default `output_dir`: `~/Desktop/`)
4. If `auto_open` is true (default), run `open [filepath]` via Bash to auto-open in browser
5. Print to terminal ONLY: 3-5 bullet summary + file path

---

## Phase 3.5: Client Profile Update

Follow the instructions in [references/client-context-phases.md](../../references/client-context-phases.md) — Phase 3.5 section.

Only runs when client context is active. Offers to update the work log, save a reference doc, track the deliverable, and suggest related standard deliverables.

---

## Red Flags

| Thought | Reality |
|---|---|
| "I have enough info to build the plan" | Complete ALL discovery questions first. Missing context = wrong strategy. |
| "I'll skip keyword research and go straight to sitemap" | Architecture without data is guessing. Do the research. |
| "I'll just list the keywords in a table" | Keywords need volume, difficulty, KGR, ICE scores, and page assignments. |
| "I'll output the plan to the terminal" | The plan IS the HTML report. Terminal gets a summary only. |
| "Traffic projections are hard, I'll skip them" | Clients need numbers to justify investment. Always project. |

---

## Tools to Use

> **Optional MCPs:** ahrefs and dataforseo — user chooses in Phase 1, Step 4. See [references/prerequisites.md](../../references/prerequisites.md).

- **DataForSEO MCP** (if available) — Keyword volumes, SERP data, competitor analysis, Google Maps rankings. Preferred for keyword research.
- **Ahrefs MCP** (if available) — Domain metrics, organic keywords, competitor gaps
- **WebSearch / WebFetch** — Competitor research, content gap analysis, SERP analysis

## Self-Improvement
- After the user approves final output, offer to save it as an approved example for future reference
- If the user gives explicit negative feedback, offer to add it as a learned rule
- If approved examples exist in references/approved-examples/, review them before generating new output to match established quality
