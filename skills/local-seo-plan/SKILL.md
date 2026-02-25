---
name: local-seo-plan
description: Strategic local SEO planning for service-area and local businesses. Use when the user wants to create a marketing roadmap, site architecture, keyword strategy, sitemap, content plan, or 90-day action plan for a local business. Also triggers for "SEO roadmap", "keyword research for local business", "site structure", "what pages should I create", "marketing plan for [local business type]", or strategic planning for multi-location businesses.
---

# Local SEO Strategic Plan Skill

Create a comprehensive local SEO strategy including site architecture, keyword research, traffic projections, and prioritized action plan.

## Planning Process

### Step 1: Discovery

Ask questions ONE AT A TIME in a conversational flow. Do NOT list all questions at once.

**Flow:**
1. First, ask: "What business are we planning for? (name, URL, or both)"
2. Once you have the business name/URL, use web search to auto-discover: website, industry, services, locations, service area, competitors.
3. Present what you found and ask the user to confirm or correct.
4. Then ask remaining questions individually in this order — skip any already answered:
   - "What are your business goals?" (leads, calls, bookings, etc.)
   - "Who's your ideal client?"
   - "What's your monthly SEO budget?" ($0 / $1-50 / $51-200 / $200+)
   - "Any seasonal patterns?" (busy/slow periods)
   - "What makes you different from competitors?" (USPs)

**Information needed** (discover via research, only ask user if you can't find it):
- Business name, website URL, industry
- Services offered (complete list)
- Service area (all cities/regions)
- Number of locations (single vs multi)
- Target audience / ideal client profile
- Current monthly traffic (GA4/GSC if available)
- Budget tier: $0 | $1-50 | $51-200 | $200+/month
- Competitors (or discover via search)
- Business goals (leads, calls, bookings, etc.)
- Unique selling propositions
- Seasonal patterns (busy/slow periods)

### Step 2: Keyword Research

Organize keywords into four categories:

#### A. Service Keywords (Commercial Intent) — Target: Service Pages
- Primary: [service type] — e.g., "eye exam", "pediatric dentist"
- Modifiers: "best", "affordable", "emergency", "certified", "top"
- Combined: [modifier] + [service] — e.g., "best pediatric dentist"

#### B. Location Keywords (Local Intent) — Target: Service Area Pages
- Primary: [service] + [city] — e.g., "eye doctor Bethesda"
- Neighborhood: [service] + [neighborhood] — e.g., "dentist near Chevy Chase"
- Do NOT optimize explicitly for "near me" — this is implicit in mobile search

#### C. Long-tail Keywords (Informational) — Target: Blog/FAQ
- Question-based: "how often should I get an eye exam"
- Problem-solving: "signs you need new glasses"
- Comparison: "glasses vs contacts for kids"

#### D. Zero Search Volume Keywords — Target: Blog/FAQ
- Very specific, long-tail queries from GSC
- Often show 0 volume but indicate real search behavior
- High conversion potential due to specificity

#### Keyword Metrics to Document

For each keyword:
- Search Volume (monthly)
- Keyword Difficulty (0-100)
- Current Ranking (if any)
- Search Intent (informational / commercial / transactional / local)
- Traffic Tier: High (>1000) / Medium (250-1000) / Low (<250)
- Priority Score (1-10 based on volume + difficulty + intent + relevance)

#### Keyword Golden Ratio (KGR) for Quick Wins

**Formula:** (Allintitle results) ÷ (Monthly search volume) where volume < 250

- **KGR < 0.25** — Excellent, should rank quickly
- **KGR 0.25-1.0** — Good opportunity
- **KGR > 1.0** — More competitive

Flag all KGR < 0.25 keywords as quick-win content targets.

### Step 3: Site Architecture

Design the optimal sitemap structure:

```
Homepage (/)
│
├── About (/about)
│   ├── Team (/about/team)
│   └── Process (/about/our-process)
│
├── Services (/services)
│   ├── [Service 1] (/services/[service-1])
│   ├── [Service 2] (/services/[service-2])
│   ├── [Service 3] (/services/[service-3])
│   └── ... (one page per distinct service)
│
├── Service Areas (/areas) — if serving multiple cities
│   ├── [City 1] (/areas/[city-1])
│   ├── [City 2] (/areas/[city-2])
│   └── ... (only cities with genuine unique content)
│
├── Reviews (/reviews)
│
├── Resources (/resources OR /blog)
│   ├── [Topic Category 1] (/blog/[category])
│   └── [Topic Category 2] (/blog/[category])
│
├── FAQ (/faq) — if not embedded in service pages
│
└── Contact (/contact)
    └── Schedule Appointment (/contact/schedule)
```

**Architecture Rules:**
- Flat structure: every page within 3 clicks of homepage
- One page per distinct service (not a combined services page)
- Service area pages ONLY for cities with genuine unique local content
- ⚠️ Do NOT create thin service area pages that just swap city names — Google penalizes these
- Quality gate: Warning at 30+ location pages, hard stop at 50+ without audit
- Internal linking: every service page links to related services + relevant area pages

### Step 4: Page-Level Specifications

For each page in the sitemap, specify:

```
Page: /services/[service-name]
Title: [Primary keyword] | [Brand] | [Location] (up to 270 chars — Google indexes beyond display truncation)
Target Keyword: [main keyword]
Secondary Keywords: [2-5 related]
Search Intent: Commercial
Priority: High/Medium/Low

Meta Title: (60 chars for display, but can include more for indexing)
Meta Description: (155 chars with keyword + CTA)
H1: [Single, includes primary keyword]

Content Requirements:
- Word count: 1,500-2,500 for service pages, 1,000-2,000 for blog
- FAQs: 5-10 with thorough answers
- Schema: [Service, FAQPage, LocalBusiness]
- Internal links to: [related pages]
- CTAs: [specific actions]

Conversion Goal: [Call / Book / Form submission]
```

### Step 5: Traffic Projections

Project realistic traffic using CTR by position:

| Position | Average CTR |
|---|---|
| 1 | 25-30% |
| 2 | 15-20% |
| 3 | 10-15% |
| 4-5 | 7-10% |
| 6-10 | 3-7% |
| 11-20 | 1-3% |

**Calculate per keyword:** Monthly Volume × CTR at Target Position = Potential Monthly Clicks

**Apply adjustment factors:**
- New domain (DA <20): ×0.5-0.7
- Established domain (DA 20-40): ×0.7-0.9
- Low competition market: ×1.0-1.2
- High competition: ×0.5-0.8

**Project at 3 intervals:**
- 3 months (10-20% of full potential) — quick wins, KGR keywords
- 6 months (30-50%) — service pages ranking, some blog traction
- 12 months (60-80%) — established authority, local pack presence

Always state whether projections are for local pack, local organic, or combined. Communicate conservative scenario to clients.

### Step 6: 90-Day Action Plan

Structure as weekly priorities:

**Weeks 1-2: Foundation**
- GBP claim/verify and optimize (categories, services, description, photos)
- Set up GA4, GSC, rank tracking
- Implement schema markup on homepage
- Fix critical technical issues (speed, mobile, SSL)
- Create NAP consistency document

**Weeks 3-4: Core Content**
- Create/optimize top 3-5 service pages
- Optimize homepage with primary keywords
- Add testimonials/reviews page
- Set up review generation system

**Weeks 5-8: Expansion**
- Create remaining service pages
- Build 2-3 highest-priority service area pages (with unique content)
- Publish 4-6 blog posts targeting KGR keywords
- Begin citation building (Tier 1 directories)
- Start GBP posting cadence (2-3/week)

**Weeks 9-12: Authority**
- Complete citation building (Tier 2)
- Continue blog content (4-6 more posts)
- Build 2-3 more service area pages
- Start local link building (chambers, associations)
- Monthly performance review and adjustment

### Step 7: Deliverable Format

```markdown
# Strategic Marketing & SEO Roadmap: [Business Name]

## Executive Summary
- Current state assessment
- Primary opportunity
- Biggest challenge
- 90-day focus areas

## Competitor Analysis
- Top 3-5 competitor breakdown
- Comparison table
- Gap analysis and opportunities

## Keyword Research
- Master keyword list organized by service/location/content
- Priority tracking list (25-75 keywords)
- KGR quick wins highlighted

## Optimal Sitemap
- Visual site architecture
- Page-by-page specs with meta data
- Internal linking strategy

## Traffic Projections
- 3/6/12 month estimates with math shown
- Conservative and moderate scenarios

## 90-Day Action Plan
- Week-by-week priorities
- Effort/impact scoring
- Resource requirements

## Budget & Tool Recommendations
- Prioritize free tools (GSC, GA4, GBP)
- BrightLocal for local rank tracking ($39-99/mo)
- NeuronWriter for content optimization (lifetime deal)
- n8n for automation workflows
```

## Tools to Use

- **DataForSEO MCP** (if available) — Keyword volumes, SERP data, competitor analysis, Google Maps rankings. Preferred for keyword research.
- **Ahrefs MCP** (if available) — Domain metrics, organic keywords, competitor gaps
- **Web search/fetch** — Competitor research, content gap analysis

Use whichever data tools are available.

## Output & Delivery

Always save reports as files to `~/Desktop/`. Ask the user which format(s) they want:

- **Markdown**: Save to `~/Desktop/YYYY-MM-DD-plan-[business-slug].md`
- **HTML Report** (recommended): Use the template at `${CLAUDE_PLUGIN_ROOT}/references/html-report-template.html`. Save to `~/Desktop/YYYY-MM-DD-plan-[business-slug].html`
- **PDF**: Convert from HTML via `wkhtmltopdf` or tell user to use the "Save as PDF" button in the HTML report.

Default to HTML if user doesn't specify.

## Multi-Location Strategy Notes

For businesses with 2+ locations:
- Each location needs its own GBP
- Each location MAY need its own landing page (only if unique content justifiable)
- Shared service pages are fine — just reference all locations served
- Review generation should be per-location
- Citation building per-location for NAP consistency
- Consider separate city subfolders: /bethesda/eye-exam vs /rockville/eye-exam
