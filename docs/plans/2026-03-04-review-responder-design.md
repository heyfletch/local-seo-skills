# GBP Review Responder — Design Document

**Date:** 2026-03-04
**Skill name:** `local-seo-review-responder`
**Status:** Approved

## Purpose

Agency-focused skill for crafting authentic, SEO-aware owner responses to individual Google reviews. Generates 3 copy-paste-ready response variations that sound like the actual business owner wrote them — not an AI or agency.

## Scope & Cross-Skill Boundaries

- `local-seo-reviews` = strategy, generation systems, monitoring, reputation management
- `local-seo-review-responder` = tactical response writing for a specific review
- Each skill references the other in its trigger description

## Phase Flow

### Phase 0: Client Context

Standard client profile check (shared across all skills):
- Pull business name, website URL, primary services, service areas if available
- If no client profile, ask for business name and website URL

### Phase 1: Review Intake & Voice Calibration

**Step 1: Review input**
- User pastes the review text, star rating, and reviewer first name (if available)
- Skill analyzes:
  - Star rating (1-5) — determines tone strategy
  - Sentiment — positive, mixed, negative
  - Specific mentions — services, staff, experiences, complaints
  - Risk level — reputation threat or opportunity?
  - Review length/effort — calibrates response length

**Step 2: Owner voice calibration (AskUserQuestion)**

"How should I handle the owner's voice?"

| Option | When shown | Behavior |
|--------|-----------|----------|
| Use existing voice profile | Only if profile exists | Display stored profile, user accepts/edits/refreshes |
| Scan GBP for owner responses | Always | WebFetch GBP listing, extract owner responses, analyze patterns, save profile |
| Paste sample responses | Always | User pastes 2-3 past responses, analyze patterns, save profile |
| Describe the tone/style | Always | User provides brief description, optionally save as profile |
| Skip — use defaults | Always | Anti-AI guidelines only, no owner-specific voice |

**Voice profile storage:** `references/clients/{client}/voice-profile.md`

**Voice profile contents:**
- Greeting style (e.g., "Hey [name]", "Hi there", dives right in)
- Sign-off style (e.g., "— Mike", "The [Business] Team", none)
- Tone markers (formal/casual, humor, emoji usage)
- Common phrases the owner naturally uses
- Punctuation habits
- Example snippets

### Phase 2: Keyword Discovery

1. WebFetch the business website (homepage + services page if identifiable from nav)
2. Extract: service names, service areas/cities, business differentiators, taglines
3. Cross-reference extracted keywords with the review topic — filter to what's contextually relevant
4. Present 5-8 keyword suggestions via AskUserQuestion
5. User picks 1-3 keywords to weave into responses

### Phase 3: Response Generation

Generate 3 labeled variations:

1. **Warm & Personal** — conversational, uses reviewer's name, feels like a friend
2. **Professional & Appreciative** — polished but not corporate, business-owner voice
3. **Brief & Direct** — shortest version, gets the point across efficiently

**Output format:**
- Numbered, clearly separated
- Plain text only (GBP is plain text — no markdown, no formatting)
- Ready to copy-paste directly into Google Business Profile

## Anti-AI Detection & Voice Guidelines

### Banned Phrases (never use)
- "We truly value your feedback"
- "Your feedback means the world to us"
- "We strive to provide the best..."
- "We are committed to excellence"
- "We apologize for any inconvenience"
- Any variation of corporate-speak platitudes

### Formatting Rules
- Never use em dashes (--)
- Use contractions ("We're glad" not "We are glad")
- One imperfect touch per response — a dash, ellipsis, or sentence fragment
- No exclamation points on every sentence

### Content Rules
- No gender pronouns for the reviewer (use first name or "you/your")
- Reference a specific detail from the review to prove it was read
- Vary openers across all 3 variations (not all start with "Thanks")
- Match review energy — casual review = casual response
- For negative reviews: empathize, take ownership, move to private resolution
- Never promise discounts/freebies publicly
- Include a subtle CTA where appropriate ("...next time you need [service]")

### Keyword Injection Rules
- Max 1-2 selected keywords per response
- Must feel like the owner naturally mentioning their work
- Good: "Glad the deck came out great -- cedar's always a solid choice for [City] weather"
- Bad: "Thank you for choosing our deck building services in [City]"

### Response Length Guidelines

| Review Type | Target Length |
|---|---|
| 1-2 words ("Great!") | 1-2 sentences |
| 1-2 sentences | 2-3 sentences |
| Paragraph | 3-5 sentences |
| Multi-paragraph | 4-6 sentences (don't over-match length) |
| Negative, detailed | 4-7 sentences (empathy + resolution) |

## Tools

- **WebFetch** — website scanning for keyword extraction, GBP reading for voice profiles
- **WebSearch** — fallback for business discovery
- **AskUserQuestion** — keyword selection, voice calibration options

## File Structure

```
skills/local-seo-review-responder/
  SKILL.md                    # Process/SOP steps only
  references/
    anti-ai-guidelines.md     # Banned phrases, voice rules, length guidelines
    keyword-injection.md      # How to naturally weave keywords
    voice-profile-template.md # Template for voice profiles
```

## Decisions Made

| Decision | Choice | Rationale |
|----------|--------|-----------|
| New skill vs extend existing | New standalone | Keeps reviews skill focused on strategy; this is tactical |
| Review input method | User pastes text | Simple, reliable, no API fragility |
| Keyword source | Scan business website | Lightweight, no API costs, extracts real services/locations |
| Number of variations | 3 with brief labels | Enough choice without overwhelming |
| Batch mode | One review at a time | Quality over throughput |
| Skill flow | Review-first, keywords after | More natural — user comes in with a review to respond to |
| Voice profiles | Persistent per-client | Avoids re-calibrating every time; supports agency workflow |
| Data tools (Ahrefs/DataForSEO) | Not used | Overkill for review responses; website scan is sufficient |
