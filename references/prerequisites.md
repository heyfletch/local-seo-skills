## Google Analytics & Search Console Setup

These MCPs let skills pull live GA4 and GSC data for clients. Both are **optional** — skills fall back gracefully without them.

**Recommended:** Run `/setup-analytics` for a guided interactive walkthrough that audits your current state, walks you through each step, and verifies connections. The skill handles everything: GCP project setup, service account creation (via `gcloud` CLI or browser), credential placement, env vars, MCP installation, enablement, and per-client property validation.

### Manual Setup Reference

If you prefer to set things up manually, expand the section below.

<details>
<summary>Manual GCP and MCP setup steps</summary>

Both use a single GCP service account that you grant access to each client's GA4 and GSC properties.

**1. Create a GCP project** at https://console.cloud.google.com/ > New Project

**2. Enable APIs** at https://console.cloud.google.com/apis/library:
- Google Analytics Data API
- Google Analytics Admin API
- Search Console API

**3. Create a service account** at https://console.cloud.google.com/iam-admin/serviceaccounts > Create Service Account > name: `local-seo-mcp`

**4. Create and place the key file** (recommended: use gcloud CLI):
```bash
gcloud iam service-accounts keys create ~/.config/gcloud/service-account.json \
  --iam-account=local-seo-mcp@YOUR_PROJECT.iam.gserviceaccount.com
chmod 600 ~/.config/gcloud/service-account.json
```

Or download via browser: Service account > Keys tab > Add Key > JSON > then move:
```bash
mkdir -p ~/.config/gcloud
mv ~/Downloads/local-seo-mcp-*.json ~/.config/gcloud/service-account.json
chmod 600 ~/.config/gcloud/service-account.json
```

**5. Set environment variables** in `~/.zshrc`:
```bash
echo 'export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/service-account.json"' >> ~/.zshrc
echo 'export GOOGLE_CLOUD_PROJECT="your-gcp-project-id"' >> ~/.zshrc
source ~/.zshrc
```

**6. Grant GA4 access** per client: Analytics > Admin > Property Access Management > Add service account email as Viewer

**7. Grant GSC access** per client: Search Console > Settings > Users and permissions > Add service account email as Restricted

**8. Install GSC MCP:**
```bash
sudo mkdir -p /usr/local/share/mcp-gsc && sudo chown $(whoami) /usr/local/share/mcp-gsc
git clone https://github.com/AminForou/mcp-gsc.git /usr/local/share/mcp-gsc
cd /usr/local/share/mcp-gsc && python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt && deactivate
```

**9. Install GA4 MCP:**
```bash
pipx install analytics-mcp
```

**10. Enable in .mcp.json:** Remove `"disabled": true` from both `ga4` and `gsc` entries.

**11. Verify:** Restart Claude Code or run `/mcp`, then test with "List my GA4 account summaries" and "List my Search Console properties".

</details>

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
