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
| GSC MCP won't start | Check the Python path in `.mcp.json` matches your clone location. Verify the venv has dependencies: `cd /usr/local/share/mcp-gsc && source .venv/bin/activate && pip list \| grep google`. |
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
