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
3. Check if `[client-path]/scope/` exists. If it does, read all `.md` files in it (e.g., `sow.md`). Extract:
   - **Committed deliverables** — what was promised in the SOW/proposal
   - **Timeline/milestones** — any deadlines or phase dates
   - **Specific KPIs or goals** — metrics the client expects
   - **Scope boundaries** — what's included vs. excluded
   Carry this scope context alongside the profile context. Skills should use it to align outputs with what was actually promised to the client.
4. Set `output_dir` to `[client-path]/deliverables/` (overrides the default or settings file value)
5. Set mode to **deliverable**
6. Carry all extracted context (profile + scope) into Phase 1 — pre-populate discovery fields so redundant questions are skipped

### How Phase 1 changes with client context

When client context is loaded, modify Phase 1 as follows:
- **Step 1 (Identify business):** SKIP — already known from profile
- **Step 2 (Auto-discover):** SKIP or minimal — only re-research if profile data looks incomplete (e.g., empty sections). Do NOT repeat WebSearch for data that's already in the profile.
- **Step 3+ (Scope, goals, data tools, etc.):** STILL ASK — but if scope docs define specific deliverables or goals for this skill type, pre-populate the scope/goals question with those details and confirm with the user rather than asking from scratch.
- **Information needed list:** Cross-reference with profile AND scope data. Only ask the user for items that are missing from both AND cannot be discovered via WebSearch.

### How scope docs guide skill output

When scope docs are present, skills should:
- **Prioritize SOW deliverables** — if the SOW lists specific pages, reports, or tasks, the skill should address those first
- **Match SOW terminology** — use the same service names, area names, and phrasing from the proposal
- **Flag scope gaps** — if the skill discovers work that should be done but isn't in the SOW, mention it as a recommendation (not a commitment)
- **Never over-deliver silently** — if the skill output exceeds what was promised, note this so the user can decide whether to include it or save it for a future engagement

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
