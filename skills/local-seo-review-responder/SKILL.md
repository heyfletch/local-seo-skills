---
name: local-seo-review-responder
description: This skill should be used when the user asks to "respond to a review", "draft a review response", "reply to this Google review", "write a response for this review", "help me answer this review", "owner response to review", or any request to craft an owner reply to a customer review on Google Business Profile. This skill generates copy-paste-ready responses with natural keyword injection and owner voice matching. For review generation strategy, monitoring, or reputation management, use the local-seo-reviews skill instead.
---

# GBP Review Responder

## Iron Law

EVERY RESPONSE MUST SOUND LIKE THE BUSINESS OWNER WROTE IT, NOT AN AI OR AGENCY. If a response reads like corporate template copy, it fails. Reference specifics from the review. Match the review's energy. Never stuff keywords.

Follow [references/ask-user-question-conventions.md](../../references/ask-user-question-conventions.md) for all AskUserQuestion prompts.

---

## Settings

Before starting Phase 1, check if `.claude/local-seo.local.md` exists. If it does, read it and extract settings from the YAML frontmatter:

- `output_dir` -- directory for saving reports/pages (default: `~/Desktop/`)
- `auto_open` -- whether to auto-open files in browser (default: `true`)

Use these values in the output phase. If the file doesn't exist, use defaults.

---

## Phase 0: Client Context

Follow the instructions in [references/client-context-phases.md](../../references/client-context-phases.md) -- Phase 0 section.

This determines whether the skill runs in **quick mode** or **deliverable mode** (with client profile pre-loaded).

If client context is loaded:
- Phase 1 Steps 1-2 are skipped (business already identified)
- Business name, website, GBP URL, services, and service areas are pre-populated
- Check if a voice profile exists at `[client-path]/voice-profile.md`

---

## Phase 1: Review Intake & Voice Calibration

<HARD-GATE>
DO NOT proceed to Phase 2 until the review text is provided AND voice calibration is complete.
</HARD-GATE>

### Step 1: Identify the business

If no client context loaded, ask for:
- Business name
- Business website URL

### Step 2: Get the review

Ask the user to paste the review, including:
- Star rating (1-5)
- Reviewer first name (if visible)
- Full review text

### Step 3: Analyze the review

Silently analyze (do not output this analysis to the user):
- **Star rating** -- determines tone strategy
- **Sentiment** -- positive, mixed, negative
- **Specific mentions** -- services, staff, experiences, complaints
- **Risk level** -- reputation threat or opportunity?
- **Review length** -- calibrates response length (see anti-ai-guidelines.md)

### Step 4: Voice calibration

Check if a voice profile exists:
- If client context loaded: check `[client-path]/voice-profile.md`
- If quick mode: no existing profile

Use AskUserQuestion:

**Question:** "How should I match the owner's voice?"

Options shown depend on whether a profile exists:

**If voice profile exists:**
- "Use existing voice profile" -- display the stored profile summary, user accepts or edits
- "Update voice profile from recent GBP responses" -- WebFetch GBP, analyze recent owner responses, update profile
- "Scan GBP for owner responses" -- (same as above but clearer for first-time updaters)
- "Skip -- use defaults"

**If no voice profile:**
- "Scan GBP for owner responses" -- WebFetch GBP listing, extract owner responses, analyze greeting style / sign-off / tone / common phrases / punctuation, generate voice profile, save it
- "Paste sample owner responses" -- user pastes 2-3 past responses, same analysis, save profile
- "Describe the tone/style" -- user provides brief description (e.g., "casual, signs off with -- Mike"), optionally save
- "Skip -- use defaults" -- anti-AI guidelines only, no owner-specific voice

When "Use existing voice profile" is selected, display the profile contents and ask:

**Question:** "This is the current voice profile. Accept or revise?"
- "Looks good, use it"
- "Revise -- scan GBP for recent responses to update"
- "Revise -- let me edit it manually"

Save new/updated voice profiles to:
- Client mode: `[client-path]/voice-profile.md`
- Quick mode: do not save (session only)

---

## Phase 2: Keyword Discovery

<HARD-GATE>
DO NOT skip keyword discovery. The SEO value-add is what differentiates this from a generic response tool.
</HARD-GATE>

### Step 1: Scan the business website

Use WebFetch on the business website URL (homepage). Look for:
- Navigation links to identify service pages and area pages
- Service names and descriptions
- Service areas / cities served
- Business differentiators, taglines, specialties

If identifiable from the homepage nav, also WebFetch the main services page or "areas we serve" page.

### Step 2: Extract keyword candidates

From the website scan, compile:
- Service keywords (e.g., "roof repair", "kitchen remodeling", "teeth whitening")
- Location keywords (e.g., "Portland", "North Shore", "Greater Houston area")
- Differentiators (e.g., "family-owned", "25 years experience", "same-day service")

### Step 3: Filter to review context

Cross-reference extracted keywords with what the reviewer mentioned. Prioritize keywords that are contextually relevant to the review topic.

### Step 4: Present keyword options

Use AskUserQuestion (multiSelect):

**Question:** "Which keywords should I naturally weave into the response? Pick 1-3."

Show 5-8 filtered keywords. Include a note: "These will be woven in naturally, not stuffed. Max 1-2 per response."

---

## Phase 3: Response Generation

<HARD-GATE>
DO NOT output responses without reading the anti-AI guidelines and keyword injection rules first.
</HARD-GATE>

### Step 1: Read reference files

Read:
- `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-review-responder/references/anti-ai-guidelines.md`
- `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-review-responder/references/keyword-injection.md`

### Step 2: Generate 3 response variations

Apply all anti-AI guidelines, the owner's voice profile (if available), and keyword injection rules.

Generate exactly 3 variations:

1. **Warm & Personal** -- conversational, uses reviewer's name, feels like a friend
2. **Professional & Appreciative** -- polished but not corporate, business-owner voice
3. **Brief & Direct** -- shortest version, gets the point across efficiently

### Step 3: Output

Print the 3 responses directly to terminal. Format:

```
---
**1. Warm & Personal**

[response text -- plain text, no markdown formatting]

---
**2. Professional & Appreciative**

[response text -- plain text, no markdown formatting]

---
**3. Brief & Direct**

[response text -- plain text, no markdown formatting]

---
```

Each response must be plain text (no markdown, no HTML) since it will be pasted into GBP.

After displaying, ask: "Copy your preferred response and paste it into GBP. Want me to adjust any of these?"

---

## Phase 3.5: Client Profile Update

Follow the instructions in [references/client-context-phases.md](../../references/client-context-phases.md) -- Phase 3.5 section.

Only runs when client context is active. Offers to update the work log.

---

## Red Flags

| Thought | Reality |
|---|---|
| "I'll just draft a quick response without scanning the website" | The keyword injection is the value-add. Always scan. |
| "This positive review is simple, no need for voice calibration" | Even simple responses reveal AI patterns. Calibrate every time. |
| "I'll include 3-4 keywords in each response" | Max 1-2. More than that and it reads like SEO spam. |
| "The reviewer used she/her so I can too" | Never assume gender. Use first name or you/your only. |
| "I'll add an em dash for style" | Never use em dashes. Use commas, periods, or regular hyphens. |
| "This negative review needs a long, detailed response" | Keep it empathetic and brief. Take it offline. Long public responses look defensive. |
| "I'll start all three responses with Thank you" | Vary openers across all 3 variations. |

---

## Tools to Use

- **WebFetch** -- scan business website for keywords, scan GBP for owner responses and voice calibration
- **WebSearch** -- fallback if website URL is unknown or WebFetch fails
- **AskUserQuestion** -- voice calibration options, keyword selection

---

## Self-Improvement
- After the user approves final output, offer to save it as an approved example for future reference
- If the user gives explicit negative feedback, offer to add it as a learned rule
- If approved examples exist in references/approved-examples/, review them before generating new output to match established quality
