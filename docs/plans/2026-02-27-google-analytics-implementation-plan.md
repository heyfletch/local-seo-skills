# Google Analytics Integration Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add optional GA4 and GSC MCP integrations to the local-seo-skills plugin with per-client property config and graceful fallback.

**Architecture:** Two new MCP servers (ga4, gsc) in `.mcp.json` using env vars for a shared GCP service account. Per-client GA4 property IDs and GSC site URLs stored in existing profile.md frontmatter. Three skills (audit, plan, content) get a new "Phase 0.5: Analytics" step that pulls live data when available and caches it. All other skills unchanged.

**Tech Stack:** Google Analytics Data API (official MCP), Google Search Console API (mcp-gsc), YAML frontmatter in markdown profiles.

---

### Task 1: Update .mcp.json with GA4 and GSC servers

**Files:**
- Modify: `.mcp.json`

**Step 1: Edit .mcp.json**

Replace the entire file with:

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
      "args": ["/usr/local/share/mcp-gsc/gsc_server.py"],
      "env": {
        "GSC_CREDENTIALS_PATH": "${GOOGLE_APPLICATION_CREDENTIALS}",
        "GSC_SKIP_OAUTH": "true"
      }
    }
  }
}
```

Notes:
- GA4 uses `pipx run analytics-mcp` (auto-installs, no clone needed)
- GA4 env var is `GOOGLE_CLOUD_PROJECT` (not `GOOGLE_PROJECT_ID` — confirmed from official repo)
- GSC uses an absolute path to `gsc_server.py` — the prerequisites doc will tell users where to clone it. The path `/usr/local/share/mcp-gsc/` is the recommended default (user can change it). The env var `GSC_CREDENTIALS_PATH` points to the same service account JSON as GA4.
- Both GA4 and GSC share the same `GOOGLE_APPLICATION_CREDENTIALS` env var.

**Step 2: Commit**

```bash
git add .mcp.json
git commit -m "Add GA4 and GSC MCP server configs to plugin"
```

---

### Task 2: Update client profile template with analytics fields

**Files:**
- Modify: `references/client-profile-template.md`

**Step 1: Add frontmatter fields**

Add `ga4_property_id` and `gsc_site_url` to the YAML frontmatter, after `gbp_url` and before `industry`:

```yaml
---
slug: ""
name: ""
website: ""
gbp_url: ""
ga4_property_id: ""
gsc_site_url: ""
industry: ""
created: ""
deliverables_completed: []
---
```

No other changes to the template body.

**Step 2: Commit**

```bash
git add references/client-profile-template.md
git commit -m "Add ga4_property_id and gsc_site_url to client profile template"
```

---

### Task 3: Update client management skill to collect analytics IDs

**Files:**
- Modify: `skills/client-management/SKILL.md`

**Step 1: Add analytics collection to Step 3 (auto-discover)**

After the existing auto-discover items in Step 3 (line ~79, after "Top 3-5 competitors"), add:

```markdown
- GA4 Property ID (if the user has GA4 configured for this client)
- GSC Site URL (the verified property URL in Search Console)
```

**Step 2: Add analytics question after Step 4 (ICP and brand)**

Insert a new Step 4.25 between Step 4 and Step 4.5:

```markdown
### Step 4.25: Analytics connections (optional)

Use AskUserQuestion:
**Question:** "Do you have Google Analytics and Search Console set up for this client?"
- "Yes — I'll provide the property IDs"
- "Not yet — skip for now"

If yes, ask two follow-up questions:

**Question:** "What's the GA4 Property ID? (Find it in GA4 > Admin > Property Settings — looks like 'properties/123456789')"
- Open text input

**Question:** "What's the GSC Site URL? (Find it in Search Console > Settings > Property — looks like 'https://example.com/' or 'sc-domain:example.com')"
- Open text input

Store these in the profile frontmatter as `ga4_property_id` and `gsc_site_url`. If the user skips, leave the fields empty.
```

**Step 3: Update Step 5 (write profile) frontmatter list**

In Step 5, item 3, update the frontmatter field list to include the new fields:

```markdown
3. Set the YAML frontmatter: slug, name, website, gbp_url, ga4_property_id, gsc_site_url, industry, created date
```

**Step 4: Commit**

```bash
git add skills/client-management/SKILL.md
git commit -m "Add analytics ID collection to client management skill"
```

---

### Task 4: Create shared analytics reference doc

**Files:**
- Create: `references/analytics-integration.md`

**Step 1: Write the analytics integration reference**

```markdown
# Analytics Integration

Shared instructions for Phase 0.5 (Analytics Data). Referenced by audit, plan, and content skills.

---

## Phase 0.5: Analytics Data

Run this phase AFTER Phase 0 (Client Context) and BEFORE Phase 1 (Discovery). Only runs when client context is active (mode = deliverable) AND the client profile has non-empty `ga4_property_id` or `gsc_site_url` fields.

### Skip conditions

Skip this entire phase if ANY of these are true:
- Mode is **quick** (no client context)
- Both `ga4_property_id` and `gsc_site_url` are empty in the profile
- The user passed `--quick` flag

### Step 1: Check MCP availability

For each non-empty property ID, attempt a lightweight MCP call:

**GA4 check:** Call `get_account_summaries` via the ga4 MCP.
- If it responds → GA4 is available
- If it fails or times out → set `ga4_available = false`, continue without GA4

**GSC check:** Call `list_properties` via the gsc MCP.
- If it responds → GSC is available
- If it fails or times out → set `gsc_available = false`, continue without GSC

If BOTH fail, inform the user briefly ("GA4/GSC MCPs not responding — continuing without analytics data") and proceed to Phase 1. Do NOT block the workflow.

### Step 2: Pull analytics data

Pull data based on which skill is running. Use the property IDs from the client profile frontmatter.

**For audit skill:**

GA4 (if available):
- `run_report` with property=`ga4_property_id`, metrics=[sessions, totalUsers, bounceRate, averageSessionDuration, screenPageViews], dateRanges=[last 90 days], dimensions=[date] (monthly aggregation)
- `run_report` with property=`ga4_property_id`, metrics=[sessions, screenPageViews], dimensions=[landingPage], orderBys=[sessions DESC], limit=20

GSC (if available):
- `get_search_analytics` with siteUrl=`gsc_site_url`, dimensions=[query], dateRange=last 90 days, rowLimit=50
- `get_search_analytics` with siteUrl=`gsc_site_url`, dimensions=[page], dateRange=last 90 days, rowLimit=30
- `check_indexing_issues` with siteUrl=`gsc_site_url`

**For plan skill:**

GA4 (if available):
- `run_report` with property=`ga4_property_id`, metrics=[sessions, totalUsers, conversions], dateRanges=[last 90 days], dimensions=[date] (monthly)
- `run_report` with property=`ga4_property_id`, metrics=[sessions], dimensions=[sessionDefaultChannelGroup]

GSC (if available):
- `get_search_analytics` with siteUrl=`gsc_site_url`, dimensions=[query], dateRange=last 90 days, rowLimit=100 (keyword positions for strategy)
- `get_search_analytics` with siteUrl=`gsc_site_url`, dimensions=[query, page], dateRange=last 90 days, rowLimit=50

**For content skill:**

GA4 (if available):
- `run_report` with property=`ga4_property_id`, metrics=[sessions, screenPageViews, averageSessionDuration], dimensions=[pagePath], orderBys=[sessions DESC], limit=30

GSC (if available):
- `get_search_analytics` with siteUrl=`gsc_site_url`, dimensions=[query], dateRange=last 90 days, rowLimit=100 (what queries already rank)
- `get_search_analytics` with siteUrl=`gsc_site_url`, dimensions=[page], dateRange=last 90 days, rowLimit=50 (which pages perform)

### Step 3: Cache results

Save a snapshot to `[client-path]/analytics/YYYY-MM-DD-[skill]-snapshot.md`:

```markdown
# Analytics Snapshot: [Business Name]
**Date:** YYYY-MM-DD
**Skill:** [skill name]

## GA4 Summary (last 90 days)
[Key metrics in a table]

## GSC Summary (last 90 days)
[Top queries, top pages, indexing issues in tables]
```

Create the `[client-path]/analytics/` directory if it doesn't exist.

This cache serves two purposes:
1. Subsequent runs of the same skill can check for a recent snapshot (< 7 days old) and reuse it instead of re-querying
2. Other skills can reference the snapshot for context without needing their own MCP calls

### Step 4: Carry into Phase 1

Pass the analytics data into Phase 1 alongside the client context. Skills should:
- Use real traffic numbers instead of estimates
- Use actual keyword positions instead of guesses
- Use real indexing issues instead of hypothetical checks
- Reference specific pages and queries from the data

### How Phase 1 changes with analytics data

When analytics data is available, modify Phase 1 as follows:
- **Data tools question (Step 4 in audit):** Still ask, but note that GA4/GSC data has already been pulled. Ahrefs and DataForSEO provide complementary data (backlinks, SERP features, competitor metrics) that GA4/GSC don't cover.
- **Information needed list:** Cross-reference with analytics data. "Current monthly organic traffic" is now answered by GA4. "Top performing pages" is answered by GSC. Only ask the user for items that analytics didn't cover.
```

**Step 2: Commit**

```bash
git add references/analytics-integration.md
git commit -m "Add shared analytics integration reference for Phase 0.5"
```

---

### Task 5: Add Phase 0.5 to audit skill

**Files:**
- Modify: `skills/local-seo-audit/SKILL.md`

**Step 1: Add Phase 0.5 reference**

After the Phase 0 section (after line ~35, after "All business context is pre-populated from the profile"), add:

```markdown
---

## Phase 0.5: Analytics Data

Follow the instructions in [references/analytics-integration.md](../../references/analytics-integration.md) — "For audit skill" section.

If analytics data is available:
- Phase 2 Category H (Analytics & ROI Tracking) uses real GA4 data instead of asking the user
- Phase 2 Categories A-G use GSC indexing/ranking data to verify findings
- "Current monthly organic traffic" in the information needed list is pre-filled from GA4
```

**Step 2: Update the "Information needed" list**

In Phase 1, update the information needed item on line ~88:

Change:
```markdown
- Current monthly organic traffic (if available from GA4/GSC)
```

To:
```markdown
- Current monthly organic traffic (pre-filled from GA4 if analytics data was loaded in Phase 0.5; otherwise ask user)
```

**Step 3: Update the "Tools to Use" section**

After the existing MCP tool entries (after line ~176), add:

```markdown
- **GA4 MCP** (if available) — Traffic overview, landing page performance, bounce rates, session data. Loaded automatically in Phase 0.5 when client has `ga4_property_id` set.
- **GSC MCP** (if available) — Search queries, page clicks/impressions, indexing issues, sitemap status. Loaded automatically in Phase 0.5 when client has `gsc_site_url` set.
```

**Step 4: Commit**

```bash
git add skills/local-seo-audit/SKILL.md
git commit -m "Add Phase 0.5 analytics integration to audit skill"
```

---

### Task 6: Add Phase 0.5 to plan skill

**Files:**
- Modify: `skills/local-seo-plan/SKILL.md`

**Step 1: Add Phase 0.5 reference**

After the Phase 0 section (same location as audit — after "All business context is pre-populated from the profile"), add:

```markdown
---

## Phase 0.5: Analytics Data

Follow the instructions in [references/analytics-integration.md](../../references/analytics-integration.md) — "For plan skill" section.

If analytics data is available:
- Phase 2 (Keyword Research) uses real GSC keyword positions to identify quick wins (positions 5-20)
- Phase 3 (Architecture) uses real page traffic data to prioritize high-value pages
- Traffic projections in Phase 4 use actual baseline numbers from GA4 instead of estimates
```

**Step 2: Commit**

```bash
git add skills/local-seo-plan/SKILL.md
git commit -m "Add Phase 0.5 analytics integration to plan skill"
```

---

### Task 7: Add Phase 0.5 to content skill

**Files:**
- Modify: `skills/local-seo-content/SKILL.md`

**Step 1: Add Phase 0.5 reference**

After the Phase 0 section (same location), add:

```markdown
---

## Phase 0.5: Analytics Data

Follow the instructions in [references/analytics-integration.md](../../references/analytics-integration.md) — "For content skill" section.

If analytics data is available:
- Topic prioritization uses real GSC query data to find content gaps (queries with impressions but low clicks)
- Existing content audit uses GA4 page performance to identify refresh candidates (high-traffic pages with declining engagement)
- Content calendar scheduling prioritizes topics that support pages already ranking in positions 5-20
```

**Step 2: Commit**

```bash
git add skills/local-seo-content/SKILL.md
git commit -m "Add Phase 0.5 analytics integration to content skill"
```

---

### Task 8: Update prerequisites.md with GCP setup instructions

**Files:**
- Modify: `references/prerequisites.md`

**Step 1: Rewrite prerequisites.md**

Keep the existing content (Optional Data Tool MCPs section) and add a new section before it for Google Analytics/Search Console setup. The full file should be:

```markdown
## Google Analytics & Search Console Setup

These MCPs let skills pull live GA4 and GSC data for clients. Both are **optional** — skills fall back gracefully without them.

Both use a single GCP service account that you grant access to each client's GA4 and GSC properties.

### Step 1: Create a GCP project

1. Go to https://console.cloud.google.com/
2. Click the project dropdown (top bar) → "New Project"
3. Name it something like "Local SEO MCP" → Create
4. Select the new project from the dropdown

### Step 2: Enable the APIs

1. Go to https://console.cloud.google.com/apis/library
2. Search for and enable each of these:
   - **Google Analytics Data API** (not the older "Analytics API")
   - **Google Analytics Admin API**
   - **Google Search Console API** (listed as "Search Console API")

### Step 3: Create a service account

1. Go to https://console.cloud.google.com/iam-admin/serviceaccounts
2. Click "Create Service Account"
3. Name: `local-seo-mcp` (or anything descriptive)
4. Skip the optional permissions and access steps → Done
5. Click the new service account → "Keys" tab → "Add Key" → "Create new key" → JSON → Create
6. A `.json` file downloads — this is your service account key

### Step 4: Place the key file

Choose where to store the key file. Default recommendation:

```bash
mkdir -p ~/.config/gcloud
mv ~/Downloads/local-seo-mcp-*.json ~/.config/gcloud/service-account.json
chmod 600 ~/.config/gcloud/service-account.json
```

Other options:
- `~/.claude/google-service-account.json` — keeps it with Claude settings
- Any secure location you prefer — just update the env var path

### Step 5: Set environment variables

Add to `~/.zshrc`:

```bash
echo 'export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/service-account.json"' >> ~/.zshrc
echo 'export GOOGLE_CLOUD_PROJECT="your-gcp-project-id"' >> ~/.zshrc
source ~/.zshrc
```

Replace `your-gcp-project-id` with the project ID from Step 1 (visible at https://console.cloud.google.com/home/dashboard — the ID, not the name).

Verify:
```bash
echo $GOOGLE_APPLICATION_CREDENTIALS  # should print the path
cat "$GOOGLE_APPLICATION_CREDENTIALS" | head -3  # should show JSON
echo $GOOGLE_CLOUD_PROJECT  # should print your project ID
```

### Step 6: Grant GA4 access per client

For each client's GA4 property:

1. Go to https://analytics.google.com/
2. Select the client's property
3. Admin (gear icon) → Property → Property Access Management
4. Click "+" → "Add users"
5. Enter the service account email (looks like `local-seo-mcp@your-project.iam.gserviceaccount.com` — find it in GCP Console > IAM > Service Accounts)
6. Role: **Viewer** (read-only is sufficient)
7. Click "Add"

Also note the **Property ID** — you'll need it for the client profile:
- Admin → Property → Property Settings → Property ID (a number like `123456789`)
- In the profile, store it as `properties/123456789`

### Step 7: Grant GSC access per client

For each client's Search Console property:

1. Go to https://search.google.com/search-console
2. Select the client's property
3. Settings (gear icon) → Users and permissions
4. Click "Add user"
5. Enter the service account email
6. Permission: **Restricted** (read-only is sufficient)
7. Click "Add"

Note the **Site URL** — you'll need it for the client profile:
- It's the exact URL shown in the property selector (e.g., `https://example.com/` or `sc-domain:example.com`)

### Step 8: Install GSC MCP dependencies

```bash
sudo mkdir -p /usr/local/share/mcp-gsc
sudo chown $(whoami) /usr/local/share/mcp-gsc
git clone https://github.com/AminForou/mcp-gsc.git /usr/local/share/mcp-gsc
cd /usr/local/share/mcp-gsc
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
deactivate
```

The plugin's `.mcp.json` points to `/usr/local/share/mcp-gsc/gsc_server.py`. If you cloned it elsewhere, update `.mcp.json` accordingly.

### Step 9: Install GA4 MCP dependency

```bash
pipx install analytics-mcp
```

If you don't have pipx:
```bash
brew install pipx
pipx ensurepath
pipx install analytics-mcp
```

### Step 10: Verify connections

Restart Claude Code (or run `/mcp` to reload MCP servers), then test:

**GA4 test:** Ask Claude: "List my GA4 account summaries"
- Expected: A list of GA4 accounts/properties your service account can access
- If it fails: Check that `GOOGLE_APPLICATION_CREDENTIALS` points to a valid JSON file, the Analytics Data API is enabled, and pipx can find `analytics-mcp`

**GSC test:** Ask Claude: "List my Search Console properties"
- Expected: A list of GSC properties your service account has access to
- If it fails: Check that `GSC_CREDENTIALS_PATH` env var is set (it should inherit from `GOOGLE_APPLICATION_CREDENTIALS`), the Search Console API is enabled, and the Python venv has the required packages

### Troubleshooting

| Problem | Fix |
|---|---|
| "GOOGLE_APPLICATION_CREDENTIALS not set" | Run `source ~/.zshrc` or restart terminal. Check `echo $GOOGLE_APPLICATION_CREDENTIALS`. |
| GA4 returns empty account list | Service account hasn't been granted Viewer access in the GA4 property. |
| GSC returns "permission denied" | Service account hasn't been added as a user in the GSC property. |
| "analytics-mcp not found" | Run `pipx install analytics-mcp`. Check `pipx list`. |
| GSC MCP won't start | Check the Python path in `.mcp.json` matches your clone location. Verify the venv has dependencies: `cd /usr/local/share/mcp-gsc && source .venv/bin/activate && pip list | grep google`. |
| Both MCPs fail silently | Skills proceed without analytics data. Check the plugin's MCP status with `/mcp`. |

---

## Optional Data Tool MCPs

These MCPs enhance results when available but are **not required** — all skills fall back to WebSearch/WebFetch gracefully.

- **ahrefs** — backlink analysis, domain metrics, keyword research
- **dataforseo** — SERP data, Google Maps rankings, keyword volumes

### Discovery step (add to Phase 1)

After gathering business info and scope, ask:

**Question:** "Do you want to use enhanced data tools for this task?"
- "Yes — use Ahrefs and DataForSEO"
- "Just Ahrefs"
- "Just DataForSEO"
- "No — WebSearch is fine"

For each tool the user selects, verify the MCP is installed and responding:
1. Attempt a lightweight call (e.g., keyword overview or domain rating)
2. If it works → proceed normally
3. If it fails → inform the user and offer to help set it up via `/mcp add [mcp-name]`, or fall back to WebSearch

Do NOT block the workflow if an MCP isn't available. Always fall back gracefully.
```

**Step 2: Commit**

```bash
git add references/prerequisites.md
git commit -m "Add GCP service account setup guide for GA4 and GSC MCPs"
```

---

### Task 9: Update README.md with analytics docs and roadmap

**Files:**
- Modify: `README.md`

**Step 1: Add GA4 and GSC to the Data Integrations section**

After the existing "Ahrefs (optional)" subsection (after line ~71), add:

```markdown
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
```

**Step 2: Add the Roadmap section**

At the end of the file, before the `## License` section, add:

```markdown
## Roadmap

- [ ] **Google Business Profile MCP** — Live GBP data integration (n8n-based or standalone when a mature option emerges)
- [ ] **NeuronWriter API** — Content optimization scoring and keyword suggestions during content and service page writing
- [ ] **Per-skill analytics dashboards** — HTML reports with embedded GA4/GSC trend charts
- [ ] **Automated monthly reporting** — Scheduled analytics snapshots and client report generation
```

**Step 3: Commit**

```bash
git add README.md
git commit -m "Add GA4/GSC docs and roadmap to README"
```

---

### Task 10: Update .gitignore for analytics cache

**Files:**
- Modify: `.gitignore`

**Step 1: No changes needed**

Analytics snapshots are saved to client folders (which are outside the plugin repo — they live wherever the user's client data is stored, e.g. `~/Desktop/clients/`). The plugin repo itself doesn't contain analytics data.

No `.gitignore` changes required. Skip this task.

---

### Task 11: Update the design doc with corrected env var name

**Files:**
- Modify: `docs/plans/2026-02-27-google-analytics-integration-design.md`

**Step 1: Fix GOOGLE_PROJECT_ID → GOOGLE_CLOUD_PROJECT**

In the .mcp.json config block in the design doc, change `GOOGLE_PROJECT_ID` to `GOOGLE_CLOUD_PROJECT` to match the official GA4 MCP repo's actual env var name. Update all references throughout the doc.

**Step 2: Commit**

```bash
git add docs/plans/2026-02-27-google-analytics-integration-design.md
git commit -m "Fix GA4 env var name in design doc (GOOGLE_CLOUD_PROJECT)"
```

---

### Task 12: Final verification

**Step 1: Verify all files are consistent**

Check that these references are all consistent:
- `.mcp.json` env vars match `prerequisites.md` instructions
- `client-profile-template.md` frontmatter matches what `client-management/SKILL.md` writes
- `analytics-integration.md` references match the Phase 0.5 sections in all three skill files
- `README.md` env vars match `.mcp.json`

**Step 2: Run git log to verify commit history**

```bash
git log --oneline -10
```

Expected: ~8-9 clean commits from this implementation, each focused on one change.

**Step 3: Final commit if any fixes were needed**

If the verification found inconsistencies, fix them and commit:

```bash
git add -A
git commit -m "Fix inconsistencies found during verification"
```
