# Design: Binary File Conversion via markitdown in Ingest-Insights

**Date**: 2026-02-27
**Status**: Approved
**Scope**: `skills/ingest-insights/SKILL.md` — Phase 1 enhancement

---

## Problem

The ingest-insights skill currently lists "pdf, html, and any other readable format" as supported inbox file types, but binary formats like DOCX, PPTX, and XLSX require pre-conversion. Previously, DOCX files were manually converted to `.docx.md` before ingestion. This design automates that conversion using markitdown.

## Decision Summary

- **Approach**: Pre-scan sub-step at the top of Phase 1 (embedded, not a separate phase)
- **Converter**: markitdown (pip package) with Claude Read tool as fallback
- **File flow**: Convert binary to .md in inbox root, move binary to processed/, Phase 1 reads .md normally
- **Install flow**: Check markitdown → check pip → prompt user → install with 1 retry → fallback to Read

## Detailed Design

### Binary Conversion Sub-step (top of Phase 1)

1. Glob for `*.pdf`, `*.docx`, `*.pptx`, `*.xlsx` in `inbox/` (case-insensitive)
2. If none found, skip to normal Phase 1
3. If found, check markitdown:
   - `which markitdown` → if installed, convert all binary files
   - If not installed → `which pip3 || which pip`
     - No pip → skip markitdown, use Read tool fallback
     - Pip available → AskUserQuestion: "markitdown is not installed. Install it?"
       - Yes → `pip install markitdown` (1 retry on failure)
         - Success → convert files
         - Failure → Read tool fallback
       - No → Read tool fallback

### Conversion Output

- markitdown: `markitdown <file>` outputs markdown to stdout → save as `<filename>.md` in inbox root
- Original binary: moved to `inbox/processed/YYYY-MM-DD-<filename>`
- After Phase 5/6: the .md file also moves to `inbox/processed/YYYY-MM-DD-<filename>.md`

### Read Tool Fallback

- Attempt `Read` on binary file directly (Claude reads PDFs natively via `pages` parameter)
- DOCX/PPTX/XLSX: attempt Read, skip with warning if it fails
- No .md file created — file moves to processed/rejected based on evaluation like any other item

### File Changes

Single file: `skills/ingest-insights/SKILL.md`
- Add binary conversion sub-step at top of Phase 1 section
- Update file format list to explicitly mention binary formats and the conversion flow
- No new reference files needed
