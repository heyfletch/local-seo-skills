---
name: local-seo-gbp
description: This skill should be used when the user asks to "optimize my GBP", "create GBP posts", "write Google Business Profile posts", "set up Q&A on my profile", "improve my Google Maps listing", "Google My Business optimization", "GMB optimization", "my Google listing", "Maps ranking", "map pack rankings", "local pack visibility", or any standalone Google Business Profile or Google Maps work. This skill writes actual GBP posts and optimizes the profile directly. For GBP evaluation as part of a full site audit, use the local-seo-audit skill. For scheduling GBP posts on a calendar, use the local-seo-content skill.
---

# Local SEO — Google Business Profile Skill

## Iron Law

NO GBP OUTPUT WITHOUT COMPLETING ALL FOUR PHASES. GBP drives 32% of local pack ranking weight. Do not dump checklists or post ideas into the terminal. Identify what the user needs, execute it, and produce a saved deliverable.

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
DO NOT proceed to Phase 2 until the business and GBP task are identified.
</HARD-GATE>

### Step 1: Identify the business

Use AskUserQuestion:

**Question:** "What business is this GBP work for?"
- Options: "I'll provide a business name + city", "I'll provide a GBP URL", "Both"

### Step 2: Determine the task

Use AskUserQuestion:

**Question:** "What GBP work do you need?"
- "Full GBP optimization audit and checklist"
- "Create a month of GBP posts"
- "Set up Q&A strategy with seed questions"
- "All of the above"

### Step 3: Auto-discover

Use WebSearch to research the business's current GBP presence, competitors' GBP profiles, and industry-specific GBP features. Present findings and ask the user to confirm via AskUserQuestion.

### Step 4: Data tools

Use AskUserQuestion:

**Question:** "Do you want to use enhanced data tools for GBP research?"
- "Yes — use Ahrefs and DataForSEO"
- "Just DataForSEO (Maps rankings, GBP data)"
- "No — WebSearch is fine"

For each selected tool, verify the MCP is responding. If it fails, inform the user and offer setup help or fall back to WebSearch. See [references/prerequisites.md](../../references/prerequisites.md).

---

## Phase 2: Execute

Based on the selected task, read the relevant reference file and execute:

### For optimization audit:
Read `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-gbp/references/gbp-optimization-checklist.md`.

Create TaskCreate items for each checklist section:
- Profile foundation
- Predefined services
- Photos & video
- "Open Now" optimization
- Map pin verification
- Messaging setup
- Multi-location (if applicable)
- LSA considerations (if applicable)

### For GBP posting:
Read `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-gbp/references/gbp-posting-strategy.md`.

Create TaskCreate items for:
- Monthly goal and theme assignment
- Post batch generation (12-16 posts)
- Image suggestions for each post
- Schedule assignment

### For Q&A strategy:
Read the Q&A section from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-gbp/references/gbp-posting-strategy.md`.

Create TaskCreate items for:
- Seed question generation (5-10 questions)
- Answer drafting with keywords
- Monitoring process setup

---

## Phase 3: Compile Results

Organize all findings, posts, or checklists into a structured format ready for report generation.

---

## Phase 4: Output

<HARD-GATE>
DO NOT skip output. ALWAYS produce an HTML deliverable. Do not dump checklists or posts into the terminal.
</HARD-GATE>

### For optimization audit:
1. Read the HTML report template at `${CLAUDE_PLUGIN_ROOT}/references/html-report-template.html`
2. Generate an HTML checklist report with current status and action items
3. Save to `[output_dir]/YYYY-MM-DD-gbp-audit-[business-slug].html` (default `output_dir`: `~/Desktop/`)

### For GBP posting calendar:
1. Read the HTML calendar template at `${CLAUDE_PLUGIN_ROOT}/references/html-calendar-template.html`
2. Generate an HTML calendar with all posts, dates, CTAs, and image suggestions
3. Save to `[output_dir]/YYYY-MM-DD-gbp-calendar-[business-slug].html` (default `output_dir`: `~/Desktop/`)

### For all outputs:
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
| "I'll just list the checklist items" | The checklist goes in an HTML report, not the terminal. |
| "I'll write a few sample posts" | Generate the full month of posts with dates, CTAs, and images. |
| "The user just needs a quick answer about GBP" | Even quick GBP guidance should produce a saved reference document. |
| "Q&A doesn't need a strategy" | Seeded Q&A with keywords is a ranking factor. Plan it properly. |
| "I'll skip the automation section" | Mention automation opportunities — it's a major value-add for agency clients. |

---

## Tools to Use

> **Optional MCPs:** ahrefs and dataforseo — user chooses in Phase 1, Step 4. See [references/prerequisites.md](../../references/prerequisites.md).

- **DataForSEO MCP** (if available) — Google Maps rankings, GBP data, competitor GBP analysis
- **WebSearch / WebFetch** — Research business GBP, competitor profiles, industry-specific GBP features

## Self-Improvement
- After the user approves final output, offer to save it as an approved example for future reference
- If the user gives explicit negative feedback, offer to add it as a learned rule
- If approved examples exist in references/approved-examples/, review them before generating new output to match established quality
