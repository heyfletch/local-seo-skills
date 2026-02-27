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
