---
name: local-seo-service-page
description: Build SEO-optimized service pages for local businesses. Use when the user wants to create, write, or optimize a service page, landing page for a specific service offering, or any page targeting "[service] [location]" keywords. Also triggers for "write a service page", "create a page for [service]", "optimize my services page", or building individual service offering pages for local/service-area businesses.
---

# Local SEO Service Page Builder

Create high-converting, SEO-optimized service pages for local businesses. Each service MUST have its own dedicated page — never combine multiple services on one page.

## Before Writing

Ask questions ONE AT A TIME in a conversational flow. Do NOT list all questions at once.

**Flow:**
1. First, ask: "What service and business is this page for?"
2. Once you know the business and service, use web search to research: the business website, competitor pages for this service keyword, and common questions about the service.
3. Present what you found and propose a target keyword + secondary keywords.
4. Then ask remaining questions individually — skip any already answered:
   - "What makes your [service] different from competitors?" (3-4 specific differentiators)
   - "Walk me through your process — what are the steps?"
   - "What's the pricing?" (specific, range, or "contact for quote")
   - "Any testimonials from clients who used this service?"
   - "What CTA do you want?" (call, book online, fill out form)

**Information needed** (discover via research, only ask user if you can't find it):
- Business name and location(s)
- Service name and description
- Target keyword and secondary keywords
- Target audience for this specific service
- Unique selling points (3-4 specific differentiators)
- Service process (step-by-step)
- Pricing info (specific, range, or "contact for quote")
- Common questions/objections about this service
- Competitor pages for this keyword (for differentiation)
- Testimonials related to this service
- Service area/cities served
- Desired CTA (call, book, form, etc.)

## Page Structure Template

```html
<!-- H1: Include primary keyword naturally. One H1 only. -->
<h1>[Service Name] in [City/Area]</h1>

<!-- Opening: 100-150 words. Keyword in first 100 words. Address visitor's
     main question immediately. Who you are, what you do, primary benefit. -->

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

<h2>Customer Reviews</h2>
<!-- 2-3 real testimonials with name and city attribution. Link to full reviews page. -->

<h2>Ready to Get Started?</h2>
<!-- 2-3 sentences creating urgency or emphasizing value.
     Primary CTA: phone number (clickable on mobile) + booking link
     Secondary CTA: download guide, free consultation, etc. -->
```

## Content Requirements

- **Word count:** 1,500-2,500 words (more for competitive keywords)
- **Keyword density:** 1-2% (natural, never forced)
- **Tone:** Second person (you/your). Professional yet approachable.
- **Voice:** Write for humans first. Specific > generic. Data > claims.

## On-Page SEO Checklist

**Content:**
- [ ] Target keyword in first 100 words
- [ ] Target keyword in H1 (one H1 only)
- [ ] Keyword in 1-2 H2s naturally
- [ ] 6-10 FAQs with thorough answers
- [ ] Real testimonials with attribution
- [ ] CTA above the fold
- [ ] CTA at bottom
- [ ] 3-5 internal links to related services/pages
- [ ] Pricing section present

**Technical:**
- [ ] Meta title: Primary keyword + location + brand (60 chars for display; up to 270 chars indexed)
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

## Content Differentiation Rules

**DO:**
- Include original data, stats, or insights unique to this business
- Reference specific local context when relevant
- Address questions competitors don't answer
- Include real case studies or anonymized client outcomes
- Write content that demonstrates first-hand experience (E-E-A-T)

**DON'T:**
- Copy competitor page structure or content
- Use generic filler ("We are committed to quality...")
- Stuff keywords unnaturally
- Use passive voice excessively
- Write in first person (use second person: you/your)
- Include "what is [service]" sections unless searchers genuinely need education

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

## Output Format

Deliver the complete page as markdown with:
1. Full page content following the template structure
2. Meta title and meta description
3. Schema markup code (JSON-LD) — Service + FAQPage
4. 3-5 internal linking suggestions with anchor text
5. Image suggestions with recommended alt text
