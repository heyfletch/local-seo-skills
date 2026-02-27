# Sync Report Format

## File Location

Save reports to: `${CLAUDE_PLUGIN_ROOT}/inbox/reports/sync-YYYY-MM-DD.md`

If multiple reports are generated on the same day, append a counter: `sync-YYYY-MM-DD-2.md`

## Report Structure

```markdown
# Knowledge Sync Report — YYYY-MM-DD

## Summary

- **Items processed**: N
- **EXPERT**: N (auto-approved)
- **USEFUL**: N (M approved, K rejected by user)
- **NOISE**: N (rejected)
- **Edits proposed**: N (critical: X, high: Y, low: Z)

## Inbox Items Evaluated

### [Item 1: filename.md]
- **Source**: Author/publication
- **Date**: YYYY-MM-DD or "unknown"
- **Classification**: EXPERT | USEFUL | NOISE
- **Authority**: N/5 — [brief justification]
- **Signal**: N/5 — [brief justification]
- **Currency**: N/5 — [brief justification]
- **Key insights**: [bulleted list]

### [Item 2: filename.md]
...

## Proposed Edits

### Critical Priority

Outdated or incorrect information that should be corrected.

#### Edit 1: [brief description]
- **File**: `skills/[skill-name]/SKILL.md` (line NN)
- **Category**: UPDATE
- **Source item**: [inbox filename]
- **Current text**:
  ```
  [exact current text from the file]
  ```
- **Proposed replacement**:
  ```
  [exact proposed text]
  ```
- **Rationale**: [why this edit is critical]

### High Priority

Meaningful improvements to existing content.

#### Edit N: [brief description]
...

### Low Priority

Nice-to-have additions or minor improvements.

#### Edit N: [brief description]
...

## New Content Proposals

For NEW insights that don't update existing text but should be added:

### Proposal 1: [brief description]
- **Target file**: `skills/[skill-name]/references/[file].md`
- **Section**: [where to add within the file]
- **Source item**: [inbox filename]
- **Proposed content**:
  ```
  [exact text to add]
  ```
- **Rationale**: [why this belongs here]

## Conflicts Flagged

Items that contradict existing knowledge (require user resolution):

### Conflict 1: [brief description]
- **Existing claim** (`skills/[skill]/SKILL.md`, line NN):
  > [quoted existing text]
- **New claim** (from [inbox filename]):
  > [quoted new text]
- **Assessment**: [which appears more credible and why]

## Irrelevant Items

Items that don't apply to any existing skill:

- **[filename]**: [one-line explanation of why it's irrelevant]

## Items Moved

### To `inbox/processed/`
- `YYYY-MM-DD-filename.ext` (was: `filename.ext`)

### To `inbox/rejected/`
- `REJECTED-[reason]-filename.ext` (was: `filename.ext`)
```

## Priority Definitions

| Priority | Criteria | Examples |
|---|---|---|
| **Critical** | Existing skill contains outdated or incorrect information that could produce wrong output | Ranking weight percentages changed, deprecated Google feature still referenced, wrong schema format |
| **High** | Meaningful improvement to existing skill quality or coverage | New ranking factor to incorporate, improved workflow step, better scoring criteria |
| **Low** | Nice-to-have addition that doesn't affect correctness | Additional trigger phrases, supplementary examples, minor wording improvements |

## Edit Format Rules

- Always include the exact file path relative to plugin root
- Always include the line number for UPDATE edits
- Always include both current and proposed text verbatim (copy-pasteable)
- Always cite the source inbox item
- Always include a one-line rationale
- Group edits by priority, then by target file within each priority group

## Changelog Entry Format

After Phase 6 (Apply), generate a changelog entry:

```markdown
## [YYYY-MM-DD] Knowledge Sync

### Sources Processed
- [filename1.md] — [one-line summary]
- [filename2.md] — [one-line summary]

### Changes Applied
- **[skill-name]**: [brief description of change] (critical|high|low)
- **[skill-name]/references/[file]**: [brief description] (critical|high|low)

### Items Rejected
- [filename] — [reason]
```
