---
name: local-seo-schema
description: Generate and validate schema markup (structured data) for local businesses. Use when the user wants to add schema, structured data, JSON-LD, rich snippets, or any schema.org markup for a local business website. Also triggers for "schema for service page", "FAQ schema", "LocalBusiness schema", "structured data", "rich results", or optimizing for AI search visibility through structured data. Schema is critical in 2026 for feeding Google's Knowledge Graph and AI agents.
---

# Local SEO Schema Markup Skill

Generate valid JSON-LD schema markup for local businesses. In 2026, schema is the primary language for feeding structured data to Google's Knowledge Graph and AI search agents. It increases AI Overview citation chances by 40-60%.

## Schema Types by Page

| Page Type | Required Schema | Optional Schema |
|---|---|---|
| Homepage | LocalBusiness, Organization | AggregateRating |
| Service Page | Service, FAQPage | Offer, HowTo (if process-based) |
| Service Area Page | LocalBusiness (with areaServed) | FAQPage |
| About/Team | Person (for each team member) | Organization |
| Reviews Page | LocalBusiness + Review | AggregateRating |
| Blog Post | Article | FAQPage, HowTo |
| Contact Page | LocalBusiness | PostalAddress |
| FAQ Page | FAQPage | — |
| All pages (except homepage) | BreadcrumbList | — |

## Schema Deprecation Awareness (2026)

- **HowTo:** Deprecated September 2023 (still indexed but no rich results)
- **FAQ:** Restricted to government and health authority sites (August 2023) — still worth implementing for AI citation even without rich results
- **SpecialAnnouncement:** Deprecated July 2025

## Templates

### 1. LocalBusiness (Homepage)

Adjust `@type` for specific business type. Options: `ProfessionalService`, `FinancialService`, `LegalService`, `Dentist`, `Physician`, `Optician`, `Plumber`, `HomeAndConstructionBusiness`, etc.

```json
{
  "@context": "https://schema.org",
  "@type": "[SPECIFIC_BUSINESS_TYPE]",
  "name": "[Business Name]",
  "image": "[logo URL]",
  "description": "[Business description with primary keywords]",
  "@id": "[website URL]",
  "url": "[website URL]",
  "telephone": "+1[phone]",
  "priceRange": "$$",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "[street]",
    "addressLocality": "[city]",
    "addressRegion": "[state code]",
    "postalCode": "[zip]",
    "addressCountry": "US"
  },
  "geo": {
    "@type": "GeoCoordinates",
    "latitude": [lat],
    "longitude": [lng]
  },
  "openingHoursSpecification": [
    {
      "@type": "OpeningHoursSpecification",
      "dayOfWeek": ["Monday","Tuesday","Wednesday","Thursday","Friday"],
      "opens": "09:00",
      "closes": "17:00"
    }
  ],
  "sameAs": [
    "[facebook URL]",
    "[linkedin URL]",
    "[instagram URL]"
  ],
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "[rating]",
    "reviewCount": "[count]"
  },
  "hasOfferCatalog": {
    "@type": "OfferCatalog",
    "name": "Services",
    "itemListElement": [
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "[Service 1]"
        }
      },
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "[Service 2]"
        }
      }
    ]
  }
}
```

**For Service Area Businesses (hidden address):** OMIT the `address` property entirely. Instead add:

```json
"areaServed": [
  { "@type": "City", "name": "[City 1]" },
  { "@type": "City", "name": "[City 2]" },
  { "@type": "State", "name": "[State]" }
]
```

### 2. Service Schema (Service Pages)

```json
{
  "@context": "https://schema.org",
  "@type": "Service",
  "serviceType": "[Service Name]",
  "name": "[Service Name] in [City]",
  "description": "[Service description 1-2 sentences]",
  "provider": {
    "@type": "[SPECIFIC_BUSINESS_TYPE]",
    "name": "[Business Name]",
    "url": "[website URL]"
  },
  "areaServed": {
    "@type": "State",
    "name": "[State(s)]"
  },
  "hasOfferCatalog": {
    "@type": "OfferCatalog",
    "name": "[Service Category]",
    "itemListElement": [
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "[Sub-service 1]"
        }
      }
    ]
  }
}
```

### 3. FAQPage Schema

Implement on any page with FAQ sections. Still worth implementing for AI citation even though rich results are restricted.

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "[Question text]",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[Answer text — can include HTML links]"
      }
    },
    {
      "@type": "Question",
      "name": "[Question text]",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[Answer text]"
      }
    }
  ]
}
```

### 4. BreadcrumbList Schema (All pages except homepage)

```json
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "name": "Home",
      "item": "[homepage URL]"
    },
    {
      "@type": "ListItem",
      "position": 2,
      "name": "[Parent Page]",
      "item": "[parent URL]"
    },
    {
      "@type": "ListItem",
      "position": 3,
      "name": "[Current Page]",
      "item": "[current URL]"
    }
  ]
}
```

### 5. Review/AggregateRating Schema (Reviews Page)

```json
{
  "@context": "https://schema.org",
  "@type": "[SPECIFIC_BUSINESS_TYPE]",
  "name": "[Business Name]",
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "[rating]",
    "reviewCount": "[count]"
  },
  "review": [
    {
      "@type": "Review",
      "author": { "@type": "Person", "name": "[Reviewer Name]" },
      "datePublished": "[YYYY-MM-DD]",
      "reviewBody": "[Review text]",
      "reviewRating": { "@type": "Rating", "ratingValue": "5" }
    }
  ]
}
```

### 6. Person Schema (Team/About Pages)

```json
{
  "@context": "https://schema.org",
  "@type": "Person",
  "name": "[Full Name]",
  "jobTitle": "[Title]",
  "worksFor": {
    "@type": "[SPECIFIC_BUSINESS_TYPE]",
    "name": "[Business Name]"
  },
  "description": "[Bio summary]",
  "image": "[headshot URL]",
  "sameAs": ["[LinkedIn URL]"],
  "hasCredential": [
    {
      "@type": "EducationalOccupationalCredential",
      "credentialCategory": "[certification type]",
      "name": "[Certification Name]"
    }
  ]
}
```

### 7. Article Schema (Blog Posts)

```json
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "[Article Title]",
  "description": "[Meta description]",
  "author": {
    "@type": "Person",
    "name": "[Author Name]",
    "url": "[Author page URL]"
  },
  "publisher": {
    "@type": "Organization",
    "name": "[Business Name]",
    "logo": { "@type": "ImageObject", "url": "[logo URL]" }
  },
  "datePublished": "[YYYY-MM-DD]",
  "dateModified": "[YYYY-MM-DD]",
  "image": "[featured image URL]",
  "mainEntityOfPage": "[article URL]"
}
```

## Implementation Rules

1. **JSON-LD only** — Place in `<head>` of each page (recommended method)
2. **One LocalBusiness per location** — Don't duplicate across pages
3. **Don't markup invisible content** — Schema must reflect visible page content
4. **Don't fabricate reviews** — Only markup real reviews you actually have
5. **Validate before publishing** — Use Google Rich Results Test
6. **Multiple schemas per page is fine** — e.g., Service + FAQPage + BreadcrumbList on a service page
7. **Keep ratings current** — Update AggregateRating when review count changes

## Validation

Test all schema at: https://search.google.com/test/rich-results

Check Google Search Console > Enhancements for structured data issues after deployment.
