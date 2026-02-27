# Service Page Template

## Full HTML Page Structure

```html
<!-- H1: Include primary keyword naturally. One H1 only. -->
<h1>[Service Name] in [City/Area]</h1>

<!-- Opening: 100-150 words. Keyword in first 100 words. Address the visitor's
     problem and your solution FIRST — what they need and why they should call.
     Do NOT lead with "We are a family-owned business" or company history.
     Save credentials for later sections. The opening earns attention by
     speaking to the visitor's immediate need, not about yourself.
     Include a CTA (phone number or booking link) in this opening section. -->

<h2>Why Choose [Company] for [Service]?</h2>
<!-- 4 differentiators. Each must be SPECIFIC and MEASURABLE.
     NOT: "We provide high quality service"
     YES: "With 15+ years and 500+ [procedures] completed, we [specific outcome]" -->

<h2>Our [Service] Process</h2>
<!-- 3-5 steps. Each step: name + 2-3 sentences explaining what happens,
     what's required, and timeline. Reduces anxiety, builds trust. -->

<h2>Who Benefits from [Service]?</h2>
<!-- 3 ideal client types. Each with specific pain points and how service helps. -->

<h2>[Service] Pricing</h2>
<!-- Be as transparent as possible. Options:
     - Specific prices/packages
     - Starting price + what affects cost
     - Price range + factors
     Even "Contact for custom quote" is better than no pricing section. -->

<h2>What to Expect During [Service]</h2>
<!-- 150-300 words. Walkthrough of the experience from client perspective.
     Timeline, what they'll see/feel, preparation needed. -->

<h2>Frequently Asked Questions</h2>
<!-- 6-10 FAQs. Structure each as:
     - Address common objection/concern
     - Answer technical/process questions
     - Address comparison/alternative questions
     - Address timing/scheduling questions
     Each answer: 3-5 sentences with keyword variations naturally. -->

<h2>[Service] in [Nearby Areas]</h2>
<!-- List 4-8 cities/areas served. Brief note per area if applicable.
     Link to service area pages if they exist. -->

<h2>Featured Customer Story</h2>
<!-- THIS SECTION IS HIGH PRIORITY. Customer stories dramatically outperform
     all other content types (tested: +57% conversions, +350% traffic).
     NOT a short testimonial — a full narrative:
     - The problem/situation the customer faced
     - Why they chose this business
     - What happened during service (specific details, timeline)
     - The outcome/result (with numbers if possible)
     - Include real photos, costs, and timeframes
     Structure as a mini case study (200-400 words).
     Interview customers to get these stories. -->

<h2>Customer Reviews</h2>
<!-- 2-3 real testimonials with name and city attribution. Link to full reviews page. -->

<h2>Ready to Get Started?</h2>
<!-- 2-3 sentences creating urgency or emphasizing value.
     Primary CTA: phone number (clickable on mobile) + booking link
     Secondary CTA: download guide, free consultation, etc. -->
```

## Content Requirements

- **Word count:** 1,500-2,500 words as a guideline (not a KPI). Shorter is fine if it fully addresses user intent. Completeness > length. Interactive tools (calculators, quizzes) can rank with minimal text.
- **Keyword density:** 1-2% (natural, never forced)
- **Tone:** Second person (you/your). Professional yet approachable.
- **Voice:** Write for humans first. Specific > generic. Data > claims.
- **Images:** Prioritize real photos of people, actual work, and real results. Infographics for data. Be cautious with AI-generated imagery — it can undermine authenticity and E-E-A-T signals.

## On-Page SEO Checklist

**Content:**
- [ ] Target keyword in first 100 words
- [ ] Target keyword in H1 (one H1 only)
- [ ] Keyword in 1-2 H2s naturally
- [ ] 6-10 FAQs with thorough answers
- [ ] Real testimonials with attribution
- [ ] Featured customer story (full narrative with details/photos/costs — NOT just a quote)
- [ ] CTA above the fold
- [ ] CTA at bottom
- [ ] Opening paragraph addresses visitor's problem first (not company credentials) with an immediate CTA
- [ ] 3-5 in-content internal links to related services/pages (in-body anchor text links — NOT navigation menu links, which don't carry the same weight)
- [ ] Pricing section present

**Technical:**
- [ ] Meta title: Front-load conversion copy (primary keyword + location + brand in first ~60 chars for display), then back-load SEO keywords past the truncation point — extra service names, service areas, keyword variations (up to 270 chars indexed by Google even though users see "...")
- [ ] Meta description: 150-160 chars with keyword + compelling CTA
- [ ] Clean URL: /services/[service-name]
- [ ] Images: WebP, compressed <200KB, descriptive alt text with keyword
- [ ] Schema markup: Service + FAQPage + LocalBusiness (see local-seo-schema skill)
- [ ] Mobile responsive
- [ ] Page speed >85

**Conversion:**
- [ ] Phone number in header (clickable mobile)
- [ ] Contact form visible without excessive scrolling
- [ ] Trust signals visible (certifications, associations, review count)
- [ ] Social proof (years in business, clients served, review rating)
- [ ] Process clearly explained (reduces friction)

### Topic Silo Internal Linking

Internal links in body content (not navigation menus) are a top organic ranking factor. Build topic silos by interlinking related service pages:

Example for a plumber:
- **Hot water tank cluster:** repair page, installation page, types page — all interlinked with descriptive anchor text
- **Drain cleaning cluster:** similar structure
- Each cluster's pages link to each other and back to the main service page

The key: descriptive anchor text within body paragraphs, not just links in navigation dropdowns.

### Core Service Hub Pages

For a business's highest-profit services (1-2 "core services" they most want to rank for), consider creating a hub page with child sub-service pages underneath:

Example for a plumber's "Water Heater Replacement" core service:
- Hub: `/water-heater-replacement/` — comprehensive overview, links to all sub-services
- Child: `/water-heater-replacement/tankless-water-heater/`
- Child: `/water-heater-replacement/electric-water-heater/`
- Child: `/water-heater-replacement/gas-water-heater/`

This creates concentrated topical authority around the core service. Each child page links to siblings and back to the hub. The hub links to all children.

## AI Content Generation Prompt

When generating service page content, use this prompt structure:

```
Write a service page for [Business Name], a [business type] in [location].

Service: [name]
Target keyword: [keyword]
Secondary keywords: [list]
Target audience: [who this is for]
USPs: [3-4 specific differentiators]
Service process: [steps]
Price range: [if applicable]
Competitor gaps: [what competitors miss]

Requirements:
- 1,800-2,200 words
- Second person (you/your)
- Tone: [Professional yet approachable]
- Specific, measurable claims (not generic)
- Include keyword naturally 4-6 times
- Follow the H1 > H2 structure from the template
- 6-8 FAQs addressing real objections
- Strong CTAs

Do NOT:
- Use generic filler content
- Over-stuff keywords
- Make unsubstantiated claims
- Write in passive voice
- Start sentences with "At [Company], we..."
```
