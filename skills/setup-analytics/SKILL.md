---
name: setup-analytics
description: This skill should be used when the user asks to "set up analytics", "connect GA4", "connect Search Console", "configure GSC", "set up Google Analytics MCP", "setup service account", "analytics setup", "MCP setup", "connect Google data", or any request to configure the GA4 or GSC MCP connections. Also triggered from client onboarding when user selects "I need help setting this up" for analytics. Handles service account creation, credential placement, env var configuration, MCP enablement, and per-client property verification.
---

# Setup Analytics Skill

## Iron Law

NEVER store credentials in the project directory, git repos, or anywhere that could be committed. Credentials go in `~/.config/gcloud/` or another secure user-level location. ALWAYS confirm before writing any file or running any command.

Follow [references/ask-user-question-conventions.md](../../references/ask-user-question-conventions.md) for all AskUserQuestion prompts.

---

## Phase 0: Client Context

Follow the instructions in [references/client-context-phases.md](../../references/client-context-phases.md) — Phase 0 section.

If a client is active, Phase 4 will validate their specific GA4/GSC properties. If no client, the skill still sets up the shared infrastructure (service account, MCPs).

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

5. **Client-specific (if a client is active)**
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
Analytics Setup Status:

  Service account key          ~/.config/gcloud/service-account.json
  Service account email        local-seo-mcp@project.iam.gserviceaccount.com
  GOOGLE_APPLICATION_CREDENTIALS   set, path valid
  GOOGLE_CLOUD_PROJECT             set (your-project-id)
  GA4 MCP                      disabled in .mcp.json
  GSC MCP                      disabled in .mcp.json
  analytics-mcp package        not installed
  GSC MCP repo                 not found at /usr/local/share/mcp-gsc/
  Client GA4 Property ID       not set in profile
  Client GSC Site URL          not set in profile

6 items need attention.
```

If everything is ready, inform the user and end: "All analytics connections are configured and working."

If items need attention:

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

Check if `gcloud` CLI is available (`which gcloud`).

**If gcloud is installed (recommended path):**

Use AskUserQuestion:
**Question:** "How would you like to create the service account key?"
- "Use gcloud CLI (recommended)"
- "Download from browser instead"
- "I already have a key file"

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
**Question:** "The gcloud CLI makes key creation easier. How would you like to proceed?"
- "Install gcloud CLI first (recommended)" — provide: `brew install google-cloud-sdk`
- "Download from browser instead"

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

If "Show me the terminal commands":
```bash
mkdir -p ~/.config/gcloud
mv ~/Downloads/local-seo-mcp-*.json ~/.config/gcloud/service-account.json
chmod 600 ~/.config/gcloud/service-account.json
```

If "Let Claude set this up for me": run the above commands via Bash (confirm with user first).

### 3d: Environment Variables (if not set)

Use AskUserQuestion:
**Question:** "Environment variables need to be added to ~/.zshrc. How would you like to do this?"
- "I'll add them myself manually"
- "Show me the terminal commands"
- "Let Claude set this up for me"

If "Show me the terminal commands" or manual:
```bash
echo 'export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/service-account.json"' >> ~/.zshrc
echo 'export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"' >> ~/.zshrc
source ~/.zshrc
```

Replace YOUR_PROJECT_ID with the actual project ID (found at https://console.cloud.google.com/home/dashboard — it's the ID, not the display name).

If "Let Claude set this up for me": ask for the project ID first via open text, then run the commands via Bash.

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

If "Let Claude do it": use Edit tool to remove `"disabled": true` for both `ga4` and `gsc` entries. If the GSC MCP path doesn't match where the user installed it, update the path too.

### 3g: Grant GA4 and GSC Access (browser required)

This must be done per-client. Provide instructions using the service account email from Phase 1:

```
Grant GA4 access:
  Go to: https://analytics.google.com/
  Select the property for [client website]
  Admin > Property Access Management > "+" > Add users
  Email: [service account email]
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

Skip this phase if no client is active.

If a client is active:

1. **Update client profile** — write `ga4_property_id` and `gsc_site_url` to the profile frontmatter using Edit tool

2. **Test GA4 connection** — run a simple report for the property ID and verify it returns data for the correct domain. Show: "GA4 property `properties/123456789` returns data for [domain]"

3. **Test GSC connection** — run `get_search_analytics` for the site URL with a 7-day range. Show: "GSC property `[site URL]` has [N] queries in the last 7 days"

4. **Cross-validate** — confirm the GA4 domain and GSC site URL match the client's registered website. If they don't match, warn the user and ask them to verify.

---

## Phase 5: Final Verification

Run a complete status check (same as Phase 1) and display the updated status table. All items should show as ready.

If anything still fails, provide specific troubleshooting:

| Problem | Fix |
|---|---|
| "GOOGLE_APPLICATION_CREDENTIALS not set" | Run `source ~/.zshrc` or restart terminal |
| GA4 returns empty account list | Service account hasn't been granted Viewer access in the GA4 property |
| GSC returns "permission denied" | Service account hasn't been added as a user in the GSC property |
| "analytics-mcp not found" | Run `pipx install analytics-mcp`. Check `pipx list` |
| GSC MCP won't start | Check the Python path in `.mcp.json` matches your clone location |
| Both MCPs fail silently | Check the plugin's MCP status with `/mcp` |

Inform the user: "You may need to restart Claude Code or run `/mcp` for MCP changes to take effect."

---

## Tools to Use

- **Bash** — Check file existence, env vars, installed packages, run gcloud commands
- **Read / Edit** — Check and update `.mcp.json`, client profiles
- **AskUserQuestion** — All user interactions
- **GA4 MCP tools** — `get_account_summaries`, `run_report` (for testing)
- **GSC MCP tools** — `list_properties`, `get_search_analytics` (for testing)
