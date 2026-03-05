# UX Improvements Design — 2026-03-05

## Problem Statement

Four UX issues identified during real usage of the local SEO skills plugin:

1. **Phase 0 client detection is too passive** — Starting a new skill after already setting up a client still asks "Do you want to associate this with a client profile?" instead of auto-detecting.
2. **Input prompt options are broken** — Selecting "I'll type it" doesn't provide a text box. Only "Other" triggers freeform input, but "Other" is unintuitive.
3. **Domain auto-discovery guesses wrong** — Client onboarding WebSearch found `RollinsFamilyDogTraining.com` instead of `rollinsdogtraining.com`. Domain is too important to guess.
4. **MCP setup is confusing** — No guided process for configuring GSC and GA4 service accounts, env vars, and MCP enablement.

---

## Change 1: Phase 0 Rewrite (Smart Client Detection)

**File:** `references/client-context-phases.md`

### New Detection Priority

```
1. Check CWD against registered client paths
   |-- Match found --> auto-select, confirm:
   |   "Using client profile: **Rollins Dog Training** (rollinsdogtraining.com).
   |    [Continue / Switch client / No client]"
   |
   +-- No match --> check registry size
       |-- 1 client --> auto-select, confirm (same prompt as above)
       |-- 2+ clients --> show list:
       |   "Which client is this for?"
       |   - Rollins Dog Training
       |   - Other Client Name
       |   - New client
       |   - No client (quick mode)
       |
       +-- 0 clients -->
           "Do you want to set up a client profile first?"
           - Yes -- create a new client profile
           - No -- run in quick mode
```

### CWD Matching Logic

Check if current directory starts with any registered client path, or if any client path starts with the current directory. This handles being in a client folder or a subfolder of it.

### What Carries Forward

Once a client is selected, pre-populate into the skill: website, GBP URL, industry, services, service areas, GA4 property ID, GSC site URL. User is not re-asked for any of these.

---

## Change 2: Input Prompt UX Cleanup

### Convention

All `AskUserQuestion` prompts that collect text values (URLs, names, etc.) follow this pattern:

- If a value is already known (from client profile or prior discovery), show it as a **regular selectable option**
- The freeform text option is always labeled descriptively: "Enter a different URL", "Enter a different business name", etc.
- This descriptive label **must be the "Other" option** in the AskUserQuestion call — that is the only option type that triggers a text input box in Claude Code's UI
- Never use "I'll type it" or "Other" as option labels — they don't communicate what happens
- For first-time collection with no known value, ask as open text with no options

### Example

```
AskUserQuestion:
"What is the website URL?"
- rollinsdogtraining.com              <-- regular option (from profile)
- "Enter a different URL" (Other)     <-- freeform option, triggers text box
```

### Anti-patterns (never do these)

- "I'll provide a URL" as a selectable option (selecting it does nothing)
- "I'll type it" as a selectable option (same problem)
- "Other" as the label for freeform input (unclear)

### Files Affected

Every skill SKILL.md that uses AskUserQuestion for text values. Document this convention in a shared reference file so all skills follow it.

---

## Change 3: Client Onboarding Domain Fix

**File:** `skills/client-management/SKILL.md`

### Current (broken)

Step 3 auto-discovers via WebSearch using business name alone. Finds wrong domain.

### New Step 3

1. Ask directly: "What's the website URL for [business name]?" — open text, no options, no guessing
2. User types URL (e.g., `rollinsdogtraining.com`)
3. Then auto-discover everything else using that URL as the anchor:
   - WebFetch the site to confirm it loads and extract business info
   - WebSearch for GBP listing using domain + business name
   - Discover industry, services, service areas from site content
   - Find competitors via search
4. Present all discovered info for user confirmation

Domain is never guessed. It is always asked directly on first setup. Once stored in the client profile, it is carried forward and shown as a selectable option (per Change 2 convention).

---

## Change 4: Setup Analytics Skill

**New skill:** `setup-analytics`
**Invocable as:** `/setup-analytics`
**Also triggered from:** Client onboarding Step 4.25

### Step 1 — Audit Current State

Check everything already configured:

- Does `~/.config/gcloud/service-account.json` exist? Valid JSON?
- Is `GOOGLE_APPLICATION_CREDENTIALS` env var set? Path matches?
- Is `GOOGLE_CLOUD_PROJECT` env var set?
- Is GA4 MCP enabled in `.mcp.json`? Is GSC MCP enabled?
- Is `gcloud` CLI installed? (`which gcloud`)
- If a client is active: does their profile have `ga4_property_id` and `gsc_site_url`?
- If MCPs are enabled: can we connect? (test `get_account_summaries` / `list_properties`)

### Step 2 — Present Status Report

```
Analytics Setup Status:
  Service account key: ~/.config/gcloud/service-account.json
  GOOGLE_APPLICATION_CREDENTIALS set
  GOOGLE_CLOUD_PROJECT not set
  GA4 MCP: enabled
  GSC MCP: disabled
  Client "Rollins Dog Training": ga4_property_id missing

3 items need attention.
```

Confirm: "Want to fix these now?"

### Step 3 — Walk Through Each Gap

**For GCP console steps (browser required):**

- Create GCP project — provide direct console URL
- Enable APIs — list exact API names, provide direct URLs
- Create service account — step-by-step instructions

**For service account key creation:**

If `gcloud` CLI is installed (recommended path):
```bash
gcloud iam service-accounts keys create ~/.config/gcloud/service-account.json \
  --iam-account=SERVICE_ACCOUNT_EMAIL
```

If `gcloud` not installed, fall back to browser console instructions (create key in UI, download, move file).

**For file/folder creation — always offer 3 options:**

```
The service account key needs to be at ~/.config/gcloud/service-account.json

1) I'll create this myself manually
2) Use these terminal commands:
   mkdir -p ~/.config/gcloud
   mv ~/Downloads/your-key-file.json ~/.config/gcloud/service-account.json
3) Let Claude set this up for me
```

Same 3-option pattern for env vars, `.mcp.json` updates, enabling MCPs.

**For granting GA4/GSC access:**

- Exact steps to add service account email as Viewer in GA4 property
- Exact steps to add service account with Restricted access in GSC

### Step 4 — Client-Specific Validation

If a client is active:

- Confirm GA4 property ID returns data for the correct domain
- Confirm GSC site URL matches the client's domain
- Update client profile with verified IDs
- Show: "GA4 property `properties/123456789` returns data for rollinsdogtraining.com"

### Step 5 — Final Verification

Run test calls through both MCPs, show results, confirm everything works.

### Files to Create/Modify

- **New:** `skills/setup-analytics/SKILL.md`
- **New:** `skills/setup-analytics/description.yaml`
- **Modify:** `skills/client-management/SKILL.md` (Step 4.25 triggers setup-analytics)
- **Modify:** `references/prerequisites.md` (simplify, point to the skill)

---

## Implementation Scope

### Shared Reference Files

- New: `references/ask-user-question-conventions.md` — documents the input prompt UX convention for all skills
- Modify: `references/client-context-phases.md` — Phase 0 rewrite

### Skills Modified

- `skills/client-management/SKILL.md` — domain fix + analytics setup trigger
- `skills/local-seo-audit/SKILL.md` — input prompt cleanup
- `skills/local-seo-plan/SKILL.md` — input prompt cleanup
- `skills/local-seo-gbp/SKILL.md` — input prompt cleanup
- `skills/local-seo-content/SKILL.md` — input prompt cleanup
- `skills/local-seo-reviews/SKILL.md` — input prompt cleanup
- All other skills with Phase 0 or text-input prompts

### Skills Created

- `skills/setup-analytics/SKILL.md`
- `skills/setup-analytics/description.yaml`
