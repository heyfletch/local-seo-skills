---
name: ingest-insights
description: This skill should be used when the user asks to "ingest new info", "process inbox", "sync new knowledge", "update skills with new info", "ingest these docs", "process new articles", "review inbox items", "what's in the inbox", "apply inbox changes", or any mention of ingesting external knowledge into plugin skills. Manages a structured inbox workflow for evaluating, diffing, and applying expert-level information to existing skill files. For editing individual skills directly, use skill-specific workflows instead.
---

# Ingest Insights

## Iron Law

NO EDITS TO SKILLS WITHOUT COMPLETING PHASES 1-5 FIRST. Default mode is dry-run (Ingest → Evaluate → Analyze → Diff → Recommend). Edits only happen in Phase 6 after explicit user approval ("apply", "implement", "go", or similar). When in doubt about content quality, classify as USEFUL and let the user decide.

---

## Settings

Before starting Phase 1, check if `.claude/local-seo.local.md` exists. If it does, read it and extract settings from the YAML frontmatter:

- `output_dir` — directory for saving reports (default: `~/Desktop/`)
- `auto_open` — whether to auto-open reports in browser (default: `true`)

Use these values when saving the sync report. If the file doesn't exist, use defaults.

---

## First-Run Setup

On first invocation, check for and create the inbox directory structure if missing:

```
inbox/
├── processed/    # Successfully applied items (timestamped)
├── rejected/     # Noise items with rejection reasons
└── reports/      # Sync reports (sync-YYYY-MM-DD.md)
```

Create these directories at the plugin root (`${CLAUDE_PLUGIN_ROOT}/inbox/` etc.) using Bash `mkdir -p`.

---

## Phase 1: Ingest

<HARD-GATE>
DO NOT proceed to Phase 2 until all inbox items are read and summarized.
</HARD-GATE>

### Binary File Conversion (pre-scan sub-step)

Before reading any files, check for binary formats that need conversion:

1. Glob `${CLAUDE_PLUGIN_ROOT}/inbox/` for `*.pdf`, `*.docx`, `*.pptx`, `*.xlsx` (exclude subdirectories). If none found, skip to "Read and Summarize" below.
2. If binary files exist, check if `markitdown` is installed:
   - Run `which markitdown` via Bash.
   - **If installed** → convert each binary file:
     - Run `markitdown "<file>" > "<file>.md"` to save the converted markdown in `inbox/` alongside the original.
     - If conversion fails (non-zero exit or empty output), log a warning and fall back to the Read tool for that specific file.
     - On success, move the original binary to `inbox/processed/YYYY-MM-DD-<original-filename>`.
   - **If not installed** → check if pip is available:
     - Run `which pip3 || which pip` via Bash.
     - **If no pip** → skip markitdown, use Read tool fallback (see below).
     - **If pip available** → ask the user via AskUserQuestion: "markitdown is not installed but can be added with pip. Install it? (This enables better conversion of DOCX, PPTX, XLSX, and PDF files to markdown.)"
       - **User says yes** → run `pip install --user markitdown` via Bash (the `--user` flag avoids "externally managed environment" errors on macOS/modern Linux). If it fails, retry once with `pipx install markitdown` if `pipx` is available. If both fail, fall back to Read tool.
       - **User says no** → fall back to Read tool.
3. **Read tool fallback**: When markitdown is unavailable, attempt to read binary files directly with the Read tool (use `pages` parameter for PDFs). If Read succeeds, produce the structured summary for that file immediately (same format as "Read and Summarize" below) and move the binary to `inbox/processed/YYYY-MM-DD-<original-filename>` so it is not re-read. If Read fails for a file (e.g., DOCX/PPTX/XLSX that Claude cannot parse), log a warning to the user and skip that file.

### Read and Summarize

1. Scan `${CLAUDE_PLUGIN_ROOT}/inbox/` for all remaining files (markdown, txt, html, and any converted `.md` files from the sub-step above). Exclude subdirectories (`processed/`, `rejected/`, `reports/`).
2. Read each file using the Read tool.
3. For each item, produce a structured summary:
   - **Source**: Author/publication/URL if identifiable
   - **Date**: Publication date if identifiable, otherwise "unknown"
   - **Key claims**: Bulleted list of factual assertions
   - **Actionable insights**: Specific recommendations that could improve existing skills

If the inbox is empty (no files and no converted files), inform the user and stop.

---

## Phase 2: Evaluate

<HARD-GATE>
DO NOT proceed to Phase 3 until every inbox item is classified. Be skeptical — missing an update is better than polluting skills with mediocre content.
</HARD-GATE>

Read the detailed evaluation criteria from `${CLAUDE_PLUGIN_ROOT}/skills/ingest-insights/references/evaluation-criteria.md`.

Rate each item on three axes (1-5 scale):
- **Authority**: Credible expert source vs. rehashed generic advice
- **Signal**: Specific actionable insight vs. vague platitudes
- **Currency**: Current best practice vs. outdated information

Classify each item:

| Classification | Criteria | Action |
|---|---|---|
| **EXPERT** | High authority + high signal (both ≥ 4) | Proceeds to Phase 3 automatically |
| **USEFUL** | Moderate quality (any axis 2-3) | Flag for user review via AskUserQuestion before proceeding |
| **NOISE** | Low quality, generic, or outdated (any axis ≤ 1, or all axes ≤ 2) | Move to `inbox/rejected/` with one-line reason prepended to filename |

Present the classification table to the user. For USEFUL items, use AskUserQuestion to get approval/rejection for each.

---

## Phase 3: Analyze

<HARD-GATE>
DO NOT proceed to Phase 4 until the full existing knowledge base is read and understood.
</HARD-GATE>

Read the existing plugin knowledge base:
1. All `SKILL.md` files: `${CLAUDE_PLUGIN_ROOT}/skills/*/SKILL.md`
2. All reference files: `${CLAUDE_PLUGIN_ROOT}/skills/*/references/*.md`
3. Shared references: `${CLAUDE_PLUGIN_ROOT}/references/*.md`
4. Plugin-level docs: `${CLAUDE_PLUGIN_ROOT}/CLAUDE.md` (if exists)

Build a mental map of what the plugin currently knows, including specific claims, statistics, weightings, and recommendations.

---

## Phase 4: Diff

<HARD-GATE>
DO NOT proceed to Phase 5 until every approved insight is categorized against existing knowledge.
</HARD-GATE>

Compare each approved insight from Phase 2 against the knowledge base from Phase 3. Categorize each insight:

| Category | Definition | Required Detail |
|---|---|---|
| **NEW** | Not present anywhere in existing knowledge | Which skill/file it belongs in |
| **UPDATE** | Supersedes or improves existing content | Cite exact file + line number |
| **CONFLICT** | Contradicts existing content | Flag both old and new claims |
| **IRRELEVANT** | Does not apply to any existing skill | Explain why |

---

## Phase 5: Recommend

<HARD-GATE>
DO NOT present recommendations without saving the sync report first.
</HARD-GATE>

Read the report format from `${CLAUDE_PLUGIN_ROOT}/skills/ingest-insights/references/report-format.md`.

For each NEW and UPDATE insight:
1. Draft the exact edit: file path, current text (if UPDATE), proposed replacement text
2. Assign priority: **critical** (outdated/wrong info in skills), **high** (meaningful improvement), **low** (nice to have)
3. Group edits by priority

Save the full report to `${CLAUDE_PLUGIN_ROOT}/inbox/reports/sync-YYYY-MM-DD.md`.

Present a summary to the user:
- Count of items by classification (EXPERT/USEFUL/NOISE)
- Count of insights by category (NEW/UPDATE/CONFLICT/IRRELEVANT)
- Count of edits by priority (critical/high/low)
- Report file path

**STOP HERE in dry-run mode.** Inform the user: "Report saved. Say 'apply', 'implement', or 'go' to execute the recommended edits."

---

## Phase 6: Apply (User-Approved Only)

Only execute this phase when the user explicitly says "apply", "implement", "go", or similar.

1. Execute each approved edit using Edit tool (prefer Edit over Write for existing files)
2. For each processed inbox item (including `.md` conversion files created by markitdown), move to `inbox/processed/` with timestamp prefix: `YYYY-MM-DD-original-filename.ext`
3. Generate a changelog entry and present it to the user

---

## Red Flags

| Thought | Reality |
|---|---|
| "This article looks credible, I'll skip evaluation" | Every item gets rated on all three axes. No exceptions. |
| "I'll just update the skills directly" | Dry-run first. Always. Phases 1-5 before any edits. |
| "This is mostly good, I'll classify as EXPERT" | If any axis is below 4, it's USEFUL at best. Be skeptical. |
| "I know what the skills say, I'll skip Phase 3" | Read every file. Memory is unreliable. Verify against actual content. |
| "I'll summarize the changes in the terminal" | Save the sync report to a file. Terminal summaries are ephemeral. |
| "The user said 'go' once, so I can keep applying" | Each batch needs fresh approval. Don't carry forward blanket approval. |

---

## Tools to Use

- **Read** — Read inbox files, existing SKILL.md files, and reference documents
- **Glob** — Discover inbox files and existing skill/reference files
- **Grep** — Search existing knowledge base for specific claims or statistics
- **Write** — Create sync reports, create new reference files
- **Edit** — Apply approved edits to existing files (preferred over Write for modifications)
- **Bash** — Create directories, move files to processed/rejected, run markitdown conversion and install commands
- **AskUserQuestion** — Get user decisions on USEFUL-classified items, markitdown installation prompt, and apply approval
