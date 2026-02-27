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

## GBP-Mirroring Architecture (Alternative for Service Businesses)

For service businesses with multiple GBP categories, consider an alternative structure that mirrors GBP's own category hierarchy. This builds topical authority by siloing services under their parent categories:

```
Homepage (/) — targets "[primary category] [city]" (this IS the GBP landing page)
│
├── [Secondary Category 1] (/[category-1])
│   ├── [Service A] (/[category-1]/[service-a])
│   ├── [Service B] (/[category-1]/[service-b])
│   └── ...
│
├── [Secondary Category 2] (/[category-2])
│   ├── [Service C] (/[category-2]/[service-c])
│   └── ...
│
├── [Core Service 1] (/[core-service-1]) — high-profit services get their own hub
│   ├── [Sub-service] (/[core-service-1]/[sub-service])
│   └── ...
│
├── [Core Service 2] (/[core-service-2])
│   └── ...
│
├── General Services (/services) — services that don't fit a category
│
├── Service Areas (/areas)
│   └── ...
│
├── About (/about)
├── Reviews (/reviews)
└── Contact (/contact)
```

**Key principles:**
- Homepage = GBP landing page. Target your primary GBP category + city.
- Create 4-5 secondary category pages matching your GBP secondary categories. Most businesses only use 1-2 GBP categories — using 4-5 is an advantage.
- Each category page links to its child service pages. Each service page links back to its parent category and to the homepage.
- "Core services" (highest-profit services the business wants to rank for) get their own hub pages with child sub-service pages to build concentrated topical authority.
- Internal linking follows the hierarchy: homepage ↔ category ↔ service pages. This mirrors GBP's structure and reinforces topical signals.

**When to use this vs. the flat structure:** Use GBP-mirroring when the business has 4+ distinct service categories and 15+ individual services. For simpler businesses with fewer services, the flat /services/[service] structure is fine.

## Homepage / GBP Landing Page Content

For most local businesses, the homepage IS the GBP landing page. This is the single most important page on the site.

**Opening paragraph (goal completion):** The first paragraph must immediately address what the visitor is looking for and include a CTA. Do NOT open with "We are a family-owned business with 20 years of experience" — nobody cares about that in the opening. Talk to the user about their problem and your solution. Business credentials belong further down the page.

**Goal completion principle:** Google tracks whether visitors quickly find what they came for. A visitor who bounces back to search results signals to Google that the page didn't satisfy their intent. Structure the homepage so the answer to "who can help me with [service] in [city]?" is immediately visible with a phone number or booking CTA.

**H2 structure:** Use H2s for each secondary category / core service. Each H2 links to the corresponding category or service page. This creates a natural table of contents and clear internal linking from the homepage.

## Architecture Rules

- Flat structure: every page within 3 clicks of homepage
- One page per distinct service (not a combined services page)
- Service area pages ONLY for cities with genuine unique local content
- Do NOT create thin service area pages that just swap city names — Google penalizes these
- Quality gate: Warning at 30+ location pages, hard stop at 50+ without audit
- Internal linking: every service page links to related services + relevant area pages

## Internal Linking Strategy — Topic Silos

In-content links (anchor text within body paragraphs) carry significantly more weight than navigation menu links. Build topic silos by interlinking related service pages:
- Group services into clusters that mirror GBP categories (e.g., all drainage services interlink, all bathroom remodeling services interlink)
- Each cluster's pages link to each other with descriptive anchor text
- Each cluster links back to its parent category page (if using GBP-mirroring architecture) or the main services page
- Cross-link between clusters where relevant
- The hierarchy should flow: homepage ↔ category pages ↔ individual service pages — matching the structure in your GBP listing

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
