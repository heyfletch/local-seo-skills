---
name: local-seo-content
description: This skill should be used when the user asks to "create a content calendar", "plan my blog topics", "what should I blog about", "content ideas for [business type]", "build a posting schedule", "social media plan", "what content to create next", or any ongoing content strategy and calendar planning for a local business. Covers blog topics, GBP post scheduling, and social media planning on a calendar. This skill plans and schedules content — for writing actual GBP posts, use the local-seo-gbp skill. For one-time strategic site architecture planning, use the local-seo-plan skill.
---

# Local SEO Content Strategy Skill

## Iron Law

NO CONTENT CALENDAR OUTPUT WITHOUT COMPLETING ALL FOUR PHASES. Do not skip discovery. Do not generate a calendar without topic prioritization. Do not dump the calendar into the terminal. Every content plan follows the four phases below in order.

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

## Phase 0.5: Analytics Data

Follow the instructions in [references/analytics-integration.md](../../references/analytics-integration.md) — "For content skill" section.

If analytics data is available:
- Topic prioritization uses real GSC query data to find content gaps (queries with impressions but low clicks)
- Existing content audit uses GA4 page performance to identify refresh candidates (high-traffic pages with declining engagement)
- Content calendar scheduling prioritizes topics that support pages already ranking in positions 5-20

---

## Phase 1: Discovery

<HARD-GATE>
DO NOT proceed to Phase 2 until all discovery questions are answered and confirmed.
</HARD-GATE>

### Step 1: Identify the business

Use AskUserQuestion:

**Question:** "What business is this content plan for?"
- Options: "I'll provide a URL", "I'll provide a business name + city", "Both URL and name"

### Step 2: Auto-discover

Use WebSearch to discover: website, industry, services, existing content, competitors, blog presence. Present findings and ask the user to confirm or correct via AskUserQuestion.

### Step 3: Determine content scope

Use AskUserQuestion:

**Question:** "What content planning do you need?"
- "Full content strategy (blog + GBP + social + funnel)" — recommended
- "Blog topic ideas and calendar only"
- "GBP posting calendar only"
- "Content refresh audit for existing pages"
- "Sales funnel & lead magnet strategy"

### Step 4: Gather context

Use AskUserQuestion for remaining details (skip any already answered):

**Question:** "What's your content creation capacity?"
- "1-2 pieces per month (solo/limited)"
- "3-4 pieces per month (dedicated time)"
- "5+ pieces per month (team or agency)"

**Question:** "Any seasonal patterns or upcoming events?"
- "Yes — I'll describe them"
- "Fairly consistent year-round"
- "Not sure — help me identify them"

### Step 5: Data tools

Use AskUserQuestion:

**Question:** "Do you want to use enhanced data tools for keyword research?"
- "Yes — use Ahrefs and DataForSEO"
- "Just Ahrefs"
- "Just DataForSEO"
- "No — WebSearch is fine"

For each selected tool, verify the MCP is responding. If it fails, inform the user and offer setup help or fall back to WebSearch. See [references/prerequisites.md](../../references/prerequisites.md).

---

## Phase 2: Topic Generation & Prioritization

<HARD-GATE>
DO NOT proceed to Phase 3 until topics are generated and scored.
</HARD-GATE>

Read the content frameworks from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-content/references/content-frameworks.md`.

Create TaskCreate items for:
- Topic mining (customer questions, GSC queries, competitor gaps, PAA, Reddit)
- Topic evaluation and ICE scoring
- Content tier assignment (Tier 1-4)

Use available data tools (DataForSEO MCP, Ahrefs MCP, WebSearch) to gather keyword data. Apply the ICE scoring framework to prioritize topics. Flag all KGR < 0.25 keywords as quick-win targets.

If the content scope includes "Full content strategy" or "Sales funnel & lead magnet strategy," also review the Sales Funnel & Lead Magnet Strategy and Email Marketing Strategy sections in the content frameworks reference. Recommend lead magnets and email nurture sequences when appropriate for the business type. Note: actual email sequence creation should be handled by dedicated email campaign skills or tools — this skill identifies when email is a strategic fit and defines the sequence types needed.

---

## Phase 3: Calendar Building

Read the calendar template from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-content/references/content-calendar-template.md`.

1. Map prioritized topics to a weekly/monthly schedule based on the user's content capacity
2. Assign content types (blog, GBP post, social, refresh) and platforms
3. Apply the 12-month plan template for longer-term strategy
4. Include content refresh recommendations for existing pages
5. Add seasonal content aligned to the appropriate quarter

---

## Phase 4: Report Generation

<HARD-GATE>
DO NOT skip report generation. ALWAYS produce an HTML report. Do not dump the calendar into the terminal.
</HARD-GATE>

1. Read the HTML calendar template at `${CLAUDE_PLUGIN_ROOT}/references/html-calendar-template.html`
2. Generate a self-contained HTML content calendar with color-coded content types, weekly grid, and topic details
3. Save to `[output_dir]/YYYY-MM-DD-content-calendar-[business-slug].html` (default `output_dir`: `~/Desktop/`)
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
| "I have enough info to generate topics" | Complete ALL discovery questions first. Capacity and goals drive the calendar. |
| "I'll just list 20 blog topics" | Topics need keyword data, ICE scores, and tier assignments. |
| "The user only wants a few ideas" | Even quick brainstorms get structured output with priorities. |
| "I'll output the calendar as a markdown table" | The calendar IS the HTML report. Terminal gets a summary only. |
| "GBP posts don't need planning" | Batch planning prevents decision fatigue and inconsistency. Plan them. |

---

## Tools to Use

> **Optional MCPs:** ahrefs and dataforseo — user chooses in Phase 1, Step 5. See [references/prerequisites.md](../../references/prerequisites.md).

- **DataForSEO MCP** (if available) — Keyword volumes, SERP data, content gap analysis
- **Ahrefs MCP** (if available) — Organic keywords, content explorer, competitor content
- **WebSearch / WebFetch** — Competitor content analysis, PAA mining, Reddit research
- **GA4 MCP** (if available) — Page performance, session duration, engagement rates. Loaded automatically in Phase 0.5 when client has `ga4_property_id` set.
- **GSC MCP** (if available) — Top queries, page clicks/impressions, content gap data. Loaded automatically in Phase 0.5 when client has `gsc_site_url` set.

## Self-Improvement
- After the user approves final output, offer to save it as an approved example for future reference
- If the user gives explicit negative feedback, offer to add it as a learned rule
- If approved examples exist in references/approved-examples/, review them before generating new output to match established quality
