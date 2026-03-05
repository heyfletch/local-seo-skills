# UX Improvements Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Fix 4 UX issues: smart client auto-detection, input prompt clarity, domain-first onboarding, and a new setup-analytics skill.

**Architecture:** All changes are to skill SKILL.md files (markdown SOPs) and reference docs. One new skill created. No code/runtime changes — these are instruction files that guide Claude's behavior.

**Tech Stack:** Markdown skill files, YAML frontmatter, Claude Code AskUserQuestion conventions.

**Design doc:** `docs/plans/2026-03-05-ux-improvements-design.md`

---

## Task 1: Create AskUserQuestion Convention Reference

**Files:**
- Create: `references/ask-user-question-conventions.md`

**Step 1: Write the convention doc**

```markdown
# AskUserQuestion Conventions

Shared rules for all skills that use AskUserQuestion to collect text input from users.

---

## Rule 1: Known values are selectable options

If a value is already known (from client profile, prior discovery, or previous input), show it as a regular selectable option.

## Rule 2: Freeform input uses descriptive "Other" labels

The freeform text option must:
- Be labeled descriptively: "Enter a different URL", "Enter a different business name", "Type a custom path", etc.
- Be the **"Other" option** in the AskUserQuestion call — this is the only option type that triggers a text input box in Claude Code's UI
- Never be labeled "I'll type it", "I'll provide a URL", or just "Other"

## Rule 3: First-time collection with no known value = open text

When collecting a value for the first time with no known/discovered value to offer, ask as an open text question with no options. Example: "What's the website URL for [business name]?"

## Rule 4: Multi-choice questions are fine as-is

Questions with predefined choices (audit scope, budget ranges, yes/no) don't need freeform input. These are unaffected by these conventions.

---

## Examples

### Text input WITH a known value

```
AskUserQuestion:
"What is the website URL?"
- rollinsdogtraining.com                  <-- regular option (from profile)
- "Enter a different URL" (Other)         <-- freeform, triggers text box
```

### Text input with NO known value (first time)

```
AskUserQuestion:
"What's the website URL for Rollins Dog Training?"
- Open text input (user types the URL)
```

### Anti-patterns (never do these)

- "I'll provide a URL" as a selectable option (selecting it does nothing useful)
- "I'll type it" as a selectable option (same problem — no text box appears)
- "Other" as the label for freeform input (unclear what it does)
- Guessing a domain via WebSearch and presenting it as the only option
```

**Step 2: Commit**

```bash
git add references/ask-user-question-conventions.md
git commit -m "feat: add AskUserQuestion UX conventions reference"
```

---

## Task 2: Rewrite Phase 0 (Smart Client Detection)

**Files:**
- Modify: `references/client-context-phases.md:7-35` (Phase 0 Steps 1-2)

**Step 1: Replace Phase 0 Steps 1-2**

Replace the current Steps 1-2 (lines 11-35) with the new smart detection flow. Keep Step 3 (Load client context) unchanged.

New content for Steps 1-2:

```markdown
### Step 1: Check flags

Parse the user's command for flags:
- `--quick` → Set mode to **quick**. Skip all client context. Proceed directly to Phase 1 as normal.
- `--deliverable` → Set mode to **deliverable**. Client context is required — create profile if none exists.
- No flags → Set mode to **infer** (see Step 2).

### Step 2: Smart client detection

Read `${CLAUDE_PLUGIN_ROOT}/references/clients/registry.md` and parse the YAML frontmatter `clients` map.

**Priority 1: CWD match**

Check if the current working directory matches or is inside any registered client's path (CWD starts with client path, or client path starts with CWD).

If a match is found → auto-select that client, then confirm:

**Question:** "Using client profile: **[Client Name]** ([website])."
- "Continue" — load this client's profile
- "Switch to a different client" — go to Priority 3 flow
- "No client (quick mode)" — set mode to **quick**, proceed to Phase 1

**Priority 2: Single client in registry**

If no CWD match but the registry has exactly 1 client → auto-select that client, use the same confirmation prompt as Priority 1.

**Priority 3: Multiple clients in registry**

If no CWD match and the registry has 2+ clients → show a selection list:

**Question:** "Which client is this for?"
- [List each client by name]
- "New client" → run the `client-management` skill in Create Mode, then return here with the new client loaded
- "No client (quick mode)" → set mode to **quick**, proceed to Phase 1

**Priority 4: No clients registered**

If the registry file doesn't exist or has no clients:

**Question:** "Do you want to set up a client profile first?"
- "Yes — create a new client profile" → run the `client-management` skill in Create Mode, then return here with the new client loaded
- "No — run in quick mode" → set mode to **quick**, proceed to Phase 1
```

**Step 2: Verify no broken references**

Read through the rest of `client-context-phases.md` (Step 3 and Phase 3.5) to confirm nothing references the old Step 2 wording or flow. The Step 3 "Load client context" section should still work as-is since it just reads the selected client's profile.

**Step 3: Commit**

```bash
git add references/client-context-phases.md
git commit -m "feat: rewrite Phase 0 with smart client auto-detection (CWD match, single-client auto-select)"
```

---

## Task 3: Fix Client Onboarding Domain Collection

**Files:**
- Modify: `skills/client-management/SKILL.md:71-84` (Create Mode Step 3)

**Step 1: Replace Step 3 (Auto-discover)**

Replace the current Step 3 content with:

```markdown
### Step 3: Collect website and auto-discover

**3a: Ask for the website URL directly**

Use AskUserQuestion:
**Question:** "What's the website URL for [business name]?"
- Open text input (user types the URL)

Do NOT attempt to guess the domain via WebSearch. The domain is too important to risk getting wrong.

**3b: Auto-discover from the URL**

Once the user provides the URL, use WebSearch and WebFetch to discover:
- Google Business Profile URL (search: "[business name] [city] Google Business")
- Industry / business type (from site content)
- Services offered (from site content)
- Service areas / cities / regions (from site content)
- Top 3-5 competitors (search: "[services] [city]")

Present all findings via AskUserQuestion. Let the user confirm, correct, or skip each section.

Follow the conventions in [references/ask-user-question-conventions.md](../../references/ask-user-question-conventions.md) for all prompts.
```

**Step 2: Commit**

```bash
git add skills/client-management/SKILL.md
git commit -m "fix: ask for domain directly during client onboarding instead of guessing via WebSearch"
```

---

## Task 4: Fix Client Management Input Prompts

**Files:**
- Modify: `skills/client-management/SKILL.md:64-68` (Step 2 folder path)
- Modify: `skills/client-management/SKILL.md:98-101` (Step 4.25 analytics)
- Modify: `skills/client-management/SKILL.md:116-118` (Step 4.5 scope)

**Step 1: Fix Step 2 (folder path)**

Replace the options:
```markdown
- "Suggest a path for me" — use `[output_dir]/clients/[slug]/` as default
- "I'll provide a path" — user types a custom path
```

With:
```markdown
- "[output_dir]/clients/[slug]/" — use suggested path
- "Type a custom path" (Other) — enter a different location
```

**Step 2: Fix Step 4.25 (analytics connections)**

Replace:
```markdown
- "Yes — I'll provide the property IDs"
- "Not yet — skip for now"
```

With:
```markdown
- "Yes — let's connect them"
- "Not yet — skip for now"
- "I need help setting this up" — run the `setup-analytics` skill, then return here
```

The "Yes" option then asks follow-up questions as open text (same as current, which is correct since there's no known value to pre-fill on first setup).

**Step 3: Fix Step 4.5 (scope docs)**

Replace:
```markdown
- "Yes — I'll provide the file path"
```

With:
```markdown
- "Yes — I have a scope document"
```

Then the follow-up asks for the file path as open text (already correct).

**Step 4: Add convention reference**

Add this line after the "## Iron Law" section:

```markdown
Follow the conventions in [references/ask-user-question-conventions.md](../../references/ask-user-question-conventions.md) for all AskUserQuestion prompts.
```

**Step 5: Commit**

```bash
git add skills/client-management/SKILL.md
git commit -m "fix: update client-management input prompts to follow AskUserQuestion conventions"
```

---

## Task 5: Fix Audit Skill Input Prompts

**Files:**
- Modify: `skills/local-seo-audit/SKILL.md:57-61` (Phase 1 Step 1)

**Step 1: Replace Step 1 options**

Replace:
```markdown
**Question:** "What business should I audit?"
- Options: "I'll provide a URL", "I'll provide a business name + city", "Both URL and name"
```

With:
```markdown
**Question:** "What business should I audit?"

If client context is loaded (from Phase 0), this step is skipped — the business is already identified.

If no client context:
- Open text: "What's the website URL or business name + city?"

If the user provides a business name without a URL, use WebSearch to find the website, then confirm with the user per [references/ask-user-question-conventions.md](../../references/ask-user-question-conventions.md).
```

**Step 2: Add convention reference**

Add after the "## Iron Law" section:

```markdown
Follow [references/ask-user-question-conventions.md](../../references/ask-user-question-conventions.md) for all AskUserQuestion prompts.
```

**Step 3: Commit**

```bash
git add skills/local-seo-audit/SKILL.md
git commit -m "fix: update audit skill input prompts to follow AskUserQuestion conventions"
```

---

## Task 6: Fix Plan Skill Input Prompts

**Files:**
- Modify: `skills/local-seo-plan/SKILL.md:57-61` (Phase 1 Step 1)

**Step 1: Replace Step 1 options**

Same pattern as Task 5. Replace:
```markdown
**Question:** "What business are we planning for?"
- Options: "I'll provide a URL", "I'll provide a business name + city", "Both URL and name"
```

With:
```markdown
**Question:** "What business are we planning for?"

If client context is loaded (from Phase 0), this step is skipped — the business is already identified.

If no client context:
- Open text: "What's the website URL or business name + city?"

If the user provides a business name without a URL, use WebSearch to find the website, then confirm with the user per [references/ask-user-question-conventions.md](../../references/ask-user-question-conventions.md).
```

**Step 2: Add convention reference after Iron Law section.**

**Step 3: Commit**

```bash
git add skills/local-seo-plan/SKILL.md
git commit -m "fix: update plan skill input prompts to follow AskUserQuestion conventions"
```

---

## Task 7: Fix Content Skill Input Prompts

**Files:**
- Modify: `skills/local-seo-content/SKILL.md:60` (Phase 1 Step 1)

**Step 1: Apply same pattern as Tasks 5-6**

Replace the "I'll provide a URL" / "I'll provide a business name + city" / "Both URL and name" options with open text input + convention reference.

**Step 2: Commit**

```bash
git add skills/local-seo-content/SKILL.md
git commit -m "fix: update content skill input prompts to follow AskUserQuestion conventions"
```

---

## Task 8: Fix GBP Skill Input Prompts

**Files:**
- Modify: `skills/local-seo-gbp/SKILL.md:49` (Phase 1 Step 1)

**Step 1: Replace options**

Replace:
```markdown
- Options: "I'll provide a business name + city", "I'll provide a GBP URL", "Both"
```

With:
```markdown
If client context is loaded (from Phase 0), this step is skipped.

If no client context:
- Open text: "What's the business name + city, or GBP URL?"
```

**Step 2: Add convention reference after Iron Law section.**

**Step 3: Commit**

```bash
git add skills/local-seo-gbp/SKILL.md
git commit -m "fix: update GBP skill input prompts to follow AskUserQuestion conventions"
```

---

## Task 9: Fix Remaining Skills Input Prompts

**Files:**
- Modify: `skills/local-seo-schema/SKILL.md:59-60`
- Modify: `skills/local-seo-service-page/SKILL.md:49`
- Modify: `skills/local-seo-area-page/SKILL.md:49`

**Step 1: Fix schema skill**

Replace:
```markdown
- "I'll provide the website URL — scrape the details"
- "I'll type the details manually"
```

With:
```markdown
If client context is loaded (from Phase 0), this step is skipped — use profile data.

If no client context:
- Open text: "What's the website URL? (Or describe the business if no site exists)"
```

**Step 2: Fix service-page skill**

Replace:
```markdown
- Options: "I'll describe the service", "I'll provide a URL to an existing page to optimize", "I'll provide both"
```

With:
```markdown
If client context is loaded (from Phase 0), this step is skipped — services are known from profile.

If no client context:
- Open text: "What service should this page be for? Include the URL if there's an existing page to optimize."
```

**Step 3: Fix area-page skill**

Replace:
```markdown
- Options: "I'll specify the city and service", "I'll provide a list of cities to evaluate", "I need help choosing which cities to target"
```

With:
```markdown
If client context is loaded (from Phase 0), service areas are known from profile.

**Question:** "What city and service should this page target?"
- [List known service areas from profile as options, if available]
- "Enter a different city/service" (Other) — type a custom combination
- "Help me choose which cities to target" — run analysis first

If no client context:
- Open text: "What city and service should this page target? (e.g., 'dog training in Alpharetta')"
```

**Step 4: Add convention reference to each skill after its Iron Law section.**

**Step 5: Commit**

```bash
git add skills/local-seo-schema/SKILL.md skills/local-seo-service-page/SKILL.md skills/local-seo-area-page/SKILL.md
git commit -m "fix: update schema, service-page, area-page input prompts to follow AskUserQuestion conventions"
```

---

## Task 10: Create Setup Analytics Skill

**Files:**
- Create: `skills/setup-analytics/SKILL.md`

**Step 1: Write the skill file**

```markdown
---
name: setup-analytics
description: This skill should be used when the user asks to "set up analytics", "connect GA4", "connect Search Console", "configure GSC", "set up Google Analytics MCP", "setup service account", "analytics setup", "MCP setup", "connect Google data", or any request to configure the GA4 or GSC MCP connections. Also triggered from client onboarding when user selects "I need help setting this up" for analytics. Handles service account creation, credential placement, env var configuration, MCP enablement, and per-client property verification.
---

# Setup Analytics Skill

## Iron Law

NEVER store credentials in the project directory, git repos, or anywhere that could be committed. Credentials go in `~/.config/gcloud/` or another secure user-level location. ALWAYS confirm before writing any file or running any command.

Follow [references/ask-user-question-conventions.md](../../references/ask-user-question-conventions.md) for all AskUserQuestion prompts.

---

## Phase 1: Audit Current State

Check each item and record its status (ready / missing / misconfigured):

1. **Service account key file**
   - Check if `~/.config/gcloud/service-account.json` exists
   - If it exists, verify it's valid JSON with `client_email` and `project_id` fields
   - Record the `client_email` and `project_id` values for later steps

2. **Environment variables**
   - Check if `GOOGLE_APPLICATION_CREDENTIALS` is set and points to a valid file
   - Check if `GOOGLE_CLOUD_PROJECT` is set

3. **MCP server status**
   - Read the plugin's `.mcp.json` file
   - Check if `ga4` server is enabled (not `"disabled": true`)
   - Check if `gsc` server is enabled (not `"disabled": true`)
   - If GSC is enabled, check if the Python path in the config exists

4. **MCP dependencies**
   - Check if `gcloud` CLI is installed (`which gcloud`)
   - Check if `pipx` is installed (`which pipx`)
   - Check if `analytics-mcp` is installed (`pipx list | grep analytics-mcp`)
   - Check if GSC MCP repo exists at the configured path

5. **Client-specific (if a client is active from Phase 0)**
   - Read the client's `profile.md` frontmatter
   - Check if `ga4_property_id` is set
   - Check if `gsc_site_url` is set

6. **Live connection test (only if MCPs are enabled)**
   - Attempt `get_account_summaries` for GA4
   - Attempt `list_properties` for GSC

---

## Phase 2: Present Status Report

Display all findings in a clear status table:

```
Analytics Setup Status for [client name, if active]:

  Service account key     ~/.config/gcloud/service-account.json
  Service account email   local-seo-mcp@project.iam.gserviceaccount.com
  GOOGLE_APPLICATION_CREDENTIALS   set, path valid
  GOOGLE_CLOUD_PROJECT             set (your-project-id)
  GA4 MCP                 disabled in .mcp.json
  GSC MCP                 disabled in .mcp.json
  analytics-mcp package   not installed
  GSC MCP repo            not found at /usr/local/share/mcp-gsc/
  Client GA4 Property ID  not set in profile
  Client GSC Site URL     not set in profile

6 items need attention.
```

Use AskUserQuestion:
**Question:** "Want to fix these now?"
- "Yes — walk me through it"
- "No — I'll handle it later"

If no, end the skill.

---

## Phase 3: Walk Through Each Gap

Work through missing items in dependency order. Skip any items already marked as ready.

### 3a: GCP Project (if no service account exists)

This requires the browser. Provide clear instructions:

```
Step 1: Create a GCP project
   Go to: https://console.cloud.google.com/
   Click project dropdown (top bar) > "New Project"
   Name: "Local SEO MCP" (or anything you like)
   Click Create, then select the new project

Step 2: Enable APIs
   Go to: https://console.cloud.google.com/apis/library
   Search and enable each:
   - Google Analytics Data API
   - Google Analytics Admin API
   - Search Console API

Step 3: Create a service account
   Go to: https://console.cloud.google.com/iam-admin/serviceaccounts
   Click "Create Service Account"
   Name: local-seo-mcp
   Skip optional permissions > Done
```

Use AskUserQuestion:
**Question:** "Have you completed these steps in the browser?"
- "Yes — project and service account are ready"
- "I already have a GCP project and service account"
- "I need more help" — provide additional guidance

### 3b: Service Account Key (if key file missing)

Check if `gcloud` CLI is available.

**If gcloud is installed (recommended path):**

Use AskUserQuestion:
**Question:** "How would you like to create the service account key?"
- "Use gcloud CLI (recommended)" — provide the command
- "Download from browser" — provide browser instructions
- "I already have a key file" — ask where it is

If gcloud CLI chosen, provide:
```
Run this command (replace SERVICE_ACCOUNT_EMAIL with your service account email):

gcloud iam service-accounts keys create ~/.config/gcloud/service-account.json \
  --iam-account=SERVICE_ACCOUNT_EMAIL

Find your service account email at:
https://console.cloud.google.com/iam-admin/serviceaccounts
It looks like: local-seo-mcp@your-project.iam.gserviceaccount.com
```

**If gcloud not installed:**

Use AskUserQuestion:
**Question:** "The service account key needs to be downloaded. How would you like to proceed?"
- "Install gcloud CLI first (recommended)" — provide: `brew install google-cloud-sdk`
- "Download from browser instead" — provide browser instructions

If browser download chosen:
```
Go to: https://console.cloud.google.com/iam-admin/serviceaccounts
Click your service account > Keys tab > Add Key > Create new key > JSON > Create
A .json file downloads to ~/Downloads/
```

### 3c: Place Key File (if downloaded via browser)

Only needed if the user downloaded via browser (gcloud CLI already places it correctly).

Use AskUserQuestion:
**Question:** "The key file needs to be moved to a secure location (~/.config/gcloud/service-account.json). How would you like to do this?"
- "I'll move it myself manually"
- "Show me the terminal commands"
- "Let Claude set this up for me"

If terminal commands:
```bash
mkdir -p ~/.config/gcloud
mv ~/Downloads/local-seo-mcp-*.json ~/.config/gcloud/service-account.json
chmod 600 ~/.config/gcloud/service-account.json
```

If "Let Claude do it": run the above commands via Bash (with user confirmation).

### 3d: Environment Variables (if not set)

Use AskUserQuestion:
**Question:** "Environment variables need to be added to ~/.zshrc. How would you like to do this?"
- "I'll add them myself manually"
- "Show me the terminal commands"
- "Let Claude set this up for me"

Commands:
```bash
echo 'export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/service-account.json"' >> ~/.zshrc
echo 'export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"' >> ~/.zshrc
source ~/.zshrc
```

Replace YOUR_PROJECT_ID with the actual project ID (found at https://console.cloud.google.com/home/dashboard — it's the ID, not the display name).

If "Let Claude do it": ask for the project ID first, then run the commands via Bash.

### 3e: Install MCP Dependencies (if missing)

**GA4 MCP (analytics-mcp):**

Use AskUserQuestion:
**Question:** "The GA4 MCP package (analytics-mcp) needs to be installed. How would you like to proceed?"
- "I'll install it myself"
- "Show me the terminal commands"
- "Let Claude install it for me"

Commands:
```bash
pipx install analytics-mcp
```

If pipx is not installed:
```bash
brew install pipx
pipx ensurepath
pipx install analytics-mcp
```

**GSC MCP (mcp-gsc):**

Use AskUserQuestion:
**Question:** "The GSC MCP server needs to be installed. How would you like to proceed?"
- "I'll install it myself"
- "Show me the terminal commands"
- "Let Claude install it for me"

Commands:
```bash
sudo mkdir -p /usr/local/share/mcp-gsc
sudo chown $(whoami) /usr/local/share/mcp-gsc
git clone https://github.com/AminForou/mcp-gsc.git /usr/local/share/mcp-gsc
cd /usr/local/share/mcp-gsc && python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt && deactivate
```

### 3f: Enable MCPs in .mcp.json (if disabled)

Use AskUserQuestion:
**Question:** "The GA4 and GSC MCPs need to be enabled in .mcp.json. How would you like to do this?"
- "I'll edit .mcp.json myself"
- "Let Claude update .mcp.json for me"

If "Let Claude do it": use Edit tool to set `"disabled": true` to `"disabled": false` (or remove the `disabled` key) for both `ga4` and `gsc` entries. If the GSC MCP path doesn't match where the user installed it, update the path too.

### 3g: Grant GA4 and GSC Access (browser required)

This must be done per-client. Provide instructions:

```
Grant GA4 access:
   Go to: https://analytics.google.com/
   Select the property for [client website]
   Admin > Property Access Management > "+" > Add users
   Email: [service account email from Step 3b]
   Role: Viewer
   Click Add

   Note the Property ID:
   Admin > Property Settings > Property ID (number like 123456789)
   Store as: properties/123456789

Grant GSC access:
   Go to: https://search.google.com/search-console
   Select the property for [client website]
   Settings > Users and permissions > Add user
   Email: [service account email]
   Permission: Restricted
   Click Add

   Note the Site URL exactly as shown in the property selector
   (e.g., https://example.com/ or sc-domain:example.com)
```

Use AskUserQuestion:
**Question:** "Have you granted access and noted the Property ID and Site URL?"
- "Yes — I'll provide them now"
- "I need more help"

Collect GA4 Property ID and GSC Site URL as open text questions.

---

## Phase 4: Client-Specific Validation

If a client is active:

1. **Update client profile** — write `ga4_property_id` and `gsc_site_url` to the profile frontmatter

2. **Test GA4 connection** — run a simple report for the property ID and verify it returns data for the correct domain. Show: "GA4 property `properties/123456789` returns data for [domain]"

3. **Test GSC connection** — run `get_search_analytics` for the site URL with a 7-day range. Show: "GSC property `[site URL]` has [N] queries in the last 7 days"

4. **Cross-validate** — confirm the GA4 domain and GSC site URL match the client's registered website. If they don't match, warn the user.

If no client is active, skip this phase and inform the user: "Analytics MCPs are configured. Run `/setup-analytics` again with a client active to connect a specific property."

---

## Phase 5: Final Verification

Run a complete status check (same as Phase 1) and display the updated status table. All items should show as ready.

If anything still fails, provide specific troubleshooting for that item (reference the troubleshooting table in [references/prerequisites.md](../../references/prerequisites.md)).

Inform the user: "You may need to restart Claude Code (`/mcp` or restart the session) for MCP changes to take effect."
```

**Step 2: Commit**

```bash
git add skills/setup-analytics/SKILL.md
git commit -m "feat: add setup-analytics skill for guided GA4/GSC MCP configuration"
```

---

## Task 11: Update Client Onboarding to Trigger Setup Analytics

**Files:**
- Modify: `skills/client-management/SKILL.md:96-111` (Step 4.25)

**Step 1: Update Step 4.25 analytics options**

Already handled in Task 4 Step 2 — the "I need help setting this up" option triggers the `setup-analytics` skill.

Add a note after the options:

```markdown
If "I need help setting this up" → run the `setup-analytics` skill. When it completes, the GA4 Property ID and GSC Site URL will have been collected and validated. Continue to Step 4.5.
```

**Step 2: Commit**

```bash
git add skills/client-management/SKILL.md
git commit -m "feat: link client onboarding Step 4.25 to setup-analytics skill"
```

---

## Task 12: Simplify Prerequisites Reference

**Files:**
- Modify: `references/prerequisites.md`

**Step 1: Replace the detailed manual steps with a pointer to the skill**

Read the current file, then replace the GA4/GSC setup sections with:

```markdown
## Google Analytics & Search Console Setup

Run `/setup-analytics` for a guided walkthrough that checks your current state, walks you through each step, and verifies connections.

The skill handles:
- GCP project and service account creation
- Service account key generation (via gcloud CLI or browser)
- Credential file placement and permissions
- Environment variable configuration
- MCP dependency installation (analytics-mcp, mcp-gsc)
- MCP enablement in .mcp.json
- Per-client GA4/GSC property access and validation

### Manual Setup Reference

If you prefer to set things up manually, expand the sections below.

<details>
<summary>Manual GCP setup steps</summary>

[Keep the existing detailed steps as a reference, indented under this collapsible]

</details>

### Troubleshooting

[Keep the existing troubleshooting table]
```

**Step 2: Commit**

```bash
git add references/prerequisites.md
git commit -m "refactor: simplify prerequisites.md, point to setup-analytics skill for guided setup"
```

---

## Task 13: Final Review and Version Bump

**Step 1: Review all changed files**

Read each modified file to verify:
- No broken markdown links
- No references to old patterns ("I'll provide a URL", etc.)
- Convention reference is linked in each skill
- Phase 0 flow is consistent across all skills (they all import from the shared reference)

**Step 2: Update version**

Check `package.json` or wherever the version is tracked. Bump to next minor version.

**Step 3: Commit**

```bash
git add -A
git commit -m "feat: bump to X.Y.Z — UX improvements (smart client detection, input prompts, setup-analytics skill)"
```
