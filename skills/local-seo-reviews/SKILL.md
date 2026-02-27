---
name: local-seo-reviews
description: This skill should be used when the user asks to "get more reviews", "respond to this review", "build a review generation system", "handle a negative review", "improve my star rating", "set up review monitoring", "review request template", "reputation management", "how to get more Google reviews", "what should I do about my bad reviews", or any review strategy, response drafting, or monitoring setup for a local business.
---

# Local SEO Reviews Skill

## Iron Law

NO REVIEW ADVICE WITHOUT UNDERSTANDING THE CONTEXT. Reviews account for 20% of local pack ranking and 16% of AI search visibility. Identify what the user needs, deliver targeted guidance, and produce a saved deliverable.

---

## Settings

Before starting Phase 1, check if `.claude/local-seo.local.md` exists. If it does, read it and extract settings from the YAML frontmatter:

- `output_dir` — directory for saving reports/pages (default: `~/Desktop/`)
- `auto_open` — whether to auto-open files in browser (default: `true`)

Use these values in the output phase. If the file doesn't exist, use defaults.

---

## Phase 1: Discovery

<HARD-GATE>
DO NOT proceed to Phase 2 until the business context and specific review need are identified.
</HARD-GATE>

### Step 1: Identify the need

Use AskUserQuestion:

**Question:** "What review help do you need?"
- "Build a review generation system (get more reviews)"
- "Respond to a specific review"
- "Set up review monitoring"
- "Full review strategy (generation + monitoring + response system)"

### Step 2: Gather context

Based on the selected task, use AskUserQuestion:

**For generation system:**
**Question:** "What's your current review situation?"
- "Starting from zero (few or no reviews)"
- "Some reviews but inconsistent (no system)"
- "Decent reviews but need more volume/velocity"
- "Strong reviews — need to maintain momentum"

**For responding to a review:**
**Question:** "What type of review are you responding to?"
- "5-star positive review"
- "4-star mostly positive"
- "3-star neutral/mixed"
- "1-2 star negative review"

Then ask the user to paste the review text.

**For monitoring setup:**
**Question:** "How do you currently monitor reviews?"
- "I don't — I just check occasionally"
- "Manual daily/weekly checks"
- "I want to set up automation"

---

## Phase 2: Execute

Based on the selected task, read the relevant reference file and execute:

### For generation system:
Read `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-reviews/references/review-strategy.md`.

Create TaskCreate items for:
- Review health benchmark assessment
- Generation method selection (in-person, SMS, email, physical)
- Request template customization
- Timing and workflow design
- Platform priority assignment

### For responding to a review:
Read `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-reviews/references/review-templates.md`.

1. Select the appropriate response template based on star rating
2. Customize with specific details from the review
3. Apply the response rules (reference specifics, take negatives offline, no defensiveness)
4. Draft 2-3 response options for the user to choose from

### For monitoring setup:
Read the monitoring section from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-reviews/references/review-strategy.md`.

Create TaskCreate items for:
- Platform inventory (which platforms to monitor)
- Manual process setup (tracking spreadsheet, schedule)
- Automation workflow design (n8n if applicable)

### For full strategy:
Execute all three sections above.

---

## Phase 3: Output

<HARD-GATE>
DO NOT skip output. Produce a saved deliverable for non-trivial outputs.
</HARD-GATE>

### For generation system or full strategy:
1. Read the HTML report template at `${CLAUDE_PLUGIN_ROOT}/references/html-report-template.html`
2. Generate an HTML document with the complete review strategy, templates, and monitoring plan
3. Save to `[output_dir]/YYYY-MM-DD-review-strategy-[business-slug].html` (default `output_dir`: `~/Desktop/`)
4. If `auto_open` is true (default), run `open [filepath]` via Bash to auto-open in browser
5. Print to terminal ONLY: 3-5 bullet summary + file path

### For responding to a specific review:
Print the 2-3 response options directly to the terminal (review responses are short, immediate-use content — no report needed). Offer to save them to a file if the user wants a response template library.

### For monitoring setup:
Include the monitoring plan in the HTML strategy document or generate a standalone checklist.

---

## Red Flags

| Thought | Reality |
|---|---|
| "I'll just share the request templates" | Customize templates for the specific business and service. Generic templates feel generic to customers too. |
| "The user just needs a quick response draft" | Draft 2-3 options so they can choose the best tone. Reference specific review details. |
| "Review monitoring is straightforward" | Set up the full system: platforms, frequency, escalation rules, automation. |
| "I'll cover all review topics" | Focus on what they asked. A generation system is different from a response strategy. |
| "Negative reviews need a long apology" | Keep it brief, empathetic, and take it offline. Long public responses look defensive. |

---

## Tools to Use

- **WebSearch** — Research business review profiles across platforms, competitor review counts
- **WebFetch** — Check current GBP review count and rating, competitor review data

## Self-Improvement
- After the user approves final output, offer to save it as an approved example for future reference
- If the user gives explicit negative feedback, offer to add it as a learned rule
- If approved examples exist in references/approved-examples/, review them before generating new output to match established quality
