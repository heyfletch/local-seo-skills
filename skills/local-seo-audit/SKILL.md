---
name: local-seo-audit
description: Comprehensive local SEO audit for service-area and local businesses. Use when the user wants to audit, review, diagnose, or assess local SEO performance, Google Business Profile optimization, citation consistency, review health, local rankings, or AI search visibility. Also triggers for "local SEO check", "how's my local SEO", "GBP audit", "map pack analysis", "local visibility report", or any mention of auditing a local business website.
---

# Local SEO Audit Skill

Perform a comprehensive local SEO audit across all ranking signal groups. Output a prioritized action plan with effort/impact scoring.

## 2026 Algorithm Weighting Reference

Use these weights to prioritize findings:

| Signal Group | Local Pack/Map | Local Organic | AI Search |
|---|---|---|---|
| **GBP** | **32%** | 7% | 12% |
| **Reviews** | 20% | 5% | 16% |
| **On-Page** | 15% | **33%** | **24%** |
| **Links** | 12% | 24% | 13% |
| **Behavioral** | 9% | 10% | 4% |
| **Citations** | 7% | 5% | 13% |

## Audit Process

### Step 1: Gather Information

Ask questions ONE AT A TIME in a conversational flow. Do NOT list all questions at once.

**Flow:**
1. First, ask: "What business should I audit? (name, URL, or both)"
2. Once you have the business name/URL, use web search to auto-discover as much as possible: website URL, GBP listing, industry, location, services, competitors.
3. Present what you found and ask the user to confirm or correct.
4. Only ask follow-up questions for information you couldn't discover — ask each one individually, not as a list.

**Information needed** (discover via research, only ask user if you can't find it):
- Business website URL
- Google Business Profile URL or business name + city
- Business type / industry
- Service area (cities/regions served)
- Primary services offered
- Top 3-5 competitors (or discover them)
- Current monthly organic traffic (if available from GA4/GSC)
- Number of locations (single vs multi-location)

### Step 2: Audit Categories

Run through each category below. Score each 0-100 and flag issues.

#### A. Google Business Profile Audit (Weight: 32% of local pack)

Check and score:

1. **Profile Completeness**
   - Business name (exact match to legal name, no keyword stuffing)
   - Primary category (most specific available — e.g., "Personal Injury Attorney" not "Law Firm")
   - Secondary categories (all relevant ones added, up to 9)
   - Business description (750 chars, keywords, service area, differentiators, CTA)
   - Service area defined (if SAB) or address visible (if storefront)
   - Phone number (local number preferred over toll-free)
   - Website URL
   - Appointment URL
   - Business hours (including special hours for holidays)
   - Opening date
   - All applicable attributes checked

2. **GBP Predefined Services** ⚠️ NEW 2026
   - Are Google-suggested services added? (directly impacts keyword rankings)
   - Each service should have: name, description (300 chars), price (if applicable), link to relevant page
   - Cross-reference with the GBP Services list for the business category

3. **Photos & Visual Content**
   - Profile photo and cover photo set
   - Minimum 10+ photos (exterior, interior, team, at-work)
   - Photos added monthly (5-10/month target)
   - Video content present (increases profile dwell time)
   - Photo quality (well-lit, properly oriented, 720px+ width)

4. **Posts Activity**
   - Posting frequency (target: 2-3/week minimum)
   - Post types mix (updates, offers, events)
   - Post quality (value-driven, not just promotional)
   - CTA usage in posts
   - Last post date (stale profiles lose ranking)

5. **Q&A Section**
   - Seeded questions present (5-10 common questions)
   - All questions answered
   - Response time to new questions
   - Keywords used naturally in answers

6. **"Open Now" Factor** ⚠️ NEW 2026
   - Hours accurate and up to date
   - Holiday hours set
   - Note: Rankings slip ~1 hour before closing and drop when closed

7. **Map Pin Location**
   - Pin is correctly placed
   - Monitor for competitor-driven pin edits (can move pin to wrong location)

#### B. Review Audit (Weight: 20% of local pack)

Check and score:

1. **Review Volume** — Total review count vs competitors
2. **Review Rating** — Average rating (4.5+ is competitive)
3. **Review Recency** — Reviews in last 30/60/90 days (recency > volume in 2026)
4. **Review Velocity** — Reviews per month trend
5. **Review Responses** — % of reviews responded to, response time, response quality
6. **Review Diversity** — Reviews mention different services/locations
7. **Keyword Content** — Do reviews naturally mention services/location?
8. **Platform Distribution** — Reviews on Google, Yelp, industry-specific sites
9. **Negative Review Handling** — How are 1-3 star reviews addressed?
10. **Review Generation System** — Is there a systematic process in place?
11. **Testimonials Page Title** — ⚡ QUICK WIN: Is the testimonials/reviews page optimized with `[Brand Name] Reviews` as the title tag? (Most businesses use "Testimonials" — changing to "[Brand] Reviews" can rank #1 for brand + reviews, displacing Yelp/Reddit)

#### C. On-Page / Website Audit (Weight: 33% of local organic)

Check and score:

1. **Service Pages**
   - Dedicated page for EVERY individual service (not one combined page)
   - Each page 1,500-2,500 words (guideline — completeness > length)
   - Target keyword in H1, first 100 words, 1-2 H2s
   - Keyword density 1-2% (natural, not stuffed)
   - FAQs with thorough answers (5-10 per page)
   - Real testimonials with attribution
   - **Customer stories present** (full narratives with details/photos/costs — highest-performing content type)
   - Clear CTAs (above fold + bottom)
   - Internal links to related services (3-5)
   - Pricing transparency (specific or range)
   - **Real photos** (people, actual work, results — NOT AI-generated images)

2. **Location/Service Area Pages**
   - Dedicated page for each major service area
   - ⚠️ CRITICAL: Pages must have genuinely unique local content
   - NOT cookie-cutter pages with city names swapped (Google penalizes these in 2026)
   - Include: local landmarks, demographics, neighborhoods, local partnerships
   - Local testimonials from that area
   - Embedded Google Map specific to that area
   - Neighborhood and zip code coverage

3. **Technical On-Page**
   - Title tags: Front-load conversion copy (primary keyword + location + brand in first ~60 chars for display), then back-load SEO keywords past the truncation point — extra service names, service areas, keyword variations (up to 270 chars indexed even though users see "..."). Check if competitors are using this hidden keyword strategy.
   - Meta descriptions: 150-160 chars with keyword + CTA
   - H1-H3 hierarchy (one H1 per page)
   - Image optimization (WebP, compressed <200KB, descriptive alt text)
   - Internal linking structure
   - Mobile responsiveness
   - Core Web Vitals: LCP <2.5s, INP <200ms, CLS <0.1
   - Page speed score >85

4. **E-E-A-T Signals**
   - Author bios with credentials
   - About page with team details
   - Certifications and licenses displayed
   - Professional association memberships
   - Case studies or portfolio
   - Contact information prominent
   - Privacy policy and terms present

5. **Content Quality**
   - Original, helpful content (not AI slop or competitor copies)
   - Answers specific "People Also Ask" queries
   - Scannable format (H2s/H3s, short paragraphs)
   - Write content competitors haven't written (differentiation > copying)

#### D. Link Profile Audit (Weight: 24% of local organic)

Check and score:

1. **Domain Authority/Rating** — Current DA/DR
2. **Total Referring Domains** — Count and quality
3. **Local Links** — Links from local businesses, chambers, associations
4. **Industry Links** — Links from industry directories, associations
5. **Competitor Comparison** — Link gap analysis
6. **Toxic Links** — Spammy or harmful backlinks
7. **Anchor Text Distribution** — Natural vs over-optimized

Note: Backlink weight is DECLINING for local pack rankings in 2026 but still matters for local organic results.

#### E. Citation Audit (Weight: 7% local pack, 13% AI search)

Check and score:

1. **NAP Consistency** — Name, Address, Phone exactly the same everywhere
2. **Tier 1 Citations** — Google, Bing, Apple Maps, Facebook, Yelp, BBB, YP, Foursquare
3. **Tier 2 Citations** — Nextdoor, industry-specific directories
4. **Industry-Specific Directories** — More important than general NAP citations for AI search in 2026
5. **Data Aggregators** — Neustar Localeze, Foursquare, Data Axle
6. **"Best Of" Lists** — LLMs heavily cite "Best [Service] in [City]" lists for AI recommendations
7. **Duplicate Listings** — Identify and resolve

#### F. AI Search Visibility Audit ⚠️ NEW 2026

**Context:** AI search (ChatGPT, Gemini) is growing but still <1% of daily searches and <1% of referral traffic. For local businesses, AI queries with local intent almost always trigger web search (RAG) — so ranking well in traditional search drives AI visibility too. Don't panic, but don't ignore it.

Check and score:

1. **AI Overview Appearance** — Does business appear in Google AI Overviews for key terms?
2. **ChatGPT Visibility** — Does ChatGPT mention business? (uses Bing, Wikipedia, Yelp, BBB, Foursquare — NOT Google)
3. **Structured Data** — Schema markup present and valid (feeds AI Knowledge Graph)
4. **First-Party Testimonials** — LLMs crawl website testimonial pages to verify reputation
5. **Content Citability** — Is content structured so AI can extract and cite it?
6. **Industry Directory Presence** — More impactful than generic NAP for AI citations
7. **Brand SERP** — What appears when someone searches the business name?
8. **Entity Consistency Check** — Google the brand name, ask ChatGPT "Who is [brand]?" — is the description accurate? Are bio, titles, services consistent across website, LinkedIn, GBP, directories? AI triangulates identity from multiple sources; inconsistencies cause confusion.

**AI Visibility Tracking — What Works:**
- Google Search Console — check referral traffic from AI platforms (chatgpt.com, gemini.google.com)
- Microsoft Clarity — tracks when LLMs visit your site
- CloudFlare — bot tracking data
- "How did you hear about us?" on contact forms (some agencies report ~11% of leads cite ChatGPT)
- Manual spot checks — periodically ask ChatGPT/Gemini about the business

**What Doesn't Work (2026):**
Grid-based AI rank tracking tools (AI equivalents of Local Falcon) are unreliable — LLM outputs are probabilistic and results change every few minutes for the same query. Avoid paying for AI rank tracking tools until the technology matures.

**Multi-Site Visibility Strategy:**
For AI visibility, the business doesn't need to rank its own website #1. LLMs synthesize answers from multiple sources in the top 10-20 results. Audit whether the business is mentioned across: "Best [Service] in [City]" articles, industry directories, local publications, and review platforms. Digital PR and third-party mentions matter more for AI citation than they do for traditional SEO.

#### F2. SERP Landscape Check

For top 5-10 target keywords, check the SERP layout:
1. **Local Service Ads (LSAs) present?** — If yes, note that LSAs capture ~5% average CTR (up to 20%+ for high-trust verticals like lawyers). Consider recommending a paid ads partner.
2. **Map pack position** — Inside or outside visible results?
3. **AI Overview present?** — Informational queries most affected
4. **Number of organic results visible** — Ads increasingly compress organic space
5. **LSA growth trend** — LSAs now appear on 31% of tracked queries (up from 11% at start of 2025). For industries where LSAs are active, note that leads/calls from the map pack may be declining as LSAs capture attention first. Consider recommending LSA management as part of the strategy.

#### G. Competitor Analysis

For top 3-5 competitors, compare:

| Metric | Client | Comp A | Comp B | Comp C |
|---|---|---|---|---|
| Domain Authority | | | | |
| Organic Traffic | | | | |
| Keywords Ranking | | | | |
| GBP Reviews (count) | | | | |
| GBP Rating | | | | |
| Blog Posts (90 days) | | | | |
| Service Pages | | | | |
| Location Pages | | | | |
| GBP Post Frequency | | | | |
| Schema Markup | | | | |

#### H. Analytics & ROI Tracking Audit

Check whether the client can prove SEO ROI:

1. **GA4 Funnel Explorations** — Are custom funnels set up tracking: blog/service page visit → product/service page → conversion? Use open funnels (not closed) since users enter at different points.
2. **Custom Events** — Are important interactions tracked in GTM (form submissions, button clicks, call clicks)?
3. **Saved Reports** — Are funnel explorations saved as custom reports in the GA4 library for consistent monitoring?
4. **Segment Comparisons** — Can they compare by device type, traffic source, and geography?

If none of this exists, flag it as a priority setup item. Proving ROI is what prevents client churn.

### Step 3: Scoring & Prioritization

Score each category 0-100. Calculate weighted overall score.

Use this priority matrix for recommendations:

| Impact | Low Effort (<2hr) | Medium (2-8hr) | High (>8hr) |
|---|---|---|---|
| **High** | **10 - DO NOW** | **8 - THIS WEEK** | **6 - THIS MONTH** |
| **Medium** | **7 - THIS WEEK** | **5 - THIS MONTH** | **3 - EVALUATE** |
| **Low** | **4 - IF TIME** | **2 - BACKLOG** | **1 - SKIP** |

### Step 4: Output Format

```markdown
# Local SEO Audit Report: [Business Name]

**Date:** [Date]
**Website:** [URL]
**Industry:** [Type]
**Service Area:** [Area]

## Overall Score: [X/100]

| Category | Score | Weight | Weighted |
|---|---|---|---|
| GBP Optimization | /100 | 32% | |
| Reviews | /100 | 20% | |
| On-Page SEO | /100 | 15% | |
| Links | /100 | 12% | |
| Behavioral Signals | /100 | 9% | |
| Citations | /100 | 7% | |
| AI Visibility | /100 | 5% | |

## Priority Actions

### 🔴 Critical (Do This Week)
[Priority 8-10 items]

### 🟡 Important (This Month)
[Priority 5-7 items]

### 🟢 Growth (Next Quarter)
[Priority 3-4 items]

## Detailed Findings
[Category-by-category breakdown with specific recommendations]

## Competitor Comparison
[Comparison table and gap analysis]
```

## Tools to Use

- **DataForSEO MCP** (if available) — SERP rankings, Google Maps data, keyword volumes, GBP data, backlinks, on-page crawl. Preferred source for quantitative data.
- **Ahrefs MCP** (if available) — Domain rating, backlinks, organic keywords, competitor analysis
- **Google Search Console** — Current rankings, impressions, clicks
- **BrightLocal** — Citation audit, local rank tracking, review monitoring
- **PageSpeed Insights** — Core Web Vitals
- **Google Rich Results Test** — Schema validation
- **Web search/fetch** — Crawl competitor pages, discover citations, check listings

Use whichever data tools are available. DataForSEO and Ahrefs complement each other — use both when available.

## Output & Delivery

Always save reports as files to `~/Desktop/`. Ask the user which format(s) they want:

### Markdown (default)
- Save to `~/Desktop/YYYY-MM-DD-audit-[business-slug].md`

### HTML Report (recommended for client delivery)
- Use the HTML template at `${CLAUDE_PLUGIN_ROOT}/references/html-report-template.html`
- Generate a self-contained HTML file with all CSS inline
- Save to `~/Desktop/YYYY-MM-DD-audit-[business-slug].html`
- The template includes a "Save as PDF" button that triggers browser print

### PDF
- After generating the HTML report, convert to PDF:
  - Try: `wkhtmltopdf ~/Desktop/[file].html ~/Desktop/[file].pdf`
  - If wkhtmltopdf not available, tell the user to open the HTML and use the "Save as PDF" button (Cmd+P)
- Save to `~/Desktop/YYYY-MM-DD-audit-[business-slug].pdf`

Always confirm the output format with the user before generating. Default to HTML if they don't specify.
