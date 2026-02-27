---
name: local-seo-agency
description: This skill should be used when the user asks about the BUSINESS side of local SEO — "how much should I charge for SEO", "how to sell SEO services", "SEO agency pricing", "local SEO packages", "how to get SEO clients", "starting an SEO agency", "client onboarding", "creating SOPs", "building a team", "productizing SEO", "SEO proposals", "client retention", or any question about running, packaging, pricing, selling, or delivering SEO as a business. This skill is about running an SEO agency or freelance practice, NOT about executing SEO work for a specific client — for that, use the other local-seo skills (audit, plan, service-page, etc.).
---

# Local SEO Agency Skill

## Iron Law

NO ADVICE WITHOUT UNDERSTANDING CONTEXT. Do not dump all agency knowledge at once. Identify what the user actually needs, deliver targeted guidance, and produce an actionable output document.

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
DO NOT proceed to Phase 2 until the user's agency context and specific need are identified.
</HARD-GATE>

### Step 1: Identify the need

Use AskUserQuestion:

**Question:** "What aspect of running your SEO agency/freelance practice do you need help with?"
- "Packaging & pricing my services"
- "Sales process & getting clients"
- "Delivery system & SOPs"
- "Team building & scaling"

### Step 2: Determine experience level

Use AskUserQuestion:

**Question:** "Where are you in your agency journey?"
- "Pre-launch — haven't sold SEO yet"
- "Early stage — 1-5 clients"
- "Growing — 5-15 clients"
- "Scaling — 15+ clients"

### Step 3: Gather specifics

Based on the selected topic, ask ONE follow-up question via AskUserQuestion to narrow the guidance:

- **Packaging & pricing:** "Do you want to offer one-time projects, monthly retainers, or both?"
- **Sales & leads:** "What's your primary lead source right now?" (referrals / cold outreach / content / none yet)
- **Delivery & SOPs:** "What's your biggest delivery bottleneck?" (client onboarding / content creation / reporting / all of it)
- **Team & scaling:** "What's your first hire priority?" (SEO assistant / account manager / content writer / not sure)

---

## Phase 2: Contextual Guidance

Read the relevant reference file based on the user's need:

- **Packaging & pricing:** Read `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-agency/references/agency-service-models.md`
- **Sales, leads, delivery, SOPs, team, scaling:** Read `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-agency/references/agency-operations.md`

Deliver focused guidance for the user's specific situation. Do NOT dump the entire reference file — select the relevant sections and adapt the advice to their experience level and context.

Create TaskCreate items for multi-step advice (e.g., "Build a pricing structure", "Create client onboarding SOP").

---

## Phase 3: Action Plan

Synthesize guidance into a concrete, prioritized action plan:
- 3-5 immediate next steps
- Timeline for each step
- Resources or templates needed
- Metrics to track progress

---

## Phase 4: Output

<HARD-GATE>
DO NOT skip output generation. Produce a tangible deliverable the user can reference later.
</HARD-GATE>

1. Read the HTML report template at `${CLAUDE_PLUGIN_ROOT}/references/html-report-template.html`
2. Generate an HTML document with the guidance, action plan, and any templates/frameworks discussed
3. Save to `[output_dir]/YYYY-MM-DD-agency-[topic-slug].html` (default `output_dir`: `~/Desktop/`)
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
| "I'll cover all agency topics comprehensively" | Focus on what they asked. Dumping everything overwhelms. |
| "They need to know all three service models" | Only explain models relevant to their stage and goals. |
| "I'll just answer their question conversationally" | Produce a saved deliverable they can reference. |
| "Pricing advice doesn't need a report" | A pricing framework document is a high-value deliverable. Always save it. |
| "They're early stage, so keep it simple" | Early stage needs clarity, not simplification. Give them the real framework. |

---

## Tools to Use

- **WebSearch** — Research competitor agencies, pricing benchmarks, industry data
- **WebFetch** — Pull live examples of agency pricing pages, proposal templates

## Self-Improvement
- After the user approves final output, offer to save it as an approved example for future reference
- If the user gives explicit negative feedback, offer to add it as a learned rule
- If approved examples exist in references/approved-examples/, review them before generating new output to match established quality
