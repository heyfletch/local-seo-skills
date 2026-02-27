---
name: local-seo-area-page
description: This skill should be used when the user asks to "create a page for [city]", "build a location page", "write an area page", "city page", "service area page", "areas we serve", or any page targeting "[service] in [city]" keywords. Also triggers for "we serve [city]", "multi-location pages", or "expanding geographic coverage". CRITICAL — enforces unique content requirements to avoid Google penalties for thin area pages. Schema markup is generated as part of the page — for standalone schema generation without a full page, use the local-seo-schema skill instead.
---

# Local SEO Service Area Page Builder

## Iron Law

NO AREA PAGE WITHOUT GENUINE LOCAL CONTENT. Do not create cookie-cutter pages that swap city names. Do not skip the quality gate. Every area page must pass the thin content detection checklist before output.

---

## Settings

Before starting Phase 1, check if `.claude/local-seo.local.md` exists. If it does, read it and extract settings from the YAML frontmatter:

- `output_dir` — directory for saving reports/pages (default: `~/Desktop/`)
- `auto_open` — whether to auto-open files in browser (default: `true`)

Use these values in the output phase. If the file doesn't exist, use defaults.

---

## Phase 1: Discovery

<HARD-GATE>
DO NOT proceed to Phase 2 until the city, service, and local content availability are confirmed.
</HARD-GATE>

### Step 1: Identify the target area

Use AskUserQuestion:

**Question:** "What city/area and service is this page for?"
- Options: "I'll specify the city and service", "I'll provide a list of cities to evaluate", "I need help choosing which cities to target"

### Step 2: Quality gate — can we create a genuine page?

Use AskUserQuestion:

**Question:** "Do you have genuine local content for [city]?"
- "Yes — local clients, partnerships, or community involvement"
- "Some — I serve the area but limited local specifics"
- "No — I'd mostly be swapping city names from another page"

If the user selects "No", **STOP** and explain: creating thin area pages that just swap city names is penalized by Google in 2026. Recommend either gathering genuine local content first or skipping this city.

### Step 3: Auto-discover local context

Use WebSearch to discover: neighborhoods, zip codes, local landmarks, demographics, institutions, and competitor presence in that area. Present findings and ask the user to confirm or add details via AskUserQuestion.

### Step 4: Gather local specifics

Use AskUserQuestion for each (skip any already answered):

**Question:** "What local connections do you have in [city]?"
- "Local partnerships or community involvement"
- "Testimonials from clients in this area"
- "We participate in local events"
- "None yet — use what you find in research"

### Information needed (discover via research, only ask user if undiscoverable)
- City/area name and neighborhoods within it
- Specific services offered there
- Local landmarks, institutions, or employers relevant to service
- Local demographics relevant to service
- Local partnerships or community involvement
- Testimonials from clients in that area
- Area-specific challenges the service addresses
- Zip codes served
- Competitor presence in that area

---

## Phase 2: Local Research

Read the differentiation guide from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-area-page/references/area-page-differentiation.md`.

1. Research local demographics, landmarks, and institutions relevant to the service
2. Identify area-specific angles competitors haven't covered
3. Gather neighborhood names and zip codes
4. Find local statistics or data points for the "About [City]" section
5. Verify search volume exists for "[service] [city]" keywords

---

## Phase 3: Content Generation

Read the page template from `${CLAUDE_PLUGIN_ROOT}/skills/local-seo-area-page/references/area-page-template.md`.

1. Follow the HTML page structure template exactly
2. Write 1,200-1,800 words with genuinely unique local content
3. Include 5-7 FAQs with at least 2-3 having local relevance
4. Generate meta title (front-load conversion copy, back-load SEO keywords up to 270 chars)
5. Generate meta description (155 chars with keyword + local proof point + CTA)
6. Generate LocalBusiness JSON-LD schema with areaServed property
7. Run the thin content detection checklist — if the page fails 3+ checks, add more local content before proceeding

---

## Phase 4: Output

<HARD-GATE>
DO NOT skip output. ALWAYS save the page content as a file. Do not dump the full page into the terminal.
</HARD-GATE>

1. Generate clean semantic HTML ready for CMS insertion, with schema JSON-LD in a `<script>` tag at the bottom
2. Save to `[output_dir]/YYYY-MM-DD-area-[city-slug].html` (default `output_dir`: `~/Desktop/`)
3. If `auto_open` is true (default), run `open [filepath]` via Bash to auto-open in browser
4. Print to terminal ONLY: meta title, meta description, word count, thin content checklist results, file path

---

## Red Flags

| Thought | Reality |
|---|---|
| "I can write this page without local research" | Without local facts, the page is a template with a city name swapped in. Google penalizes this. |
| "The user wants 10 city pages, I'll batch them" | Each page needs genuine unique content. Warn the user at 30+ pages. |
| "I'll use generic city descriptions from Wikipedia" | Generic descriptions prove the business DOESN'T serve the area. Use specific local knowledge. |
| "This page is thin but it's better than nothing" | A thin area page actively harms the site. Skip the city or gather more content. |
| "Area pages help with map pack rankings" | They help local ORGANIC rankings only. Map pack needs GBP proximity. |

---

## Tools to Use

- **DataForSEO MCP** (if available) — Keyword volumes for "[service] [city]" queries, SERP analysis
- **Ahrefs MCP** (if available) — Keyword difficulty, competitor area page analysis
- **WebSearch / WebFetch** — Local research, demographics, competitor analysis, community information
