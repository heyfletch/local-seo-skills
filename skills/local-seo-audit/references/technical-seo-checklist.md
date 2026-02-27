# Technical SEO Checklist (Existing Sites)

## Context

Not every site is a fresh build. Existing sites may have accumulated technical issues — crawl errors, indexation problems, speed degradation, broken redirects, duplicate content. This checklist is for auditing existing sites where a complete rebuild is NOT planned.

**When to use this:** The audit skill's "Technical SEO deep dive (existing site)" scope option, or as part of a full audit when the site is staying as-is (not being rebuilt). Can optionally supplement the "On-Page + Technical only" scope for existing sites.

**When to skip:** If the site is being completely rebuilt on a new platform, skip detailed technical auditing — the rebuild will resolve these issues. Flag only major architectural or content problems that should carry into the new site.

## Crawlability & Indexation

### Robots.txt
- [ ] `robots.txt` exists and is accessible at `/robots.txt`
- [ ] Not blocking important pages or resources (CSS, JS, images)
- [ ] Sitemap URL declared in robots.txt
- [ ] Not accidentally blocking entire site (`Disallow: /`)
- [ ] Review for legacy disallow rules that may be outdated

### XML Sitemap
- [ ] XML sitemap exists and is submitted in GSC
- [ ] Sitemap is up to date (includes all live pages, excludes deleted/redirected pages)
- [ ] Sitemap URLs match canonical URLs (no www/non-www mismatches)
- [ ] Sitemap file size < 50MB, < 50,000 URLs per sitemap
- [ ] For large sites: sitemap index file with multiple child sitemaps
- [ ] Last modified dates are accurate (not all the same date)

### Indexation
- [ ] Check GSC Coverage/Pages report for errors, warnings, excluded pages
- [ ] `site:domain.com` search to estimate indexed pages vs expected pages
- [ ] Important pages are indexed (check GSC URL Inspection for priority pages)
- [ ] No accidental `noindex` tags on important pages
- [ ] Thin/duplicate pages are noindexed or canonicalized (not wasting crawl budget)
- [ ] Check for "Discovered — currently not indexed" and "Crawled — currently not indexed" in GSC — these indicate quality or crawl issues

### Crawl Errors
- [ ] Check GSC for 404 errors — fix or redirect pages with backlinks or traffic
- [ ] Check for soft 404s (pages returning 200 but showing error content)
- [ ] Server errors (5xx) — investigate root cause
- [ ] Crawl rate issues — is Googlebot being throttled or blocked?

## Site Speed & Core Web Vitals

### Core Web Vitals (CWV)
- [ ] **LCP (Largest Contentful Paint):** < 2.5 seconds (check both mobile and desktop)
- [ ] **INP (Interaction to Next Paint):** < 200ms
- [ ] **CLS (Cumulative Layout Shift):** < 0.1
- [ ] Check GSC Core Web Vitals report for page-level issues
- [ ] Test key pages with PageSpeed Insights (PSI)

### Common Speed Issues
- [ ] **Images:** Properly sized, compressed, using WebP/AVIF format, lazy-loaded below fold
- [ ] **Render-blocking resources:** CSS/JS in `<head>` blocking paint — defer or async where possible
- [ ] **Server response time (TTFB):** < 800ms — if slow, investigate hosting, caching, database
- [ ] **Third-party scripts:** Analytics, chat widgets, ad scripts adding load time — audit necessity
- [ ] **Caching:** Browser caching headers set, server-side caching enabled (LiteSpeed Cache, Redis, CDN)
- [ ] **CDN:** Using a CDN for static assets (CloudFlare, BunnyCDN, etc.)
- [ ] **Font loading:** Using `font-display: swap`, preloading critical fonts, limiting font files
- [ ] **Unused CSS/JS:** Remove or tree-shake unused code

### Mobile Performance
- [ ] Test on actual mobile devices (not just Chrome DevTools simulation)
- [ ] Mobile page speed score > 70 (ideal > 85)
- [ ] No horizontal scrolling
- [ ] Tap targets adequately sized (48x48px minimum)
- [ ] Text readable without zooming

## URL Structure & Redirects

### URL Health
- [ ] URLs are clean and descriptive (`/services/plumbing` not `/page?id=47`)
- [ ] No excessive URL parameters or session IDs in indexed URLs
- [ ] Consistent URL format (trailing slash or not — pick one, enforce via redirects)
- [ ] No uppercase characters in URLs (lowercase enforced via redirects)
- [ ] URL depth < 4 levels from root for important pages

### Redirects
- [ ] No redirect chains (A→B→C — should be A→C)
- [ ] No redirect loops
- [ ] Old URLs from previous site versions properly 301'd
- [ ] HTTP → HTTPS redirect in place and working
- [ ] www → non-www (or vice versa) redirect consistent
- [ ] Check for excessive 302 (temporary) redirects that should be 301 (permanent)
- [ ] Redirected pages not still appearing in XML sitemap

## Duplicate Content & Canonicalization

- [ ] `rel="canonical"` tags present on all pages
- [ ] Canonical tags point to the correct version (not self-referencing on wrong URL variant)
- [ ] No competing pages targeting the same keyword (cannibalization)
- [ ] www and non-www resolving to the same version
- [ ] HTTP and HTTPS not both serving content
- [ ] Pagination handled correctly (rel=canonical to first page, or self-canonical with proper indexation)
- [ ] Print versions, AMP versions, or parameter variants canonicalized
- [ ] Archive/tag/category pages in WordPress not creating thin duplicates — noindex if no unique value

## Security & HTTPS

- [ ] SSL certificate valid and not expiring soon
- [ ] All resources loaded over HTTPS (no mixed content warnings)
- [ ] Security headers present: HSTS, X-Content-Type-Options, X-Frame-Options
- [ ] No publicly accessible admin areas without authentication (wp-admin, phpmyadmin, etc.)
- [ ] WordPress/plugins updated to latest versions (or CMS equivalent)
- [ ] No known vulnerabilities in installed plugins (check WPScan or similar)

## Structured Data

- [ ] LocalBusiness schema on homepage (or relevant page)
- [ ] Service schema on service pages
- [ ] FAQPage schema where FAQs exist
- [ ] BreadcrumbList on all interior pages
- [ ] Schema validates in Google Rich Results Test (no errors, warnings are OK)
- [ ] No deprecated schema types (HowTo deprecated Sep 2023, FAQ restricted Aug 2023)
- [ ] Schema matches visible page content (don't mark up invisible content)

## WordPress-Specific Checks

(Skip if not WordPress)

- [ ] SEO plugin installed and configured (Yoast, RankMath, SEOPress)
- [ ] XML sitemap generated by SEO plugin (not conflicting with other sitemap plugins)
- [ ] Attachment pages disabled or redirected (Settings or via SEO plugin)
- [ ] Comment spam under control (Akismet or comments disabled)
- [ ] Revision history not bloating database (limit revisions in wp-config.php)
- [ ] Caching plugin configured (LiteSpeed Cache, WP Rocket, etc.)
- [ ] Object caching enabled (Redis, Memcached) if available on host
- [ ] PHP version current (8.1+ recommended)
- [ ] Database optimized (remove transients, spam comments, post revisions)
- [ ] REST API not leaking user information (author enumeration)

## International / Multi-Language

(Skip if single language, single country)

- [ ] `hreflang` tags correctly implemented if multi-language
- [ ] Language/region targeting set in GSC
- [ ] No auto-redirect based on IP/language (Google needs to crawl all versions)

## Priority Matrix for Technical Fixes

| Issue Type | Impact | Typical Effort |
|---|---|---|
| Blocked crawling (robots.txt, noindex) | Critical — pages can't rank if not indexed | Low (config change) |
| Broken redirects / chains | High — link equity lost | Low-Medium |
| Missing SSL / mixed content | High — trust + ranking signal | Low |
| Core Web Vitals failing | Medium — ranking factor, UX | Medium-High |
| Duplicate content / cannibalization | Medium — dilutes ranking signals | Medium |
| Missing schema markup | Medium — rich results, AI visibility | Low |
| Image optimization | Medium — speed, UX | Low-Medium |
| URL structure cleanup | Low-Medium — mostly cosmetic unless severe | High (requires redirects) |

**Rule:** Fix crawlability and indexation issues first — nothing else matters if Google can't find and index the pages. Then speed, then on-page technical, then nice-to-haves.
