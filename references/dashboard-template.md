# Dashboard Template

Instructions for generating and updating the client SEO dashboard (`dashboard.html`).

## When to Generate

- **Initial creation:** During `/client` onboarding (Step 5.5)
- **Updates:** During Phase 3.5 of any deliverable-producing skill

## File Location

`[client-path]/dashboard.html` — always in the root of the client's seo-data folder, NOT inside deliverables/.

## Dashboard Sections

The dashboard has these sections in order:

### 1. Header
- Title: "SEO Dashboard"
- Business name and primary location
- "Prepared by Fletcher Digital" (or the user's agency name if different)
- "Last updated: [date]"

### 2. Hero KPIs (3 cards)
Initially empty placeholders. Populated after the first audit:
- **Overall SEO Score** — from audit (color: green >75, yellow 50-75, red <50)
- **Google Rating** — star rating + review count
- **Domain Authority** — DA score + backlink count

If no audit has been run yet, show placeholder cards with "Run /audit to populate" as the subtitle.

### 3. Deliverables Grid
Two-column grid of deliverable cards. Each card has:
- Icon (use inline SVG — no external dependencies)
- Title (e.g., "Local SEO Audit")
- Date completed
- Brief description (1 line)
- Badge: "Complete" (green) or link to the deliverable file

Only show completed deliverables. Do NOT show pending/upcoming placeholders — the dashboard should only reflect actual completed work.

### 4. Client Profile (left column) + Activity Log (right column)
Side by side:
- **Client Profile:** Business name, owner, industry, location, service areas, website link, plan/package
- **Activity Log:** Reverse-chronological list of work done (pulled from work-log.md entries). Show last 5-8 entries.

### 5. Quick Links
Horizontal row of small link buttons:
- Website (external link)
- Google Search Console (if `gsc_site_url` is set)
- Google Analytics (if `ga4_property_id` is set)

Only include links where the data exists in the profile. Do not show empty links.

### 6. Footer
"Prepared by Fletcher Digital" with contact info. Use data from the user's CLAUDE.md or hardcode Fletcher Digital as default.

## Inline Modals

For deliverables that are markdown-based (like voice-profile.md), render them as inline modals that open on click rather than linking to the raw .md file. This keeps the experience self-contained in the dashboard.

For HTML deliverables (like audit reports), link directly to the file in deliverables/.

## Styling Requirements

- Self-contained HTML — all CSS inline in a `<style>` tag. NO external stylesheets, NO JavaScript frameworks.
- Minimal JavaScript — only for modal open/close behavior.
- Color scheme: Navy primary (#1a365d), with green/yellow/red for status indicators.
- Responsive: works on mobile (single column) and desktop (multi-column grids).
- Print-friendly: `@media print` rules for clean output.
- Professional enough to send directly to a client.

## How to Update the Dashboard

When a skill completes and saves a deliverable (during Phase 3.5):

1. Read the existing `[client-path]/dashboard.html`
2. Find the `<!-- DELIVERABLES-START -->` and `<!-- DELIVERABLES-END -->` comment markers
3. Add a new deliverable card inside those markers with:
   - The deliverable type icon
   - Title matching the skill name
   - Today's date
   - 1-line description of what was produced
   - Link to the file in `deliverables/`
   - "Complete" badge
4. Update the "Last updated" date in the header
5. If this is an audit, also update the Hero KPI values
6. If there are new work-log entries, update the Activity Log section (between `<!-- ACTIVITY-START -->` and `<!-- ACTIVITY-END -->` markers)

## Deliverable Type Icons

Use these inline SVG icons for each deliverable type. All icons use a 22x22 viewBox with stroke-only rendering (no fill).

| Type | Stroke Color | CSS Class |
|------|-------------|-----------|
| Audit | #e67e22 (orange) | icon-audit |
| SEO Plan | #1a365d (navy) | icon-plan |
| Voice Profile | #27ae60 (green) | icon-voice |
| Content Calendar | #7c3aed (purple) | icon-content |
| Service Page | #e74c3c (red) | icon-page |
| Area Page | #e74c3c (red) | icon-page |
| Schema | #0ea5e9 (blue) | icon-schema |
| GBP | #f59e0b (amber) | icon-gbp |
| Reviews | #10b981 (emerald) | icon-review |
| Agency | #6366f1 (indigo) | icon-agency |

## Comment Markers

The generated HTML MUST include these comment markers for programmatic updates:

```html
<!-- HERO-KPIS-START -->
...hero KPI cards...
<!-- HERO-KPIS-END -->

<!-- DELIVERABLES-START -->
...deliverable cards...
<!-- DELIVERABLES-END -->

<!-- ACTIVITY-START -->
...activity log entries...
<!-- ACTIVITY-END -->
```

## Initial Dashboard (No Deliverables)

When first created during `/client` onboarding, the dashboard shows:
- Header with business name and date
- Hero KPIs with placeholder text ("Run /audit to populate")
- Empty deliverables section (just the section title, no cards)
- Client profile filled from the interview data
- Empty activity log with "No activity yet" message
- Quick links (whatever was collected during onboarding)
