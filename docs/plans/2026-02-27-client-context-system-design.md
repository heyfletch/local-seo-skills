# Client Context System — Design Document

**Date:** 2026-02-27
**Status:** Approved
**Scope:** Add persistent client data management across all local-seo skills

---

## Problem

Every skill starts blind — re-discovering the business from scratch each invocation via WebSearch + AskUserQuestion. Running `/audit` for BFP today and `/plan` for BFP tomorrow repeats the same discovery questions. No client context accumulates over time. Generated deliverables land on `~/Desktop/` with no connection back to the client.

## Solution Overview

A **client registry + external folder** system that gives every skill access to persistent client context. A new `/client` command handles setup, and all 9 client-facing skills gain a Phase 0 (client lookup) and Phase 3.5 (profile update offer).

### Design Principles

- **Quick mode is today's behavior** — nothing breaks, no regressions
- **Deliverable mode is additive** — more context in, smarter output, profile grows over time
- **User stays in control** — profile updates are offered, never forced
- **Flexible storage** — client folders live wherever the user wants

---

## 1. Client Registry

**File:** `references/clients/registry.md`

YAML frontmatter maps client slugs to their folder paths:

```yaml
---
clients:
  voorthuis:
    name: Voorthuis Schilders
    path: /Users/joe/Dropbox/Projects/Voorthuis/seo
  bfp:
    name: BFP Media
    path: /Users/joe/Dropbox/Projects/BFP/seo
---
```

- Machine-parseable via YAML frontmatter
- Freeform notes allowed below the frontmatter
- Gitignored (contains user-specific paths)

---

## 2. Client Folder Structure

Each client folder (at whatever path the user chooses):

```
[client-path]/
├── profile.md              # Core business context (the reusable brain)
├── work-log.md             # Dated entries from skill runs
└── deliverables/           # All outputs for this client
    ├── 2026-02-27-audit.html
    ├── 2026-03-01-plan.html
    └── ...
```

---

## 3. Client Profile Template

**File:** `references/client-profile-template.md`

```yaml
---
slug: ""
name: ""
website: ""
gbp_url: ""
industry: ""
created: ""
deliverables_completed: []
---
```

```markdown
# Client Context: [Business Name]

## Business Description
[Filled during interview or auto-discovered]

## ICP / Target Audience
[Who they serve, demographics, pain points]

## Services
[List of services offered]

## Service Areas
[Cities/regions served]

## Voice & Brand Guidelines
[Tone, style, terminology preferences]

## Competitors
[Top 3-5 with URLs]

## Current SEO Status
[Baseline metrics, known issues — updated after audits]
```

---

## 4. The `/client` Command

A new slash command for client setup and management.

### Usage

- `/client` — interactive: lists known clients, offers to create new or select existing
- `/client [slug]` — jump to that client's context (display summary, offer actions)
- `/client new` — start the interview for a new client

### New Client Interview Flow

1. "What's the client/business name?" (open text)
2. "Where should I store this client's data?" — suggest a default, let user type a custom path
3. Auto-discover via WebSearch: website, GBP, industry, services, competitors, service areas
4. Present findings, let user confirm/correct each section
5. "Do you want to set voice/brand guidelines now or skip for later?"
6. Write `profile.md`, create `deliverables/` folder, create `work-log.md`, add to registry
7. "Client profile created. You can now run any skill and it'll use this context."

### Existing Client Actions

When viewing an existing client:
- Update profile
- View work log
- List deliverables
- Run a skill for this client

---

## 5. Skill Integration — Phase 0 & Phase 3.5

### Phase 0: Client Context (new, before current Phase 1)

Added to all 9 client-facing skills (audit, plan, service-page, area-page, gbp, content, reviews, schema, agency):

```
1. Check command flags:
   - --quick → skip client lookup, run today's stateless flow
   - --deliverable → require client context (create if missing)
   - Neither → infer from context

2. Check registry (references/clients/registry.md):
   - If registry has clients → ask "Which client?" with options:
     [list of known clients] + "New client" + "No client (quick mode)"
   - If no registry or empty → ask "Want to create a client profile, or run in quick mode?"

3. If client selected:
   - Read profile.md from client path
   - Pre-populate discovery fields (website, GBP, industry, services, etc.)
   - Skip redundant Phase 1 questions — only ask task-specific ones
   - Set output dir to [client-path]/deliverables/

4. If quick mode:
   - Run exactly as today — full discovery, output to ~/Desktop/
```

### Inference Logic (no flags)

- Client profile exists and was recently used → deliverable mode
- No client profile → quick mode (with offer to create one)

### Phase 1 Changes When Client Context Exists

| Discovery Step | Without Client | With Client |
|---|---|---|
| Step 1: Identify business | Ask | **Skipped** (from profile) |
| Step 2: Auto-discover | Full WebSearch | **Skipped or minimal** (profile has data) |
| Step 3: Scope/specifics | Ask | **Still asked** (task-specific) |
| Step 4: Data tools | Ask | **Still asked** (session-specific) |

Discovery goes from ~6 questions to ~2.

### Phase 3.5: Client Profile Update (new, after current Phase 3)

Only when client context is active:

```
Ask: "Should I update the client profile with this work?"
- "Add summary to work log" → append dated entry to work-log.md
- "Save as reference doc" → save a summary .md in client folder
- "Both"
- "Skip"
```

---

## 6. Standard Deliverable Catalog

**File:** `references/client-deliverables.md`

A catalog of standard documents that can be generated for any client. Skills reference this list and suggest relevant documents after completing their work.

### Strategic Documents
- SEO & Digital Marketing Roadmap — comprehensive strategy guide
- Client Overview Presentation — executive summary for stakeholders
- Competitor Analysis Report — detailed competitive landscape

### Technical Documents
- Website Sitemap Spreadsheet — current page inventory + planned pages
- Schema Markup Package — all JSON-LD for the site
- Technical SEO Checklist — crawl issues, speed, mobile, etc.

### Content Documents
- Content Calendar — 3-month editorial plan
- Service Page Copy — all service pages
- Area Page Copy — all location/area pages
- GBP Post Calendar — monthly GBP posting plan
- Review Response Templates — response library

### How Skills Use This

After completing in deliverable mode, skills check the catalog and suggest related documents:
- After `/audit`: "Based on this audit, consider generating: Roadmap, Technical Checklist, Schema Package"
- After `/plan`: "This plan maps to: Client Overview Presentation, Sitemap Spreadsheet"
- Suggestions only — user decides.

### Tracking

The `profile.md` frontmatter tracks completed deliverables:

```yaml
deliverables_completed:
  - type: audit
    date: 2026-02-27
    path: deliverables/2026-02-27-audit.html
  - type: roadmap
    date: 2026-03-01
    path: deliverables/2026-03-01-roadmap.html
```

---

## 7. Quick vs. Deliverable Mode

| Aspect | Quick Mode (`--quick`) | Deliverable Mode (default w/ client) |
|---|---|---|
| Client lookup | Skipped | Phase 0 loads profile |
| Discovery | Full (ask everything) | Minimal (only task-specific questions) |
| Output quality | Same HTML quality | Same HTML quality |
| Output location | `~/Desktop/` (or output_dir) | `[client-path]/deliverables/` |
| Profile update | No | Asks after completion |
| Deliverable suggestions | No | Suggests related standard docs |
| Work log | No | Offered after completion |

### Flag Behavior

| Flags | Client exists? | Result |
|---|---|---|
| None | Yes | Deliverable mode (inferred) |
| None | No | Quick mode (offer to create client) |
| `--quick` | Either | Quick mode always |
| `--deliverable` | Yes | Deliverable mode |
| `--deliverable` | No | Create client, then deliverable mode |

---

## 8. Files to Create

| File | Purpose |
|---|---|
| `references/clients/registry.md` | Client slug → path mapping |
| `references/client-profile-template.md` | Empty profile template |
| `references/client-deliverables.md` | Standard deliverable catalog |
| `commands/client.md` | New `/client` slash command |
| `skills/client-management/SKILL.md` | Skill backing the `/client` command |

## 9. Files to Modify

| File | Change |
|---|---|
| All 9 skill SKILL.md files | Add Phase 0 (client lookup) and Phase 3.5 (profile update) |
| All 10 command .md files | Add `--quick` and `--deliverable` flag support |
| `plugin.json` | Add client-management skill reference |
| `.gitignore` | Add `references/clients/registry.md` (user-specific paths) |

---

## 10. What This Does NOT Change

- HTML template system — unchanged
- Report quality/formatting — unchanged
- MCP tool integration — unchanged
- ingest-insights skill — unchanged (it's about plugin knowledge, not client data)
- Self-improvement pattern — unchanged (but could later save approved examples per client)
