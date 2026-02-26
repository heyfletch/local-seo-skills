# Area Page Template

## Page Structure

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

## On-Page SEO Specifications

- **Word count:** 1,200-1,800 words
- **Target keyword:** "[service] in [city]" — use naturally 3-5 times
- **Meta title:** Front-load conversion copy, back-load SEO keywords. The first ~60 chars display to users — make them compelling. Everything past the truncation point ("...") is invisible to users but still indexed by Google. Stuff extra service names, service areas, and keyword variations after the cutoff. Example: `Emergency Plumbing in Denver | ABC Plumbing | Drain Cleaning, Water Heater, Arvada, Lakewood, Aurora` (up to 270 chars indexed)
- **Meta description:** 155 chars with keyword + local proof point + CTA
- **URL:** /areas/[city-name] or /[city-name]/[service]
- **Schema:** LocalBusiness with areaServed property (see local-seo-schema)
- **Embedded Google Map:** Specific to the city/area
- **Internal links:** To main service page(s) + related area pages + homepage

## Thin Content Detection Checklist

Before publishing, verify page passes these checks:

- [ ] Would this page still make sense with a different city name? If YES → it's too generic, add local specifics
- [ ] Does it include at least 3 genuinely local facts/references?
- [ ] Is it at least 50% different from other area pages in word choice/structure?
- [ ] Does it reference specific neighborhoods or zip codes?
- [ ] Does it include local testimonials or case studies?
- [ ] Would a local resident recognize the local references as authentic?

If a page fails 3+ of these checks, DO NOT publish it. Either add genuine local content or skip this city.
