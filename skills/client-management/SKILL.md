---
name: client-management
description: This skill should be used when the user asks to "set up a client", "create a client profile", "manage clients", "switch client", "view client info", "update client profile", "list my clients", or any client setup and management task. Handles creating client profiles via interview, viewing/updating existing profiles, and managing the client registry. Individual SEO skills (audit, plan, etc.) handle their own client lookups via Phase 0.
---

# Client Management Skill

## Iron Law

ALWAYS confirm the client folder path with the user before creating any files. NEVER assume a directory structure. NEVER overwrite an existing profile without confirmation.

---

## Settings

Before starting, check if `.claude/local-seo.local.md` exists. If it does, read it and extract settings from the YAML frontmatter:

- `output_dir` — default directory suggestion for new client folders (default: `~/Desktop/`)
- `auto_open` — whether to auto-open files in browser (default: `true`)

---

## Mode Detection

Check if an argument was provided:

- **No argument or `list`** → List Mode: show all registered clients
- **`new`** → Create Mode: start the new client interview
- **`[slug]`** → View Mode: show that client's profile and offer actions

Check the registry at `${CLAUDE_PLUGIN_ROOT}/references/clients/registry.md`. Read the YAML frontmatter to get the `clients` map.

---

## List Mode

If the registry has clients:
1. Display each client: name, slug, folder path, number of deliverables completed
2. Offer actions via AskUserQuestion:
   - "Select a client to view"
   - "Create a new client"
   - "Update a client"

If the registry is empty:
1. Inform the user: "No clients registered yet."
2. Offer to create one.

---

## Create Mode (New Client Interview)

<HARD-GATE>
DO NOT create any files until the user has confirmed all details.
</HARD-GATE>

### Step 1: Business name

Use AskUserQuestion:
**Question:** "What's the client or business name?"
- Open text input (user types the name)

### Step 2: Client folder path

Use AskUserQuestion:
**Question:** "Where should I store this client's SEO data?"
- "Suggest a path for me" — use `[output_dir]/clients/[slug]/` as default
- "I'll provide a path" — user types a custom path

Confirm the path. If the directory doesn't exist, create it (with user confirmation).

### Step 3: Auto-discover

Use WebSearch to discover:
- Website URL
- Google Business Profile URL
- Industry / business type
- Services offered
- Service areas (cities/regions)
- Top 3-5 competitors
- GA4 Property ID (if the user has GA4 configured for this client)
- GSC Site URL (the verified property URL in Search Console)

Present all findings via AskUserQuestion. Let the user confirm, correct, or skip each section.

### Step 4: ICP and brand (optional)

Use AskUserQuestion:
**Question:** "Do you want to set up target audience and brand guidelines now?"
- "Yes — let's do it now"
- "Skip for now — I'll add these later"

If yes:
- Ask about ideal customer profile (demographics, pain points, buying triggers)
- Ask about brand voice (formal/casual, terminology preferences, tone)

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

### Step 4.5: Scope documents (SOW / Proposal)

Use AskUserQuestion:
**Question:** "Do you have a Statement of Work, Proposal, or scope document for this client?"
- "Yes — I'll provide the file path"
- "Skip for now — I'll add one later"

If yes:

1. Ask for the file path. Accepted formats (converted via MarkItDown):
   - **PDF** (.pdf) — recommended if exporting from Pages, Word, or Google Docs
   - **Word** (.docx)
   - **PowerPoint** (.pptx)
   - **HTML** (.html)
   - **Markdown** (.md) — no conversion needed

2. Create `[client-path]/scope/` directory

3. If the file is already `.md`, copy it directly to `[client-path]/scope/sow.md`

4. If the file is any other supported format, convert it:
   ```bash
   markitdown "[source-file]" > "[client-path]/scope/sow.md"
   ```
   If `markitdown` is not installed, install it first:
   ```bash
   pip install markitdown
   ```

5. Read the converted `sow.md` and present a summary to the user:
   - List of deliverables/services promised
   - Timeline or milestones (if present)
   - Any specific KPIs or goals mentioned

   Ask the user to confirm the conversion looks correct. If the conversion is poor (e.g., tables mangled, content missing), suggest trying a different source format — PDF generally works best.

6. Also copy the original source file into `[client-path]/scope/` as-is (e.g., `proposal.pdf`) so there's always a reference copy.

Users can add more scope docs later by dropping files into the `scope/` folder and running `/client [slug]` to re-convert them.

### Step 5: Write the profile

1. Read the template at `${CLAUDE_PLUGIN_ROOT}/references/client-profile-template.md`
2. Fill in all discovered and confirmed data
3. Set the YAML frontmatter: slug, name, website, gbp_url, ga4_property_id, gsc_site_url, industry, created date
4. Write `profile.md` to the client folder path
5. Create `work-log.md` in the client folder with a header:

```markdown
# Work Log: [Business Name]

Dated entries from skill runs and client work.

---
```

6. Create `deliverables/` subdirectory in the client folder
7. Create `scope/` subdirectory in the client folder (if not already created in Step 4.5)
8. Add the client to the registry (`${CLAUDE_PLUGIN_ROOT}/references/clients/registry.md`) — update the YAML frontmatter `clients` map with the new slug, name, and path

### Step 6: Confirm

Print to terminal:
- "Client profile created for [Business Name]"
- "Profile: [path]/profile.md"
- "Deliverables will be saved to: [path]/deliverables/"
- "Scope docs: [path]/scope/" (if scope docs were added)
- "You can now run any skill and it will use this client's context."

---

## View Mode

1. Read the client's `profile.md` from the registered path
2. Display a summary: business name, website, industry, services, service areas, competitors
3. If `scope/` has files, list them and show a brief summary of SOW deliverables/commitments
4. If `work-log.md` exists, show the last 3 entries
5. If `deliverables/` has files, list them with dates
6. Read `references/client-deliverables.md` and show which standard deliverables have been completed vs. remaining

Offer actions via AskUserQuestion:
- "Update this profile" — re-run discovery or let user edit sections
- "Add or update scope docs" — upload a new SOW/proposal (uses Step 4.5 conversion flow)
- "View full work log"
- "Run a skill for this client" — then ask which skill
- "Go back to client list"

---

## Red Flags

| Thought | Reality |
|---|---|
| "I'll just create the folder without asking" | ALWAYS confirm the path. Users have different directory structures. |
| "I'll skip the auto-discover and just ask everything" | Auto-discover first, then confirm. Saves the user typing. |
| "The profile is good enough without competitors" | Competitors are critical for SEO work. Discover them. |
| "I'll overwrite the existing profile with fresh data" | NEVER overwrite without confirmation. Profiles accumulate manually-added context. |

---

## Tools to Use

- **WebSearch / WebFetch** — Auto-discover business details, GBP, competitors
- **Read / Write / Edit** — Profile and registry file management
- **Glob** — Check for existing files in client folders
- **AskUserQuestion** — All user interactions
- **Bash** — Create directories, open files
