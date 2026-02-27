# Markitdown Binary Conversion — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add automatic binary file conversion (PDF, DOCX, PPTX, XLSX) to the ingest-insights skill using markitdown, with Read tool fallback.

**Architecture:** A pre-scan sub-step is added at the top of Phase 1 in `SKILL.md`. It detects binary files, checks/installs markitdown, converts to markdown, and moves originals to processed. The rest of Phase 1 then reads the converted `.md` files normally.

**Tech Stack:** markitdown (pip package), Bash, Edit tool

---

### Task 1: Replace Phase 1 section with binary conversion sub-step

**Files:**
- Modify: `skills/ingest-insights/SKILL.md:40-54`

**Step 1: Edit Phase 1 section**

Use the Edit tool on `skills/ingest-insights/SKILL.md`.

**old_string:**
```
## Phase 1: Ingest

<HARD-GATE>
DO NOT proceed to Phase 2 until all inbox items are read and summarized.
</HARD-GATE>

1. Scan `${CLAUDE_PLUGIN_ROOT}/inbox/` for files (markdown, txt, pdf, html, and any other readable format). Exclude subdirectories (`processed/`, `rejected/`, `reports/`).
2. Read each file using the Read tool (use `pages` parameter for PDFs).
3. For each item, produce a structured summary:
   - **Source**: Author/publication/URL if identifiable
   - **Date**: Publication date if identifiable, otherwise "unknown"
   - **Key claims**: Bulleted list of factual assertions
   - **Actionable insights**: Specific recommendations that could improve existing skills

If the inbox is empty, inform the user and stop.
```

**new_string:**
```
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
     - Move the original binary to `inbox/processed/YYYY-MM-DD-<original-filename>`.
   - **If not installed** → check if pip is available:
     - Run `which pip3 || which pip` via Bash.
     - **If no pip** → skip markitdown, use Read tool fallback (see below).
     - **If pip available** → ask the user via AskUserQuestion: "markitdown is not installed but can be added with pip. Install it? (This enables better conversion of DOCX, PPTX, XLSX, and PDF files to markdown.)"
       - **User says yes** → run `pip install markitdown` via Bash. If it fails, retry once. If the retry also fails, fall back to Read tool.
       - **User says no** → fall back to Read tool.
3. **Read tool fallback**: When markitdown is unavailable, attempt to read binary files directly with the Read tool (use `pages` parameter for PDFs). If Read fails for a file (e.g., DOCX/PPTX/XLSX that Claude cannot parse), log a warning to the user and skip that file. No `.md` conversion file is created in fallback mode — the binary is treated as a normal inbox item.

### Read and Summarize

1. Scan `${CLAUDE_PLUGIN_ROOT}/inbox/` for all remaining files (markdown, txt, html, and any converted `.md` files from the sub-step above). Exclude subdirectories (`processed/`, `rejected/`, `reports/`).
2. Read each file using the Read tool.
3. For each item, produce a structured summary:
   - **Source**: Author/publication/URL if identifiable
   - **Date**: Publication date if identifiable, otherwise "unknown"
   - **Key claims**: Bulleted list of factual assertions
   - **Actionable insights**: Specific recommendations that could improve existing skills

If the inbox is empty (no files and no converted files), inform the user and stop.
```

**Step 2: Verify the edit**

Read `skills/ingest-insights/SKILL.md` and confirm:
- Phase 1 now has two sub-sections: "Binary File Conversion" and "Read and Summarize"
- The HARD-GATE is preserved at the top
- The markitdown check/install/fallback flow matches the design doc
- The original "Read each file" step no longer mentions PDFs (handled by conversion sub-step)

**Step 3: Commit**

```bash
git add skills/ingest-insights/SKILL.md
git commit -m "Add markitdown binary conversion sub-step to ingest-insights Phase 1"
```

---

### Task 2: Verify full skill file reads coherently

**Files:**
- Read: `skills/ingest-insights/SKILL.md` (full file)

**Step 1: Read the complete file**

Read the entire `skills/ingest-insights/SKILL.md` end-to-end.

**Step 2: Check for coherence issues**

Verify:
- Phase 1 flows naturally from binary conversion → read and summarize
- Phase 6 (Apply) still correctly moves processed inbox items to `processed/` — this includes the `.md` conversion files created by markitdown
- The "Tools to Use" section at the bottom still covers all tools needed (Read, Glob, Bash, AskUserQuestion are all already listed)
- No duplicate or contradictory instructions exist

**Step 3: Fix any issues found**

If any wording is inconsistent or unclear, make targeted edits. If everything reads well, move on.
