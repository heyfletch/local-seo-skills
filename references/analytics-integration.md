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

```
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
