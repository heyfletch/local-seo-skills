# Google Analytics Integration Design

**Date:** 2026-02-27
**Status:** Approved

## Overview

Add GA4 and GSC MCP integrations to the local-seo-skills plugin. Both are optional — skills gracefully skip analytics when MCPs aren't configured or client property IDs are missing.

## MCP Selections

### GA4: googleanalytics/google-analytics-mcp (Official Google)

- **Repo:** https://github.com/googleanalytics/google-analytics-mcp
- **Stars:** 1,400+ | **License:** Apache 2.0
- **Auth:** Service account via Application Default Credentials (ADC)
- **Multi-property:** YES — `get_account_summaries` discovers all accessible properties dynamically; `run_report` accepts property as a parameter
- **Install:** `pipx run analytics-mcp` (no clone needed)
- **Tools:** 6-7 (get_account_summaries, get_property_details, run_report, run_realtime_report, get_custom_dimensions_and_metrics, list_google_ads_links)
- **Env vars:** `GOOGLE_APPLICATION_CREDENTIALS`, `GOOGLE_CLOUD_PROJECT`

**Why this over the alternatives:**
- Stape hosted MCP: OAuth-only, no service account support — disqualified
- surendranb/google-analytics-mcp: Single `GA4_PROPERTY_ID` env var, can't dynamically switch properties — unsuitable for multi-client

### GSC: AminForou/mcp-gsc

- **Repo:** https://github.com/AminForou/mcp-gsc
- **Stars:** 441 | **License:** MIT
- **Auth:** Service account JSON key with `GSC_SKIP_OAUTH=true`
- **Multi-property:** YES — add service account email as user in each GSC property; `list_properties` discovers all
- **Install:** Clone repo, create venv, `pip install -r requirements.txt`
- **Tools:** 19 (list_properties, get_search_analytics, inspect_url_enhanced, check_indexing_issues, get_sitemaps, submit_sitemap, compare_search_periods, batch_url_inspection, etc.)
- **Env vars:** `GSC_CREDENTIALS_PATH` (points to same service account JSON), `GSC_SKIP_OAUTH=true`

**Why this over the alternatives:**
- Composio GSC: OAuth-only, paid platform dependency, only 6 tools — disqualified

### GBP: Roadmap Item

No mature standalone GBP MCP servers exist. Best future option is n8n-based MCP server (9 operations: post CRUD + review reading/replying) leveraging existing self-hosted n8n infrastructure. Requires GBP API approval from Google.

## Plugin .mcp.json Config

```json
{
  "mcpServers": {
    "dataforseo": {
      "command": "npx",
      "args": ["-y", "dataforseo-mcp-server"],
      "env": {
        "DATAFORSEO_USERNAME": "${DATAFORSEO_USERNAME}",
        "DATAFORSEO_PASSWORD": "${DATAFORSEO_PASSWORD}"
      }
    },
    "ga4": {
      "command": "pipx",
      "args": ["run", "analytics-mcp"],
      "env": {
        "GOOGLE_APPLICATION_CREDENTIALS": "${GOOGLE_APPLICATION_CREDENTIALS}",
        "GOOGLE_CLOUD_PROJECT": "${GOOGLE_CLOUD_PROJECT}"
      }
    },
    "gsc": {
      "command": "python3",
      "args": ["-m", "mcp_gsc"],
      "env": {
        "GSC_CREDENTIALS_PATH": "${GOOGLE_APPLICATION_CREDENTIALS}",
        "GSC_SKIP_OAUTH": "true"
      }
    }
  }
}
```

All three MCPs use environment variables — no secrets in the repo. The same `GOOGLE_APPLICATION_CREDENTIALS` env var serves both GA4 and GSC.

## Client Profile Changes

Add `ga4_property_id` and `gsc_site_url` to the existing profile.md YAML frontmatter:

```yaml
slug: ""
name: ""
website: ""
gbp_url: ""
industry: ""
ga4_property_id: ""    # e.g., "properties/123456789"
gsc_site_url: ""       # e.g., "https://example.com/" or "sc-domain:example.com"
created: ""
deliverables_completed: []
```

- Client management skill asks for these during profile creation (Step 3 auto-discover or Step 5 write profile)
- Empty values = skip analytics gracefully — no error, no user prompt
- Values can be added/updated later via `/client [slug]` view mode

## Skills That Get Analytics Integration

Only 3 of 9 client-facing skills pull live analytics data:

### Audit Skill
- **GSC:** Indexing issues, top pages by clicks, crawl errors, sitemap status
- **GA4:** Traffic overview (sessions, users, pageviews), top landing pages, bounce rates
- **Use:** Establishes baseline metrics for the audit scorecard

### Plan Skill
- **GSC:** Keyword positions/impressions, top queries, click-through rates
- **GA4:** Traffic trends over time, conversion data, channel breakdown
- **Use:** Feeds into keyword strategy, identifies quick wins, informs 90-day roadmap priorities

### Content Skill
- **GSC:** Top queries already ranking (positions 5-20 = opportunity zone), pages with impressions but low clicks
- **GA4:** Page performance by traffic, time on page, engagement rates
- **Use:** Content gap analysis, topic selection, identifies underperforming content to refresh

### Integration Pattern (shared by all 3 skills)

1. Phase 0 loads client profile (existing behavior)
2. After Phase 0, extract `ga4_property_id` and `gsc_site_url` from frontmatter
3. If populated AND the MCP is responding → pull relevant data
4. If empty or MCP unavailable → skip silently, continue with WebSearch/manual data
5. Cache results: save analytics snapshot to `[client-path]/analytics/` so repeat runs don't re-query

### Skills That Do NOT Get Analytics

- **service-page, area-page, gbp, schema, reviews, agency** — these are content generation / strategy skills that don't benefit from live analytics data. They use the profile context (services, areas, competitors) which is already available.

## Prerequisites Doc

Extend existing `references/prerequisites.md` with comprehensive setup instructions:

1. Create GCP project and enable GA4 Data API + Search Console API
2. Create service account + download JSON key
3. Place key file (user chooses path, default `~/.config/gcloud/service-account.json`)
4. Set environment variables in `~/.zshrc`
5. Grant Viewer access in each client's GA4 property (Admin > Property Access Management)
6. Add service account email to each client's GSC property (Settings > Users and permissions)
7. Install GSC MCP dependencies (clone repo, venv, pip install)
8. Verify connections with test commands

## README.md Roadmap

Add `## Roadmap` section:

- [ ] Google Business Profile MCP integration (n8n-based or standalone when available)
- [ ] NeuronWriter API connection for content writing assistance
- [ ] Per-skill analytics dashboards (HTML reports with GA4/GSC trend charts)
- [ ] Automated monthly reporting pipeline

## Data Flow Summary

```
User runs /audit for Client X
  → Phase 0: Load client profile.md
  → Extract ga4_property_id: "properties/123456789"
  → Extract gsc_site_url: "https://clientx.com/"
  → GA4 MCP: run_report(property="properties/123456789", metrics=[sessions, users, bounceRate], dateRange=last90days)
  → GSC MCP: get_search_analytics(siteUrl="https://clientx.com/", dimensions=[query, page], dateRange=last90days)
  → Cache results to [client-path]/analytics/2026-02-27-audit-snapshot.md
  → Proceed with audit using real data instead of estimates
```

## Decisions Log

| Decision | Choice | Rationale |
|---|---|---|
| GA4 MCP | Official Google (googleanalytics/google-analytics-mcp) | Service account auth, multi-property, 1.4K stars, Google-maintained |
| GSC MCP | AminForou/mcp-gsc | Service account auth, 19 tools, 441 stars, most comprehensive |
| GBP MCP | Deferred to roadmap | No mature options; n8n-based solution noted for future |
| MCP requirement level | Optional | Matches existing DataForSEO/Ahrefs pattern; skills fall back gracefully |
| Client config format | Profile.md frontmatter | Existing pattern; skills already read profile in Phase 0 |
| Analytics skills | audit, plan, content | Only skills that directly benefit from live traffic/ranking data |
| Key file location | User chooses during setup, default ~/.config/gcloud/ | Flexible; prerequisites doc guides the choice |
