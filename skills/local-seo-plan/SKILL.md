---
name: local-seo-plan
description: Strategic local SEO planning for service-area and local businesses. Use when the user wants to create a marketing roadmap, site architecture, keyword strategy, sitemap, content plan, or 90-day action plan for a local business. Also triggers for "SEO roadmap", "keyword research for local business", "site structure", "what pages should I create", "marketing plan for [local business type]", or strategic planning for multi-location businesses.
---

# Local SEO Strategic Plan Skill

## Iron Law

NO PLAN OUTPUT WITHOUT COMPLETING ALL FIVE PHASES. Do not skip discovery. Do not generate a roadmap without keyword research. Do not dump the plan into the terminal. Every plan follows the five phases below in order.

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
3. Save to `~/Desktop/YYYY-MM-DD-plan-[business-slug].html`
4. Run `open ~/Desktop/[filename].html` via Bash to auto-open in browser
5. Print to terminal ONLY: 3-5 bullet summary + file path

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

- **DataForSEO MCP** (if available) — Keyword volumes, SERP data, competitor analysis, Google Maps rankings. Preferred for keyword research.
- **Ahrefs MCP** (if available) — Domain metrics, organic keywords, competitor gaps
- **WebSearch / WebFetch** — Competitor research, content gap analysis, SERP analysis
