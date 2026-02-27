---
name: local-seo-service-page
description: This skill should be used when the user asks to "write a service page", "create a page for [service]", "optimize my services page", "build a landing page for [service]", or any page targeting "[service] [location]" keywords. Covers content generation, on-page SEO, FAQs, and schema markup for individual service offering pages. Schema markup is generated as part of the page — for standalone schema generation without a full page, use the local-seo-schema skill instead.
---

# Local SEO Service Page Builder

## Iron Law

NO PAGE OUTPUT WITHOUT COMPLETING ALL FOUR PHASES. Do not skip research. Do not generate content without keyword targeting. Each service MUST have its own dedicated page — never combine multiple services on one page.

---

## Settings

Before starting Phase 1, check if `.claude/local-seo.local.md` exists. If it does, read it and extract settings from the YAML frontmatter:

- `output_dir` — directory for saving reports/pages (default: `~/Desktop/`)
- `auto_open` — whether to auto-open files in browser (default: `true`)

Use these values in the output phase. If the file doesn't exist, use defaults.

---

## Phase 1: Discovery

<HARD-GATE>
DO NOT proceed to Phase 2 until the business, service, and target keywords are confirmed.
</HARD-GATE>

### Step 1: Identify the service

Use AskUserQuestion:

**Question:** "What service and business is this page for?"
- Options: "I'll describe the service", "I'll provide a URL to an existing page to optimize", "I'll provide both"

### Step 2: Auto-discover and research

Use WebSearch to research: the business website, competitor pages for this service keyword, common questions about the service. Present findings and propose a target keyword + secondary keywords via AskUserQuestion for confirmation.

### Step 3: Gather differentiators

Use AskUserQuestion for each (skip any already answered):

**Question:** "What makes your [service] different from competitors?"
- "Unique process or approach"
- "Pricing advantage"
- "Experience / credentials"
- "I'm not sure — help me find differentiators"

**Question:** "What CTA do you want on this page?"
- "Phone call"
- "Online booking / scheduling"
- "Contact form submission"
- "Multiple options"

### Information needed (discover via research, only ask user if undiscoverable)
- Business name and location(s)
- Service name and description
- Target keyword and secondary keywords
- Unique selling points (3-4 specific differentiators)
- Service process (step-by-step)
- Pricing info (specific, range, or "contact for quote")
- Common questions/objections
- Testimonials related to this service
- Service area/cities served
- Desired CTA

---

## Phase 2: Research

Read the differentiation guide from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-service-page/references/service-page-differentiation.md`.

1. Analyze top 3-5 competitor pages for the target keyword
2. Identify content gaps — what competitors don't cover
3. Research PAA questions for the service keyword
4. Identify LLM sub-query attributes to include for AI discoverability
5. Note competitor schema markup usage

---

## Phase 3: Content Generation

Read the page template from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-service-page/references/service-page-template.md`.

1. Follow the HTML page structure template exactly
2. Apply the on-page SEO checklist to every element
3. Write 1,500-2,500 words of unique, differentiated content
4. Include 6-10 FAQs addressing real objections
5. Generate meta title (front-load conversion copy, back-load SEO keywords up to 270 chars)
6. Generate meta description (150-160 chars with keyword + CTA)
7. Generate Service + FAQPage JSON-LD schema markup
8. Suggest 3-5 internal linking targets with anchor text
9. Suggest image placements with alt text

---

## Phase 4: Output

<HARD-GATE>
DO NOT skip output. ALWAYS save the page content as a file. Do not dump the full page into the terminal.
</HARD-GATE>

1. Generate clean semantic HTML ready for CMS insertion, with schema JSON-LD in a `<script>` tag at the bottom
2. Save to `[output_dir]/YYYY-MM-DD-service-[service-slug].html` (default `output_dir`: `~/Desktop/`)
3. If `auto_open` is true (default), run `open [filepath]` via Bash to auto-open in browser
4. Print to terminal ONLY: meta title, meta description, word count, 3-5 key differentiators used, file path

---

## Red Flags

| Thought | Reality |
|---|---|
| "I have enough info to start writing" | Complete ALL discovery questions. Missing differentiators = generic page. |
| "I'll skip competitor research" | Without knowing what competitors cover, differentiation is impossible. |
| "The user just wants a quick page" | Even quick pages need keyword targeting and structure. Follow the template. |
| "I'll output the content as markdown" | Service pages need semantic HTML for CMS insertion. Always HTML. |
| "FAQs aren't necessary for this service" | FAQs address objections and capture long-tail queries. Always include them. |

---

## Tools to Use

> **Prerequisites:** See [references/prerequisites.md](../../references/prerequisites.md) — ensure ahrefs and dataforseo MCPs are installed and active.

- **DataForSEO MCP** (if available) — Keyword volumes, SERP data, on-page analysis of competitors
- **Ahrefs MCP** (if available) — Keyword difficulty, content gap analysis
- **WebSearch / WebFetch** — Competitor page analysis, PAA research, service-specific information

## Self-Improvement
- After the user approves final output, offer to save it as an approved example for future reference
- If the user gives explicit negative feedback, offer to add it as a learned rule
- If approved examples exist in references/approved-examples/, review them before generating new output to match established quality
