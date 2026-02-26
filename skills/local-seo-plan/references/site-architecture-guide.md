# Site Architecture Guide

## Optimal Sitemap Template

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

## Architecture Rules

- Flat structure: every page within 3 clicks of homepage
- One page per distinct service (not a combined services page)
- Service area pages ONLY for cities with genuine unique local content
- Do NOT create thin service area pages that just swap city names — Google penalizes these
- Quality gate: Warning at 30+ location pages, hard stop at 50+ without audit
- Internal linking: every service page links to related services + relevant area pages

## Internal Linking Strategy — Topic Silos

In-content links (anchor text within body paragraphs) carry significantly more weight than navigation menu links. Build topic silos by interlinking related service pages:
- Group services into clusters (e.g., all water heater pages interlink, all drain pages interlink)
- Each cluster's pages link to each other with descriptive anchor text
- Each cluster links back to the main service hub page
- Cross-link between clusters where relevant

## Page-Level Specifications

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
- Word count: 1,500-2,500 guideline for service pages, 1,000-2,000 for blog (completeness > length)
- Customer stories: At least 1 per service page (full narrative, not just a quote)
- FAQs: 5-10 with thorough answers
- Schema: [Service, FAQPage, LocalBusiness]
- Internal links to: [related pages]
- CTAs: [specific actions]

Conversion Goal: [Call / Book / Form submission]
```

## Multi-Location Strategy Notes

For businesses with 2+ locations:
- Each location needs its own GBP
- Each location MAY need its own landing page (only if unique content justifiable)
- Shared service pages are fine — just reference all locations served
- Review generation should be per-location
- Citation building per-location for NAP consistency
- Consider separate city subfolders: /bethesda/eye-exam vs /rockville/eye-exam

### Expanding Map Pack Radius

Service area pages help local organic rankings but will NOT help map pack rankings — only GBP proximity does that. For clients who need map pack presence in another city, consider subleasing office space. Find someone on Facebook Marketplace or Craigslist renting a room in their existing office — usually hundreds/month vs thousands for your own lease. Requirements: should have signage and technically should be staffed (though many operate "by appointment only" after initial verification). This is a legitimate strategy used by law firms and insurance companies.
