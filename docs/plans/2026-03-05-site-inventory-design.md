# Site Inventory System Design

## Problem
Skills recommend creating pages that already exist on the client's site because no skill has awareness of existing pages. The plan skill recommended "create in-home dog training page" when `/at-home-dog-training/` already existed.

## Solution
Crawl and catalog every page on a client's site during onboarding. Store metadata for all pages and full markdown content for priority pages. All downstream skills consume this inventory.

## Storage Structure

```
[client-path]/site-inventory/
├── metadata.md          # Single table: every page with type, title, meta, H1, schema, words, robots
├── pages/               # Full markdown content for priority pages
│   ├── homepage.md
│   ├── at-home-dog-training.md
│   ├── puppy-classes.md
│   └── round-rock.md
└── crawl-log.md         # When crawled, source, stats, errors
```

### metadata.md format
Single table sorted by type: Home, Core, Service, Area, Blog, Other.

| Type | URL | Title | Meta Description | H1 | Schema | Words | Robots | Content |
|------|-----|-------|-----------------|-----|--------|-------|--------|---------|

- Content column: `[view](pages/slug.md)` for full-crawl pages, `—` for metadata-only

### Profile quick-reference
The `## Existing Site Pages` section in profile.md becomes a pointer + condensed table (Type, URL, Title only).

## Crawl Tiers (Category-Based)

| Type | Full content download | Metadata extraction |
|------|----------------------|-------------------|
| Home | Yes | Yes |
| Core (about, contact, FAQ) | No | Yes |
| Service | Yes | Yes |
| Area | Yes | Yes |
| Blog | No | Yes |
| Other | No | Yes |

## Crawl Process

### Phase 1: Discover URLs
1. WebFetch `[website]/sitemap.xml` → `sitemap_index.xml` → GSC `get_sitemaps` → homepage nav crawl
2. Categorize URLs into Home/Core/Service/Area/Blog/Other
3. Present to user for confirmation

### Phase 2: Crawl & Extract
1. WebFetch each page
2. Extract: title, meta description, H1, schema types (from JSON-LD), word count, robots directives, internal links
3. For full-content types (Home, Service, Area): save markdown to `pages/[slug].md`
4. Write `metadata.md` and `crawl-log.md`

### Re-crawl
- Single page: skills can update a page's metadata after optimizing it
- Full refresh: `/client refresh-inventory` (future)

## Skill Integration

Shared reference file: `references/site-inventory-integration.md`

| Skill | Reads | Uses For |
|---|---|---|
| plan | Full metadata table | Cross-reference before recommending pages |
| audit | Full metadata + page content | Title/meta/H1/schema checks, gap detection, thin content |
| content | Full metadata | Content gaps, refresh scheduling, cannibalization prevention |
| service-page | Metadata row + page content | Duplication check, current content for optimization |
| area-page | Metadata row + page content | Duplication check, current content for optimization |
| schema | Schema column | Coverage audit, identify pages needing schema |
| gbp | Service page URLs | Link GBP services to correct pages |
| review-responder | Service/area titles | Keyword candidates without WebFetch |
