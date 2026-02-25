---
name: local-seo-area-page
description: Build unique, genuine service area and location pages for local businesses. Use when the user wants to create location pages, city pages, service area pages, "areas we serve" pages, or any page targeting "[service] in [city]" keywords. Also triggers for "create a page for [city]", "location page", "we serve [city]", multi-location pages, or expanding geographic coverage. CRITICAL - this skill enforces unique content requirements to avoid Google penalties.
---

# Local SEO Service Area Page Builder

Create genuinely unique service area pages that rank for "[service] in [city]" keywords. This skill enforces strict quality gates to prevent thin/duplicate content penalties.

## ⚠️ 2026 Critical Rules

1. **Cookie-cutter pages are penalized.** Google actively demotes pages that just swap city names. Each page MUST have genuinely unique local content.
2. **Quality over quantity.** Only create pages for cities where you can provide real local context.
3. **Quality gates:** Warning at 30+ pages. Hard stop at 50+ without content audit.
4. **Service area pages still work for organic local results** when they have unique, helpful content. The claim that "they're dead" is only true for thin/template pages.
5. **These pages will NOT help local pack/map rankings** — only GBP proximity does that. They help local ORGANIC rankings.

## When to Create (and When NOT To)

**CREATE a service area page when:**
- Significant search volume exists for "[service] [city]"
- You can write genuinely unique content about serving that area
- You have real local presence (office, regular clients, partnerships)
- You can include local-specific testimonials or case studies

**DO NOT create a page when:**
- You'd just be swapping city names from another page
- No local search volume for the keywords
- No genuine local connection or content to add
- You rarely actually serve that area (overstating service areas backfires in 2026)

## Before Writing

Ask questions ONE AT A TIME in a conversational flow. Do NOT list all questions at once.

**Flow:**
1. First, ask: "What city/area and service is this page for?"
2. Once you know the city and service, use web search to auto-discover: neighborhoods, zip codes, local landmarks, demographics, institutions, and competitor presence in that area.
3. Present what you found and ask the user to confirm or add to it.
4. Then ask remaining questions individually — skip any already answered:
   - "Do you have any local partnerships or community involvement in [city]?"
   - "Any testimonials from clients in [city]?"
   - "Any local events you participate in there?"
   - "What specific challenges do [city] residents face that your service addresses?"

**Information needed** (discover via research, only ask user if you can't find it):
- City/area name and neighborhoods within it
- Specific services offered there
- Local landmarks, institutions, or employers relevant to your service
- Local demographics relevant to service (e.g., "60% of Bethesda residents are federal employees")
- Local partnerships or community involvement
- Testimonials from clients in that area
- Local events you participate in
- Area-specific challenges your service addresses
- Zip codes served
- Distance/drive time from your office(s)
- Competitor presence in that area

## Page Structure Template

```html
<h1>[Service] in [City, State]</h1>

<!-- Opening: 100-150 words. MUST reference specific local context.
     NOT: "City is a wonderful community with great amenities."
     YES: Reference a specific landmark, institution, or local fact.
     Example: "As the home of NIH and Walter Reed, Bethesda has one of the
     highest concentrations of federal employees in the DMV. Our [service]
     is tailored to the unique needs of this community." -->

<h2>[Service] Services in [City]</h2>
<!-- List all services available in this area.
     1-2 sentences per service, noting any LOCAL relevance.
     Example: "Our pediatric eye exams are popular with families in the
     Woodmont Triangle and Battery Park neighborhoods." -->

<h2>Why [City] Residents Choose [Company]</h2>
<!-- 3 location-SPECIFIC advantages. Must be genuinely local.
     NOT: "We're committed to excellence" (generic)
     YES: "With our [City] office 5 minutes from [landmark], we offer
     same-day appointments for [City] residents"
     YES: "We've served 200+ families in [City] since 2018"
     YES: "We partner with [Local Organization] for community [events]" -->

<h2>Neighborhoods & Areas We Serve in [City]</h2>
<!-- List specific neighborhoods with notes.
     Include zip codes.
     Mention response time or coverage details. -->

<h2>[City] [Service] FAQs</h2>
<!-- 5-7 FAQs. At least 2-3 should have LOCAL relevance.
     Example: "Do you work with federal employees from NIH?"
     Example: "How does [service] differ for [City] residents?"
     General service FAQs are OK too. -->

<h2>About [City]</h2>
<!-- 2-3 paragraphs of GENUINE local knowledge.
     NOT: Wikipedia-style generic city description
     YES: Specific businesses, institutions you work with
     YES: Local demographics relevant to your service
     YES: Community events you participate in
     YES: Local challenges your service addresses
     This section PROVES you actually serve this area. -->

<h2>Reviews from [City] Customers</h2>
<!-- 1-2 real testimonials from this area.
     If none available, use general testimonials but don't falsely
     attribute them to this city. -->

<h2>Contact Us for [Service] in [City]</h2>
<!-- Phone (local number if available), email, office address.
     Embedded Google Map specific to this service area.
     Mention response time for this area specifically.
     Booking/scheduling link. -->
```

## Content Differentiation Strategies

To make each page genuinely unique, use these tactics:

1. **Local Statistics/Data**
   - "[X]% of [City] residents are [demographic relevant to service]"
   - "Average [metric] in [City] is [value]"

2. **Local Partnerships & Involvement**
   - "We partner with [Local Business/Org] to provide [service]"
   - "Member of [Local Chamber/Association]"
   - "Sponsor of [Local Event/Team]"

3. **Local Case Studies**
   - "Recently helped a [City] family [specific outcome]"
   - Anonymized but genuine local examples

4. **Area-Specific Content**
   - Different neighborhoods have different needs
   - Commute patterns affecting service delivery
   - Local regulations or considerations
   - Proximity to relevant facilities/institutions

5. **Local Imagery**
   - Photos actually from that area (not stock)
   - Team photos at local landmarks or events

6. **Local Events/Workshops**
   - "We host monthly workshops at [Local Venue]"

## On-Page SEO Specifications

- **Word count:** 1,200-1,800 words
- **Target keyword:** "[service] in [city]" — use naturally 3-5 times
- **Meta title:** [Service] in [City] | [Brand] (60 chars display; up to 270 indexed)
- **Meta description:** 155 chars with keyword + local proof point + CTA
- **URL:** /areas/[city-name] or /[city-name]/[service]
- **Schema:** LocalBusiness with areaServed property (see local-seo-schema)
- **Embedded Google Map:** Specific to the city/area
- **Internal links:** To main service page(s) + related area pages + homepage

## Thin Content Detection

Before publishing, verify page passes these checks:

- [ ] Would this page still make sense with a different city name? If YES → it's too generic, add local specifics
- [ ] Does it include at least 3 genuinely local facts/references?
- [ ] Is it at least 50% different from other area pages in word choice/structure?
- [ ] Does it reference specific neighborhoods or zip codes?
- [ ] Does it include local testimonials or case studies?
- [ ] Would a local resident recognize the local references as authentic?

If a page fails 3+ of these checks, DO NOT publish it. Either add genuine local content or skip this city.

## Schema Markup for Service Area Pages

Include LocalBusiness schema with `areaServed`:

```json
{
  "@context": "https://schema.org",
  "@type": "[BusinessType]",
  "name": "[Business Name]",
  "url": "[page URL]",
  "areaServed": {
    "@type": "City",
    "name": "[City]",
    "containedIn": {
      "@type": "State",
      "name": "[State]"
    }
  },
  "hasOfferCatalog": {
    "@type": "OfferCatalog",
    "name": "[Service] in [City]",
    "itemListElement": [
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "[Service Name]"
        }
      }
    ]
  }
}
```

For service-area businesses (no storefront), intentionally OMIT the `address` property and use `areaServed` instead. This is correct schema practice for hidden-address SABs.
