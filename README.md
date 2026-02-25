# Local SEO Plugin for Claude Code

A comprehensive local SEO toolkit with 8 specialized skills and 8 slash commands for Claude Code. Built for digital marketing consultants serving local/service-area businesses (professional services, healthcare, home services, etc.).

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
