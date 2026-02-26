# Local SEO Plugin for Claude Code

A comprehensive local SEO toolkit with 9 specialized skills and 9 slash commands for Claude Code. Built for digital marketing consultants serving local/service-area businesses (professional services, healthcare, home services, etc.).

## Installation

```bash
claude plugin add /path/to/local-seo-skills
```

Or for local testing:

```bash
claude --plugin-dir /path/to/local-seo-skills
```

## Commands

| Command | Description |
|---|---|
| `/local-seo:audit` | Run a comprehensive local SEO audit |
| `/local-seo:plan` | Create strategic SEO plan with site architecture and 90-day roadmap |
| `/local-seo:service-page` | Build an SEO-optimized service page |
| `/local-seo:area-page` | Build a unique service area/location page |
| `/local-seo:gbp` | Optimize Google Business Profile, posts, Q&A |
| `/local-seo:schema` | Generate JSON-LD schema markup |
| `/local-seo:reviews` | Create review strategy, templates, monitoring |
| `/local-seo:content` | Plan content strategy, calendar, blog topics |

## Skills (Auto-Activate)

Skills activate automatically based on context. Ask about any local SEO topic and the relevant skill triggers.

| Skill | Triggers On |
|---|---|
| `local-seo-audit` | "audit my local SEO", "GBP audit", "local visibility report" |
| `local-seo-plan` | "SEO roadmap", "keyword strategy", "what pages should I create" |
| `local-seo-service-page` | "write a service page", "create a page for [service]" |
| `local-seo-area-page` | "create a page for [city]", "location page", "areas we serve" |
| `local-seo-gbp` | "optimize GBP", "Google Maps listing", "GBP posts" |
| `local-seo-schema` | "schema markup", "structured data", "JSON-LD" |
| `local-seo-reviews` | "get more reviews", "respond to this review", "review strategy" |
| `local-seo-content` | "content calendar", "blog topics", "what should I blog about" |
| `local-seo-agency` | "SEO agency pricing", "how to sell SEO", "local SEO packages", "how to get SEO clients" |

## Data Integrations

### DataForSEO (included)

The plugin ships with a DataForSEO MCP server config for SERP rankings, keyword data, Google Maps listings, GBP data, backlinks, and on-page auditing.

**Setup:**

1. Get API credentials at [dataforseo.com](https://dataforseo.com) ($50 minimum, pay-as-you-go, credits never expire)
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

## Report Output

Reports save to `~/Desktop/` in your choice of format:

| Format | Best For |
|---|---|
| **HTML** (default) | Client delivery — professional report with print-to-PDF button |
| **Markdown** | Quick reference, internal use |
| **PDF** | Email attachments — generated from HTML via wkhtmltopdf or browser print |

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

## License

MIT
