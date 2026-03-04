# GBP Review Responder Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Create a new `local-seo-review-responder` skill that generates 3 copy-paste-ready owner responses to individual Google reviews, with natural keyword injection and owner voice matching.

**Architecture:** New standalone skill following the plugin's standard phase structure (0-3.5). Reference files hold anti-AI guidelines, keyword injection rules, and a voice profile template. The skill reads the business website to extract keywords, optionally scans GBP or accepts sample responses for voice calibration, and outputs 3 plain-text response variations.

**Tech Stack:** Claude Code skill (SKILL.md + references/), WebFetch for website/GBP scanning, AskUserQuestion for keyword selection and voice options.

**Design doc:** `docs/plans/2026-03-04-review-responder-design.md`

---

### Task 1: Create the skill directory and SKILL.md

**Files:**
- Create: `skills/local-seo-review-responder/SKILL.md`

**Step 1: Create the directory**

```bash
mkdir -p skills/local-seo-review-responder/references
```

**Step 2: Write SKILL.md**

Write the following to `skills/local-seo-review-responder/SKILL.md`:

```markdown
---
name: local-seo-review-responder
description: This skill should be used when the user asks to "respond to a review", "draft a review response", "reply to this Google review", "write a response for this review", "help me answer this review", "owner response to review", or any request to craft an owner reply to a customer review on Google Business Profile. This skill generates copy-paste-ready responses with natural keyword injection and owner voice matching. For review generation strategy, monitoring, or reputation management, use the local-seo-reviews skill instead.
---

# GBP Review Responder

## Iron Law

EVERY RESPONSE MUST SOUND LIKE THE BUSINESS OWNER WROTE IT, NOT AN AI OR AGENCY. If a response reads like corporate template copy, it fails. Reference specifics from the review. Match the review's energy. Never stuff keywords.

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
```

**Step 3: Commit**

```bash
git add skills/local-seo-review-responder/SKILL.md
git commit -m "feat: add review-responder SKILL.md"
```

---

### Task 2: Create anti-ai-guidelines.md reference file

**Files:**
- Create: `skills/local-seo-review-responder/references/anti-ai-guidelines.md`

**Step 1: Write the file**

Write the following to `skills/local-seo-review-responder/references/anti-ai-guidelines.md`:

```markdown
# Anti-AI Detection & Voice Guidelines

## Banned Phrases

Never use any of these in a review response:

- "We truly value your feedback"
- "Your feedback means the world to us"
- "We strive to provide the best..."
- "We are committed to excellence"
- "We apologize for any inconvenience"
- "Thank you so much for taking the time"
- "Your satisfaction is our top priority"
- "We pride ourselves on..."
- "It was our pleasure to serve you"
- "We look forward to serving you again"
- "Your kind words mean a lot"
- "We are thrilled to hear..."
- "Rest assured..."

Any phrase that sounds like it came from a customer service training manual is banned.

## Formatting Rules

- Never use em dashes (--). Use commas, periods, or regular hyphens (-) instead.
- Use contractions. "We're glad" not "We are glad." "Didn't" not "did not."
- One imperfect touch per response -- a sentence fragment, a casual aside, a trailing thought. Something that feels human.
- No exclamation points on every sentence. One per response max, and only if the review's energy warrants it.
- No bullet points or lists in responses. Write in natural sentences.
- No quotation marks around the reviewer's words (looks like you're annotating, not responding).

## Content Rules

- No gender pronouns for the reviewer. Use first name or "you/your" only.
- Reference a specific detail from the review to prove it was actually read. Not the general topic, but a particular thing they said.
- Vary openers across all 3 variations. Not all start with "Thanks" or "Hey" or "Hi."
- Match the review's energy. Casual review = casual response. Formal review = slightly more polished.
- For negative reviews: empathize, take ownership where appropriate, invite private resolution. Do not be defensive. Do not explain at length why the problem happened.
- Never promise discounts, freebies, or compensation publicly. Take that offline.
- Include a subtle CTA where appropriate and natural ("...next time you need [service]", "...if anything comes up with the [project]"). Not every response needs one.
- Never use the business's full formal name repeatedly. Use it once if at all. The owner would just say "we" or "our team."

## Response Length Guidelines

| Review Type | Target Length |
|---|---|
| 1-2 words ("Great!") | 1-2 sentences |
| 1-2 sentences | 2-3 sentences |
| One paragraph | 3-5 sentences |
| Multi-paragraph | 4-6 sentences (don't over-match length) |
| Negative, detailed | 4-7 sentences (empathy + resolution path) |

## Voice Profile Application

When a voice profile is loaded, layer it on top of these baseline rules:

- Match the owner's greeting style exactly
- Match the owner's sign-off style exactly
- Mirror their sentence length patterns
- Use their common phrases where natural
- Match their punctuation habits (but never add em dashes regardless)
- If the owner uses casual language, lean casual. If professional, lean professional.

The voice profile overrides the default tone but never overrides the banned phrases or formatting rules above.
```

**Step 2: Commit**

```bash
git add skills/local-seo-review-responder/references/anti-ai-guidelines.md
git commit -m "feat: add anti-AI detection guidelines reference"
```

---

### Task 3: Create keyword-injection.md reference file

**Files:**
- Create: `skills/local-seo-review-responder/references/keyword-injection.md`

**Step 1: Write the file**

Write the following to `skills/local-seo-review-responder/references/keyword-injection.md`:

```markdown
# Keyword Injection Rules

## Core Principle

Keywords must be invisible. If a reader could highlight a phrase and say "that's an SEO keyword," the injection failed. The owner would naturally mention their work and their city -- that's all this is.

## Injection Limits

- Maximum 1-2 keywords per response
- Never use the same keyword placement pattern across all 3 variations
- If a keyword can't be inserted naturally, skip it entirely
- Service keywords and location keywords should not appear in the same sentence

## Natural Injection Patterns

### Service Keywords

**Good -- owner naturally references their work:**
- "Glad the deck came out great -- cedar's always a solid choice"
- "Plumbing emergencies are stressful, so I'm glad we could get there fast"
- "Roof repairs in this weather can be tricky but yours turned out solid"

**Bad -- reads like SEO copy:**
- "Thank you for choosing our deck building services"
- "As a leading plumbing company, we strive to..."
- "Our roof repair team is dedicated to..."

### Location Keywords

**Good -- owner mentions the area naturally:**
- "Portland weather keeps us busy this time of year"
- "We love working in the North Shore area"
- "That neighborhood has some of the best older homes to work on"

**Bad -- forced geographic insertion:**
- "Thank you for being a valued customer in Portland, OR"
- "We serve the entire North Shore region with pride"
- "As Portland's premier roofing company..."

### Differentiator Keywords

**Good -- comes up in context:**
- "25 years and we still get excited about projects like yours"
- "Being family-owned means every job feels personal to us"

**Bad -- sounds like a tagline:**
- "As a family-owned business with 25 years of experience..."

## Where to Place Keywords

Best positions for natural keyword insertion:
1. **Mid-response** -- embedded in a conversational sentence, never the opener
2. **In a specific reference** -- tied to something the reviewer actually mentioned
3. **In the CTA/closer** -- "...next time you need [service keyword]"

Worst positions:
1. Opening sentence (looks templated)
2. Standalone sentence that only exists for the keyword
3. Sign-off line

## Review-Keyword Matching

Only inject keywords that relate to what the reviewer discussed:
- Reviewer mentions a specific service → use that service keyword
- Reviewer mentions the area/city → use that location keyword
- Reviewer mentions nothing specific → use at most one subtle keyword or skip injection entirely

Never inject a keyword for a service the reviewer didn't use or reference.
```

**Step 2: Commit**

```bash
git add skills/local-seo-review-responder/references/keyword-injection.md
git commit -m "feat: add keyword injection rules reference"
```

---

### Task 4: Create voice-profile-template.md reference file

**Files:**
- Create: `skills/local-seo-review-responder/references/voice-profile-template.md`

**Step 1: Write the file**

Write the following to `skills/local-seo-review-responder/references/voice-profile-template.md`:

```markdown
# Voice Profile Template

Use this template when creating or updating an owner voice profile. Fill in each section based on analysis of the owner's past review responses.

---

## Greeting Style

How the owner typically starts responses:
- Example: "Hey [name]", "Hi [name]!", "Thanks [name]", starts without greeting
- Pattern: [describe]

## Sign-Off Style

How the owner typically ends responses:
- Example: "- Mike", "-- The ABC Team", "Thanks again!", no sign-off
- Pattern: [describe]

## Tone

- Overall: [casual / friendly-professional / formal / warm / matter-of-fact]
- Uses humor: [yes - describe style / occasionally / no]
- Uses emoji: [yes - which ones / no]
- Energy level: [enthusiastic / calm / understated]

## Sentence Patterns

- Average sentence length: [short and punchy / medium / longer flowing sentences]
- Uses fragments: [yes / no]
- Punctuation habits: [lots of exclamation points / minimal / uses ellipsis / uses dashes]

## Common Phrases

Words or phrases the owner uses repeatedly across responses:
- [phrase 1]
- [phrase 2]
- [phrase 3]

## Example Snippets

2-3 short excerpts from actual owner responses that capture the voice:

> [snippet 1]

> [snippet 2]

> [snippet 3]

---

*Generated from [source: GBP scan / pasted samples / manual description] on [date]*
```

**Step 2: Commit**

```bash
git add skills/local-seo-review-responder/references/voice-profile-template.md
git commit -m "feat: add voice profile template reference"
```

---

### Task 5: Update plugin.json

**Files:**
- Modify: `.claude-plugin/plugin.json`

**Step 1: Update version and description**

Edit `.claude-plugin/plugin.json`:
- Bump version from `"1.1.0"` to `"1.2.0"`
- Update description to mention the new skill count: change "10 specialized skills" to "11 specialized skills" and add "review response generation" to the list
- Add `"review-response"` to the keywords array

**Step 2: Commit**

```bash
git add .claude-plugin/plugin.json
git commit -m "feat: bump to 1.2.0, add review-responder to plugin metadata"
```

---

### Task 6: Update local-seo-reviews to cross-reference the new skill

**Files:**
- Modify: `skills/local-seo-reviews/SKILL.md`

**Step 1: Update the description frontmatter**

In the `description` field of the YAML frontmatter, append: `For drafting individual review responses with keyword injection and voice matching, use the local-seo-review-responder skill.`

**Step 2: Update Phase 1 Step 1**

In Phase 1, Step 1 ("Identify the need"), add a note after the "Respond to a specific review" option:

```
> **Note:** For a more advanced response with keyword injection, voice matching, and 3 response variations, suggest the user try the `local-seo-review-responder` skill instead.
```

**Step 3: Commit**

```bash
git add skills/local-seo-reviews/SKILL.md
git commit -m "feat: cross-reference review-responder from reviews skill"
```

---

### Task 7: Verify the full skill structure

**Step 1: Verify file tree**

```bash
find skills/local-seo-review-responder -type f | sort
```

Expected output:
```
skills/local-seo-review-responder/SKILL.md
skills/local-seo-review-responder/references/anti-ai-guidelines.md
skills/local-seo-review-responder/references/keyword-injection.md
skills/local-seo-review-responder/references/voice-profile-template.md
```

**Step 2: Verify SKILL.md frontmatter**

Read `skills/local-seo-review-responder/SKILL.md` and confirm:
- `name: local-seo-review-responder`
- `description:` field contains trigger phrases
- All `${CLAUDE_PLUGIN_ROOT}` references point to correct paths
- All phase gates are present (Phase 1, 2, 3)
- Reference file paths in Step 1 of Phase 3 are correct

**Step 3: Verify plugin.json**

Read `.claude-plugin/plugin.json` and confirm:
- Version is `1.2.0`
- Description mentions 11 skills

**Step 4: Verify cross-reference in reviews skill**

Read `skills/local-seo-reviews/SKILL.md` and confirm the description mentions `local-seo-review-responder`.

**Step 5: Run git status and log**

```bash
git status && git log --oneline -6
```

Expected: clean working tree, 6 new commits for tasks 1-6.
