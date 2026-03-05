# Local SEO Plugin for Claude Code

A comprehensive local SEO toolkit with 12 specialized skills and 12 slash commands for Claude Code. Built for digital marketing consultants serving local/service-area businesses (professional services, healthcare, home services, etc.).

## Installation

```bash
claude plugin marketplace add heyfletch/local-seo-skills
claude plugin install local-seo@heyfletch-local-seo-skills
```

## Updating

```bash
claude plugin update local-seo@heyfletch-local-seo-skills
```

## Getting Started

New to the plugin? Follow these steps to go from zero to a full client SEO workspace.

### 1. Set up data integrations

Before your first client, configure the data sources the skills pull from:

```bash
# Required: DataForSEO API (SERP data, keyword research, backlinks)
echo 'export DATAFORSEO_USERNAME="your_username"' >> ~/.zshrc
echo 'export DATAFORSEO_PASSWORD="your_password"' >> ~/.zshrc
source ~/.zshrc
```

**Optional but recommended:** Set up Google Analytics 4 and Search Console for live traffic and ranking data. See [references/prerequisites.md](references/prerequisites.md) for the full walkthrough (GCP project, service account, API enablement).

### 2. Create a client profile

```
/local-seo:client new
```

This runs an interactive interview that:
- Discovers the business (website, GBP, services, service areas, competitors)
- Connects GA4 and GSC (if you have property IDs)
- Imports scope documents (SOW/proposal)
- Creates a `dashboard.html` you can share with the client

Everything is saved to a single folder (the "client path") that all other skills read from.

### 3. Run an audit

```
/local-seo:audit
```

Select the client when prompted. The audit pulls data from DataForSEO, GA4, GSC, and Ahrefs (if configured), then generates a scored HTML report saved to the client's `deliverables/` folder. The dashboard updates automatically with KPIs and the audit card.

### 4. Build a strategic plan

```
/local-seo:plan
```

Uses the audit findings + client profile to produce a keyword strategy, site architecture, and 90-day action roadmap. Saved to `deliverables/` and added to the dashboard.

### 5. Create pages and content

```
/local-seo:service-page    # SEO-optimized service page
/local-seo:area-page       # Location/city page with unique content
/local-seo:content          # Content calendar (blog, GBP posts, social)
```

Each skill reads the plan's keyword research and site architecture so pages target the right terms.

### 6. Optimize GBP and reviews

```
/local-seo:gbp              # GBP posts, Q&A strategy, profile optimization
/local-seo:reviews           # Review generation system, response templates
```

### 7. Check the dashboard

Open `[client-path]/dashboard.html` in a browser at any time. It shows:
- SEO score, Google rating, and domain authority at a glance
- Every completed deliverable with direct links
- Activity log of all work done
- Quick links to the live site, Search Console, and GA4

You can send this dashboard directly to your client as a progress report.

---

## Commands

| Command | Description |
|---|---|
| `/local-seo:client` | Set up, view, or manage client profiles |
| `/local-seo:audit` | Run a comprehensive local SEO audit |
| `/local-seo:plan` | Create strategic SEO plan with site architecture and 90-day roadmap |
| `/local-seo:service-page` | Build an SEO-optimized service page |
| `/local-seo:area-page` | Build a unique service area/location page |
| `/local-seo:gbp` | Optimize Google Business Profile, posts, Q&A |
| `/local-seo:schema` | Generate JSON-LD schema markup |
| `/local-seo:reviews` | Create review strategy, templates, monitoring |
| `/local-seo:review-responder` | Draft individual review responses with voice matching |
| `/local-seo:content` | Plan content strategy, calendar, blog topics |
| `/local-seo:agency` | Package, price, sell, and deliver local SEO as an agency or freelancer |
| `/local-seo:ingest-insights` | Process inbox items and sync new knowledge into plugin skills |

## Skills (Auto-Activate)

Skills activate automatically based on context. Ask about any local SEO topic and the relevant skill triggers.

| Skill | Triggers On |
|---|---|
| `client-management` | "set up a client", "create a client profile", "manage clients" |
| `local-seo-audit` | "audit my local SEO", "GBP audit", "local visibility report" |
| `local-seo-plan` | "SEO roadmap", "keyword strategy", "what pages should I create" |
| `local-seo-service-page` | "write a service page", "create a page for [service]" |
| `local-seo-area-page` | "create a page for [city]", "location page", "areas we serve" |
| `local-seo-gbp` | "optimize GBP", "Google Maps listing", "GBP posts" |
| `local-seo-schema` | "schema markup", "structured data", "JSON-LD" |
| `local-seo-reviews` | "get more reviews", "respond to this review", "review strategy" |
| `local-seo-review-responder` | "respond to a review", "draft a review response", "reply to this Google review" |
| `local-seo-content` | "content calendar", "blog topics", "what should I blog about" |
| `local-seo-agency` | "SEO agency pricing", "how to sell SEO", "local SEO packages", "how to get SEO clients" |
| `ingest-insights` | "ingest new info", "process inbox", "sync new knowledge", "update skills with new info" |

## Data Integrations

### DataForSEO (included)

The plugin ships with a DataForSEO MCP server config for SERP rankings, keyword data, Google Maps listings, GBP data, backlinks, and on-page auditing.

**Setup:**

1. Get API credentials at [dataforseo.com](https://dataforseo.com/?aff=182890) ($50 minimum, pay-as-you-go, credits never expire, affiliate link)
2. Add credentials to your shell profile (`~/.zshrc`):
   ```bash
   echo 'export DATAFORSEO_USERNAME="your_username"' >> ~/.zshrc
   echo 'export DATAFORSEO_PASSWORD="your_password"' >> ~/.zshrc
   source ~/.zshrc
   ```
3. The MCP server starts automatically when the plugin loads.

> **Verify setup:** Run `echo $DATAFORSEO_USERNAME` in your terminal — it should print your username. If it returns blank, re-run `source ~/.zshrc` or restart your terminal. The MCP server will fail silently if credentials are not set.

### Ahrefs (optional)

If you have the Ahrefs MCP server configured separately, the skills will use both DataForSEO and Ahrefs for richer data.

### Google Analytics 4 (optional)

If you have a GCP service account with GA4 access, the audit, plan, and content skills pull live traffic data automatically.

**Setup:** See `references/prerequisites.md` for the full setup guide (GCP project, service account, API enablement, per-client access).

**Environment variables:**
```bash
export GOOGLE_APPLICATION_CREDENTIALS="~/.config/gcloud/service-account.json"
export GOOGLE_CLOUD_PROJECT="your-gcp-project-id"
```

### Google Search Console (optional)

If you have a GCP service account with GSC access, the audit, plan, and content skills pull keyword rankings and indexing data automatically.

**Setup:** Same service account as GA4. See `references/prerequisites.md`. Also requires cloning the GSC MCP server:

```bash
git clone https://github.com/AminForou/mcp-gsc.git /usr/local/share/mcp-gsc
cd /usr/local/share/mcp-gsc && python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt
```

## Configuration (Optional)

Customize output behavior by creating `.claude/local-seo.local.md` in your project:

```markdown
---
output_dir: ~/Desktop/
auto_open: true
---
```

| Setting | Default | Description |
|---|---|---|
| `output_dir` | `~/Desktop/` | Directory where reports and pages are saved |
| `auto_open` | `true` | Auto-open HTML files in browser after generation |

This file is optional — all settings have sensible defaults without it.

## Report Output

All analysis skills automatically generate HTML reports saved to `~/Desktop/` and auto-opened in the browser. No format selection needed — HTML is always the default.

| Template | Used By | Optimized For |
|---|---|---|
| **Report** (`html-report-template.html`) | Audit, Reviews, Agency, GBP | Score cards, priority lists, findings tables |
| **Plan** (`html-plan-template.html`) | Plan | Timeline sections, milestone markers, 90-day calendar grid |
| **Calendar** (`html-calendar-template.html`) | Content | Weekly grid layout, color-coded content types |

All templates share the same CSS design system (colors, fonts, print button) and include a "Save as PDF" button for client delivery. Terminal output is kept to a 3-5 bullet summary + file path.

## 2026 Local SEO Landscape

These skills incorporate the latest 2026 ranking factors:

- **GBP = 32%** of local pack ranking weight (still #1)
- **Reviews = 20%** of local pack (recency > volume)
- **AI Visibility** is now a third ranking "engine" alongside pack + organic
- **"Open Now"** status heavily impacts rankings
- **GBP Predefined Services** directly affect keyword rankings
- **Behavioral signals** (foot traffic, profile dwell time) rising
- **Backlink weight declining** for local pack in favor of real-world signals
- **Title tags** can be up to 270 characters (Google indexes hidden portion)
- **Thin service area pages** are penalized; unique local content required

## Roadmap

- [ ] **Google Business Profile MCP** — Live GBP data integration (n8n-based or standalone when a mature option emerges)
- [ ] **NeuronWriter API** — Content optimization scoring and keyword suggestions during content and service page writing
- [ ] **Per-skill analytics dashboards** — HTML reports with embedded GA4/GSC trend charts
- [ ] **Automated monthly reporting** — Scheduled analytics snapshots and client report generation

## Changelog

### 1.4.0
- Client dashboard: `/client` now generates a `dashboard.html` that tracks all deliverables, KPIs, and activity in one shareable page
- All skills auto-update the dashboard when saving deliverables (via shared Phase 3.5)
- Consolidated output: reports and data saved to a single `seo-data/` folder per client
- Added `/local-seo:client` and `/local-seo:review-responder` to README command tables
- Getting Started guide added to README

### 1.3.0
- Bump to 1.3.0

### 1.2.0
- Added review-responder skill with voice matching and keyword injection
- Cross-referenced review-responder from reviews skill

## License

MIT
