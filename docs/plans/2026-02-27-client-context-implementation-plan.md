# Client Context System — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add persistent client data management so skills accumulate context over time instead of re-discovering from scratch each session.

**Architecture:** A client registry file maps slugs to external folder paths. Each client folder contains a profile, work log, and deliverables directory. Skills gain a Phase 0 (client lookup) and Phase 3.5 (profile update offer). A new `/client` command handles setup and management.

**Tech Stack:** Markdown with YAML frontmatter. No code — all changes are to skill/command instruction files and reference templates.

**Design doc:** `docs/plans/2026-02-27-client-context-system-design.md`

---

### Task 1: Create the client profile template

**Files:**
- Create: `references/client-profile-template.md`

**Step 1: Write the template file**

```markdown
---
slug: ""
name: ""
website: ""
gbp_url: ""
industry: ""
created: ""
deliverables_completed: []
---

# Client Context: [Business Name]

## Business Description
[Filled during interview or auto-discovered]

## ICP / Target Audience
[Who they serve, demographics, pain points]

## Services
[List of services offered]

## Service Areas
[Cities/regions served]

## Voice & Brand Guidelines
[Tone, style, terminology preferences]

## Competitors
[Top 3-5 with URLs]

## Current SEO Status
[Baseline metrics, known issues — updated after audits]
```

**Step 2: Verify the file**

Run: `cat references/client-profile-template.md | head -5`
Expected: The YAML frontmatter header with `slug: ""`

**Step 3: Commit**

```bash
git add references/client-profile-template.md
git commit -m "Add client profile template for persistent client context"
```

---

### Task 2: Create the standard deliverable catalog

**Files:**
- Create: `references/client-deliverables.md`

**Step 1: Write the deliverable catalog**

```markdown
# Standard Client Deliverables

Documents that can be generated for any client. Skills check this list and suggest creating relevant documents when appropriate.

## Strategic Documents
- SEO & Digital Marketing Roadmap — comprehensive strategy guide (`/plan`)
- Client Overview Presentation — executive summary for stakeholders (`/plan`)
- Competitor Analysis Report — detailed competitive landscape (`/audit`, `/plan`)

## Technical Documents
- Website Sitemap Spreadsheet — current page inventory + planned pages (`/plan`)
- Schema Markup Package — all JSON-LD for the site (`/schema`)
- Technical SEO Checklist — crawl issues, speed, mobile, etc. (`/audit`)

## Content Documents
- Content Calendar — 3-month editorial plan (`/content`)
- Service Page Copy — all service pages (`/service-page`)
- Area Page Copy — all location/area pages (`/area-page`)
- GBP Post Calendar — monthly GBP posting plan (`/gbp`)
- Review Response Templates — response library (`/reviews`)

## Skill-to-Deliverable Suggestions

After completing a skill in deliverable mode, suggest related documents the user hasn't generated yet:

| Skill completed | Suggest next |
|---|---|
| `/audit` | Roadmap, Technical Checklist, Schema Package |
| `/plan` | Client Overview Presentation, Sitemap Spreadsheet, Content Calendar |
| `/service-page` | Schema Package (if not done), more service pages from the plan |
| `/area-page` | More area pages from the plan |
| `/gbp` | Content Calendar, Review Strategy |
| `/content` | Service Pages, Area Pages (content to create) |
| `/reviews` | GBP optimization (review responses tie to GBP) |
| `/schema` | More schema types if site has multiple page types |
```

**Step 2: Verify the file**

Run: `head -3 references/client-deliverables.md`
Expected: `# Standard Client Deliverables`

**Step 3: Commit**

```bash
git add references/client-deliverables.md
git commit -m "Add standard client deliverable catalog with skill-to-deliverable mapping"
```

---

### Task 3: Create empty client registry and update .gitignore

**Files:**
- Create: `references/clients/.gitkeep`
- Create: `references/clients/registry.md`
- Modify: `.gitignore`

**Step 1: Create the clients directory and empty registry**

Create `references/clients/registry.md`:

```markdown
---
clients: {}
---

# Client Registry

This file maps client slugs to their folder paths. It is gitignored because it contains user-specific paths.

To add a client, use `/client new` or any skill will offer to create one.
```

Create `references/clients/.gitkeep` as an empty file (so the directory is preserved in git even though the registry is gitignored).

**Step 2: Update .gitignore**

Add to the end of `.gitignore`:

```
references/clients/registry.md
```

**Step 3: Verify**

Run: `cat .gitignore | tail -3`
Expected: Should show `references/clients/registry.md` at the end.

Run: `ls references/clients/`
Expected: `.gitkeep` and `registry.md`

**Step 4: Commit**

```bash
git add references/clients/.gitkeep .gitignore
git commit -m "Add client registry directory and gitignore user-specific registry file"
```

---

### Task 4: Create the client-management skill

**Files:**
- Create: `skills/client-management/SKILL.md`

**Step 1: Write the skill file**

This is the core skill that backs the `/client` command. It handles creating new clients, viewing existing ones, and managing client profiles.

```markdown
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

Present all findings via AskUserQuestion. Let the user confirm, correct, or skip each section.

### Step 4: ICP and brand (optional)

Use AskUserQuestion:
**Question:** "Do you want to set up target audience and brand guidelines now?"
- "Yes — let's do it now"
- "Skip for now — I'll add these later"

If yes:
- Ask about ideal customer profile (demographics, pain points, buying triggers)
- Ask about brand voice (formal/casual, terminology preferences, tone)

### Step 5: Write the profile

1. Read the template at `${CLAUDE_PLUGIN_ROOT}/references/client-profile-template.md`
2. Fill in all discovered and confirmed data
3. Set the YAML frontmatter: slug, name, website, gbp_url, industry, created date
4. Write `profile.md` to the client folder path
5. Create `work-log.md` in the client folder with a header:

```markdown
# Work Log: [Business Name]

Dated entries from skill runs and client work.

---
```

6. Create `deliverables/` subdirectory in the client folder
7. Add the client to the registry (`${CLAUDE_PLUGIN_ROOT}/references/clients/registry.md`) — update the YAML frontmatter `clients` map with the new slug, name, and path

### Step 6: Confirm

Print to terminal:
- "Client profile created for [Business Name]"
- "Profile: [path]/profile.md"
- "Deliverables will be saved to: [path]/deliverables/"
- "You can now run any skill and it will use this client's context."

---

## View Mode

1. Read the client's `profile.md` from the registered path
2. Display a summary: business name, website, industry, services, service areas, competitors
3. If `work-log.md` exists, show the last 3 entries
4. If `deliverables/` has files, list them with dates
5. Read `references/client-deliverables.md` and show which standard deliverables have been completed vs. remaining

Offer actions via AskUserQuestion:
- "Update this profile" — re-run discovery or let user edit sections
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
```

**Step 2: Verify the file**

Run: `head -3 skills/client-management/SKILL.md`
Expected: YAML frontmatter opening `---`

**Step 3: Commit**

```bash
git add skills/client-management/SKILL.md
git commit -m "Add client-management skill for client setup, viewing, and profile management"
```

---

### Task 5: Create the /client command

**Files:**
- Create: `commands/client.md`

**Step 1: Write the command file**

Follow the exact pattern of existing commands (frontmatter with name, description, argument-hint, allowed-tools, then body text).

```markdown
---
name: client
description: Set up, view, or manage client profiles for persistent context across skills
argument-hint: "[new | client-slug | list]"
allowed-tools:
  - WebSearch
  - WebFetch
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - AskUserQuestion
  - TaskCreate
  - TaskUpdate
  - TaskList
  - Bash
  - ToolSearch
---

Manage client profiles using the `local-seo:client-management` skill. Invoke the skill, then follow its process for the requested mode.

**Modes:**
- `/client` or `/client list` — List all registered clients and their status
- `/client new` — Start the new client interview to create a profile
- `/client [slug]` — View a specific client's profile, work log, and deliverables

If the user provided an argument, pass it to determine the mode. If no argument, default to list mode (or create mode if no clients exist yet).
```

**Step 2: Verify**

Run: `head -5 commands/client.md`
Expected: YAML frontmatter with `name: client`

**Step 3: Commit**

```bash
git add commands/client.md
git commit -m "Add /client slash command for client profile management"
```

---

### Task 6: Create the shared Phase 0 and Phase 3.5 reference

**Files:**
- Create: `references/client-context-phases.md`

This is a shared reference that all 9 client-facing skills will point to, avoiding duplication of the Phase 0 and Phase 3.5 logic across 9 files.

**Step 1: Write the shared reference**

```markdown
# Client Context Phases

Shared instructions for Phase 0 (Client Lookup) and Phase 3.5 (Profile Update). Referenced by all client-facing skills.

---

## Phase 0: Client Context

Run this phase BEFORE the skill's own Phase 1 (Discovery).

### Step 1: Check flags

Parse the user's command for flags:
- `--quick` → Set mode to **quick**. Skip all client context. Proceed directly to Phase 1 as normal.
- `--deliverable` → Set mode to **deliverable**. Client context is required — create profile if none exists.
- No flags → Set mode to **infer** (see Step 3).

### Step 2: Read the registry

Read `${CLAUDE_PLUGIN_ROOT}/references/clients/registry.md` and parse the YAML frontmatter `clients` map.

- If the registry file doesn't exist or has no clients AND mode is **infer** → ask:

  **Question:** "Do you want to associate this with a client profile?"
  - "Yes — create a new client profile" → run the `client-management` skill in Create Mode, then return here with the new client loaded
  - "No — run in quick mode" → set mode to **quick**, proceed to Phase 1

- If the registry has clients → ask:

  **Question:** "Which client is this for?"
  - Options: [list each client by name] + "New client" + "No client (quick mode)"

  If "New client" → run the `client-management` skill in Create Mode, then return here.
  If "No client" → set mode to **quick**, proceed to Phase 1.
  Otherwise → load that client's profile.

### Step 3: Load client context

If a client was selected:
1. Read `profile.md` from the client's registered path
2. Extract all business context: name, website, GBP URL, industry, services, service areas, competitors, ICP, brand voice, current SEO status
3. Set `output_dir` to `[client-path]/deliverables/` (overrides the default or settings file value)
4. Set mode to **deliverable**
5. Carry all extracted context into Phase 1 — pre-populate discovery fields so redundant questions are skipped

### How Phase 1 changes with client context

When client context is loaded, modify Phase 1 as follows:
- **Step 1 (Identify business):** SKIP — already known from profile
- **Step 2 (Auto-discover):** SKIP or minimal — only re-research if profile data looks incomplete (e.g., empty sections). Do NOT repeat WebSearch for data that's already in the profile.
- **Step 3+ (Scope, goals, data tools, etc.):** STILL ASK — these are task-specific, not client-level
- **Information needed list:** Cross-reference with profile data. Only ask the user for items that are missing from the profile AND cannot be discovered via WebSearch.

---

## Phase 3.5: Client Profile Update

Run this phase AFTER the skill's output phase, ONLY when client context is active (mode = deliverable).

Skip this entire phase if mode = quick.

### Step 1: Offer to update

Use AskUserQuestion:

**Question:** "Should I update the client profile with this work?"
- "Add summary to work log" → append a dated entry to `work-log.md`
- "Save as reference doc" → write a summary `.md` file in the client folder
- "Both" → do both
- "Skip" → do nothing

### Step 2: Update work log (if selected)

Append to `[client-path]/work-log.md`:

```
## YYYY-MM-DD — [Skill Name]: [Brief Title]

[2-4 sentence summary of what was done, key findings, and outputs]

**Deliverable:** `deliverables/[filename]`
```

### Step 3: Save reference doc (if selected)

Write a summary markdown file to the client folder (not in deliverables/):
- Filename: `YYYY-MM-DD-[skill]-summary.md`
- Content: key findings, metrics, recommendations — a quick-reference version of the HTML deliverable

### Step 4: Update profile frontmatter

Add the deliverable to the `deliverables_completed` list in `profile.md` YAML frontmatter:

```yaml
deliverables_completed:
  - type: [skill-type]
    date: YYYY-MM-DD
    path: deliverables/[filename]
```

### Step 5: Suggest next deliverables

Read `${CLAUDE_PLUGIN_ROOT}/references/client-deliverables.md`. Cross-reference the "Skill-to-Deliverable Suggestions" table with the client's `deliverables_completed` list.

If there are suggested deliverables the client doesn't have yet, mention them:
"Based on this [skill], you might also want to generate: [list]. Run `/[skill]` to create them."

Keep this brief — one sentence, not a sales pitch.
```

**Step 2: Verify**

Run: `head -5 references/client-context-phases.md`
Expected: `# Client Context Phases`

**Step 3: Commit**

```bash
git add references/client-context-phases.md
git commit -m "Add shared Phase 0 and Phase 3.5 client context reference for all skills"
```

---

### Task 7: Update the audit skill with Phase 0 and Phase 3.5

**Files:**
- Modify: `skills/local-seo-audit/SKILL.md`

This task establishes the exact edit pattern that Tasks 8-15 will replicate for the other 8 skills.

**Step 1: Add Phase 0 after Settings, before Phase 1**

Insert the following block between the `## Settings` section (after "Use these values in the output phase. If the file doesn't exist, use defaults.") and `## Phase 1: Discovery`:

```markdown

---

## Phase 0: Client Context

Follow the instructions in [references/client-context-phases.md](../../references/client-context-phases.md) — Phase 0 section.

This determines whether the skill runs in **quick mode** (today's behavior) or **deliverable mode** (with client profile pre-loaded).

If client context is loaded:
- Phase 1 Steps 1-2 are skipped (business already identified)
- Output directory is set to `[client-path]/deliverables/`
- All business context is pre-populated from the profile

```

**Step 2: Add Phase 3.5 after Phase 4 (Report Generation), before Red Flags**

Insert the following block between Phase 4's last line ("Print to terminal ONLY: 3-5 bullet summary + file path") and `## Red Flags`:

```markdown

---

## Phase 3.5: Client Profile Update

Follow the instructions in [references/client-context-phases.md](../../references/client-context-phases.md) — Phase 3.5 section.

Only runs when client context is active. Offers to update the work log, save a reference doc, track the deliverable, and suggest related standard deliverables.

```

**Step 3: Verify edits**

Run: `grep -n "Phase 0\|Phase 3.5" skills/local-seo-audit/SKILL.md`
Expected: Two matches — Phase 0 and Phase 3.5 at their respective positions.

**Step 4: Commit**

```bash
git add skills/local-seo-audit/SKILL.md
git commit -m "Add Phase 0 client context and Phase 3.5 profile update to audit skill"
```

---

### Task 8: Update the plan skill with Phase 0 and Phase 3.5

**Files:**
- Modify: `skills/local-seo-plan/SKILL.md`

**Step 1: Apply the same pattern as Task 7**

Insert Phase 0 between `## Settings` and `## Phase 1: Discovery`.
Insert Phase 3.5 between `## Phase 5: Report Generation` (after "Print to terminal ONLY: 3-5 bullet summary + file path") and `## Red Flags`.

Use the exact same Phase 0 and Phase 3.5 text blocks from Task 7 (they reference the shared file).

**Step 2: Verify**

Run: `grep -n "Phase 0\|Phase 3.5" skills/local-seo-plan/SKILL.md`
Expected: Two matches.

**Step 3: Commit**

```bash
git add skills/local-seo-plan/SKILL.md
git commit -m "Add Phase 0 client context and Phase 3.5 profile update to plan skill"
```

---

### Task 9: Update the service-page skill with Phase 0 and Phase 3.5

**Files:**
- Modify: `skills/local-seo-service-page/SKILL.md`

**Step 1: Apply the same pattern**

Insert Phase 0 between `## Settings` and `## Phase 1: Discovery`.
Insert Phase 3.5 between the output phase (Phase 3 in this skill — after "Print to terminal ONLY: 2-3 bullet summary + file path" or equivalent) and `## Red Flags`.

**Step 2: Verify**

Run: `grep -n "Phase 0\|Phase 3.5" skills/local-seo-service-page/SKILL.md`
Expected: Two matches.

**Step 3: Commit**

```bash
git add skills/local-seo-service-page/SKILL.md
git commit -m "Add Phase 0 client context and Phase 3.5 profile update to service-page skill"
```

---

### Task 10: Update the area-page skill with Phase 0 and Phase 3.5

**Files:**
- Modify: `skills/local-seo-area-page/SKILL.md`

**Step 1: Apply the same pattern**

Insert Phase 0 between `## Settings` and `## Phase 1: Discovery`.
Insert Phase 3.5 between the output phase and `## Red Flags`.

**Step 2: Verify and commit**

```bash
grep -n "Phase 0\|Phase 3.5" skills/local-seo-area-page/SKILL.md
git add skills/local-seo-area-page/SKILL.md
git commit -m "Add Phase 0 client context and Phase 3.5 profile update to area-page skill"
```

---

### Task 11: Update the gbp skill with Phase 0 and Phase 3.5

**Files:**
- Modify: `skills/local-seo-gbp/SKILL.md`

**Step 1: Apply the same pattern**

Insert Phase 0 between `## Settings` and `## Phase 1: Discovery`.
Insert Phase 3.5 between the output phase and `## Red Flags`.

**Step 2: Verify and commit**

```bash
grep -n "Phase 0\|Phase 3.5" skills/local-seo-gbp/SKILL.md
git add skills/local-seo-gbp/SKILL.md
git commit -m "Add Phase 0 client context and Phase 3.5 profile update to gbp skill"
```

---

### Task 12: Update the content skill with Phase 0 and Phase 3.5

**Files:**
- Modify: `skills/local-seo-content/SKILL.md`

**Step 1: Apply the same pattern**

Insert Phase 0 between `## Settings` and `## Phase 1: Discovery`.
Insert Phase 3.5 between the output phase and `## Red Flags`.

**Step 2: Verify and commit**

```bash
grep -n "Phase 0\|Phase 3.5" skills/local-seo-content/SKILL.md
git add skills/local-seo-content/SKILL.md
git commit -m "Add Phase 0 client context and Phase 3.5 profile update to content skill"
```

---

### Task 13: Update the reviews skill with Phase 0 and Phase 3.5

**Files:**
- Modify: `skills/local-seo-reviews/SKILL.md`

**Step 1: Apply the same pattern**

Insert Phase 0 between `## Settings` and `## Phase 1: Discovery`.
Insert Phase 3.5 between the output phase and `## Red Flags`.

**Step 2: Verify and commit**

```bash
grep -n "Phase 0\|Phase 3.5" skills/local-seo-reviews/SKILL.md
git add skills/local-seo-reviews/SKILL.md
git commit -m "Add Phase 0 client context and Phase 3.5 profile update to reviews skill"
```

---

### Task 14: Update the schema skill with Phase 0 and Phase 3.5

**Files:**
- Modify: `skills/local-seo-schema/SKILL.md`

**Step 1: Apply the same pattern**

Insert Phase 0 between `## Settings` and `## Phase 1: Discovery`.
Insert Phase 3.5 between the output phase and `## Red Flags`.

**Step 2: Verify and commit**

```bash
grep -n "Phase 0\|Phase 3.5" skills/local-seo-schema/SKILL.md
git add skills/local-seo-schema/SKILL.md
git commit -m "Add Phase 0 client context and Phase 3.5 profile update to schema skill"
```

---

### Task 15: Update the agency skill with Phase 0 and Phase 3.5

**Files:**
- Modify: `skills/local-seo-agency/SKILL.md`

The agency skill is slightly different — it's about the user's agency, not a specific client. However, it still benefits from client context when the user is working on agency deliverables for a specific client.

**Step 1: Apply the same pattern**

Insert Phase 0 between `## Settings` and `## Phase 1: Discovery`.
Insert Phase 3.5 between the output phase and `## Red Flags`.

**Step 2: Verify and commit**

```bash
grep -n "Phase 0\|Phase 3.5" skills/local-seo-agency/SKILL.md
git add skills/local-seo-agency/SKILL.md
git commit -m "Add Phase 0 client context and Phase 3.5 profile update to agency skill"
```

---

### Task 16: Update all 9 client-facing command files with flag support

**Files:**
- Modify: `commands/audit.md`
- Modify: `commands/plan.md`
- Modify: `commands/service-page.md`
- Modify: `commands/area-page.md`
- Modify: `commands/gbp.md`
- Modify: `commands/content.md`
- Modify: `commands/reviews.md`
- Modify: `commands/schema.md`
- Modify: `commands/agency.md`

**Step 1: Update each command file**

For each of the 9 command files, add the following paragraph at the end of the body text (after the existing final paragraph):

```markdown

**Client context flags:**
- `--quick` — Skip client lookup, run in stateless mode (today's default behavior)
- `--deliverable` — Force client context mode, create a client profile if none exists

If no flags are provided, the skill infers the mode: if a client registry exists with entries, it asks which client; otherwise it runs in quick mode.
```

Also update the `argument-hint` in each command's frontmatter to include the flags. For example, `audit.md` changes from:
```yaml
argument-hint: "[business URL or name]"
```
to:
```yaml
argument-hint: "[business URL or name] [--quick | --deliverable]"
```

Apply this pattern to all 9 commands, preserving each command's existing argument-hint text and appending the flags.

**Step 2: Verify**

Run: `grep "argument-hint" commands/*.md`
Expected: All 9 client-facing commands show `[--quick | --deliverable]` in their argument-hint. The `ingest-insights.md` command should NOT be modified (it doesn't deal with clients).

**Step 3: Commit**

```bash
git add commands/audit.md commands/plan.md commands/service-page.md commands/area-page.md commands/gbp.md commands/content.md commands/reviews.md commands/schema.md commands/agency.md
git commit -m "Add --quick and --deliverable flag support to all 9 client-facing commands"
```

---

### Task 17: Final verification and summary commit

**Step 1: Verify all new files exist**

Run: `ls -la references/client-profile-template.md references/client-deliverables.md references/client-context-phases.md references/clients/registry.md references/clients/.gitkeep skills/client-management/SKILL.md commands/client.md`

Expected: All 7 files exist.

**Step 2: Verify all skills have Phase 0 and Phase 3.5**

Run: `grep -l "Phase 0" skills/*/SKILL.md | wc -l`
Expected: `9` (all client-facing skills, not ingest-insights)

Run: `grep -l "Phase 3.5" skills/*/SKILL.md | wc -l`
Expected: `9`

**Step 3: Verify all commands have flag support**

Run: `grep -c "quick.*deliverable" commands/*.md`
Expected: 9 commands with a count of 1+ each, `ingest-insights.md` with 0.

**Step 4: Verify .gitignore**

Run: `grep "registry" .gitignore`
Expected: `references/clients/registry.md`

**Step 5: Run git status to check for anything missed**

Run: `git status`
Expected: Clean working tree (all changes committed in prior tasks).

**Step 6: If all checks pass, no additional commit needed. Print summary.**

Print to terminal:
```
Client Context System implementation complete.

New files (5):
  - references/client-profile-template.md
  - references/client-deliverables.md
  - references/client-context-phases.md
  - skills/client-management/SKILL.md
  - commands/client.md

Infrastructure (2):
  - references/clients/registry.md (gitignored)
  - references/clients/.gitkeep

Modified files (18):
  - .gitignore
  - 9 skill SKILL.md files (Phase 0 + Phase 3.5)
  - 9 command .md files (--quick/--deliverable flags)

To use: Run /client new to create your first client profile, then any skill will use that context automatically.
```
