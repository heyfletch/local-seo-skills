# Report Generation Guide

Standard report output instructions for all local-seo analysis skills.

## Default Output: HTML Report

ALWAYS generate an HTML report by default. Do NOT ask the user which format they want — HTML is the default.

### How to Generate

1. Read the HTML template at `${CLAUDE_PLUGIN_ROOT}/references/html-report-template.html`
2. For plan/roadmap output, use `${CLAUDE_PLUGIN_ROOT}/references/html-plan-template.html` instead
3. For content calendar output, use `${CLAUDE_PLUGIN_ROOT}/references/html-calendar-template.html` instead
4. Replace all `{{PLACEHOLDER}}` values with real data
5. Add, remove, or modify sections as needed for the report type
6. Save to `~/Desktop/YYYY-MM-DD-[type]-[business-slug].html`
7. Run `open ~/Desktop/[filename].html` via Bash to auto-open in browser

### Terminal Output

After generating the HTML report, print to terminal ONLY:
- Brief summary (3-5 bullet points of key findings/recommendations)
- File path where the report was saved
- Do NOT dump the full report content into the terminal

### Alternative Formats

- **PDF:** Tell the user to click the "Save as PDF" button in the HTML report (Cmd+P). Optionally convert via `wkhtmltopdf ~/Desktop/[file].html ~/Desktop/[file].pdf` if available.
- **Markdown:** Only generate if the user explicitly requests markdown output. Save to `~/Desktop/YYYY-MM-DD-[type]-[business-slug].md`.

### File Naming Convention

```
~/Desktop/YYYY-MM-DD-[type]-[business-slug].html
```

Types: `audit`, `plan`, `content-calendar`, `gbp-calendar`, `service-[slug]`, `area-[slug]`, `schema-[slug]`, `review-strategy`
