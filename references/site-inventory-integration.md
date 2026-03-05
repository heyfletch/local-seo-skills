# Site Inventory Integration

Shared instructions for loading and using the site inventory. Referenced by audit, plan, content, service-page, area-page, schema, gbp, and review-responder skills.

---

## When to Load

Run this check AFTER Phase 0 (Client Context), alongside Phase 0.5 (Analytics). Only runs when client context is active (mode = deliverable).

### Skip conditions

Skip if ANY of these are true:
- Mode is **quick** (no client context)
- The user passed `--quick` flag

### Step 1: Check for inventory

Check if `[client-path]/site-inventory/metadata.md` exists.

- If it exists → read it, carry the data forward as `site_inventory`
- If it doesn't exist → set `site_inventory = null`, continue without blocking

If the inventory exists but is older than 30 days (check the `**Crawled:**` date in the header), note this to the user: "Site inventory is [N] days old. Consider running `/client refresh-inventory` to update it." Do NOT block the skill.

### Step 2: Carry into phases

Pass `site_inventory` into subsequent phases. Skills should use it as described below.

---

## How Skills Use the Inventory

### Plan skill (Phase 3: Site Architecture)

- Read the full metadata table
- Before recommending any new page, fuzzy-match against existing URLs AND titles
- Classify each recommended page as: **exists — optimize**, **exists — restructure**, or **new — create**
- NEVER recommend creating a page that already exists

### Audit skill

- Read the full metadata table
- **On-page checks:** For every page in the inventory, check title tag (present, unique, includes keywords), meta description (present, correct length), H1 (present, single, includes keywords), schema markup (appropriate types present)
- **Gap detection:** Cross-reference client's services list against Service pages in inventory — flag any service without a dedicated page. Same for service areas vs Area pages.
- **Thin content:** Flag pages with word count under 300 (excluding contact/privacy)
- **Indexing issues:** Flag pages with `noindex` that should be indexed, or `index` pages that shouldn't be (like thank-you pages)
- **Schema coverage:** Report which pages have schema and which don't, by type
- When full page content is available (Content column has a link), read it for deeper on-page analysis

### Content skill

- Read the full metadata table
- **Content gap analysis:** Compare client's services and service areas against existing pages — missing ones become priority content items
- **Refresh scheduling:** Use the page list with word counts and dates to schedule content refreshes (prioritize thin or outdated pages)
- **Cannibalization check:** Before recommending a new blog topic, check if an existing service/area page already targets that keyword
- **Internal linking:** Reference actual existing page URLs when planning content that should link to them

### Service-page skill

- Read the metadata row for the target service (fuzzy-match service name against URLs and titles)
- If the page **exists**: read its full content from `pages/[slug].md`, operate in optimization/rewrite mode instead of creation mode
- If the page **doesn't exist**: proceed with creation, but use the inventory to suggest internal linking targets (other service pages, related area pages)
- After creating or optimizing a page, update the inventory metadata row for that page

### Area-page skill

- Same as service-page skill, but for area pages
- Additionally, show the user which areas already have pages and which don't, to help them choose what to create next

### Schema skill

- Read the Schema column from metadata
- Present a coverage report: which pages have schema, which don't, and what types are present
- When generating schema for a specific page, pre-populate the page URL, business name, and other details from the inventory + profile

### GBP skill

- Read Service page URLs from the inventory
- When setting up GBP predefined services, link each service to its corresponding page URL
- When creating GBP posts with CTAs, use actual page URLs as destinations

### Review-responder skill

- When client context is active and inventory exists, skip the WebFetch discovery step for service/area names
- Instead, extract service names from Service page titles and area names from Area page titles in the inventory
- Still WebFetch the homepage if needed for differentiators/taglines not captured in page titles
