# Evaluation Criteria for Inbox Items

## Three-Axis Rating System

Rate each inbox item on a 1-5 scale for each axis.

### Authority (1-5)

How credible is the source?

| Score | Meaning | Examples |
|---|---|---|
| 5 | Primary research or official source | Google documentation, peer-reviewed study, official API changelog |
| 4 | Recognized industry expert with track record | Named SEO practitioner with published case studies, conference speaker with data |
| 3 | Reputable publication, but secondhand | Search Engine Journal article citing expert data, industry survey summary |
| 2 | Generic content marketing | "Top 10 SEO tips" listicle, agency blog without original data |
| 1 | Unknown source, no credentials, AI-generated filler | Anonymous blog post, content mill output, rehashed common knowledge |

### Signal (1-5)

How specific and actionable is the information?

| Score | Meaning | Examples |
|---|---|---|
| 5 | Specific, data-backed, immediately actionable | "GBP categories now support X; add Y to improve Z by N%" |
| 4 | Actionable with clear recommendation | "Title tags now render up to 270 chars; update title strategy" |
| 3 | Useful context but requires interpretation | "Google is placing more weight on behavioral signals" |
| 2 | Vague or general advice | "Make sure your NAP is consistent" |
| 1 | Platitude or common knowledge | "Content is king", "Focus on user experience" |

### Currency (1-5)

How current is this information?

| Score | Meaning | Examples |
|---|---|---|
| 5 | Published within last 3 months, addresses current algorithm | 2026 ranking factor study, recent Google update analysis |
| 4 | Published within last 6 months, still relevant | Late 2025 best practices that haven't changed |
| 3 | Published within last year, mostly still valid | 2025 guide with some outdated recommendations |
| 2 | 1-2 years old, partially outdated | 2024 guide — some techniques deprecated |
| 1 | Over 2 years old or references deprecated features | Pre-2024 content, references removed Google features |

## Classification Logic

```
IF authority >= 4 AND signal >= 4:
    → EXPERT (auto-approve for diff)

ELSE IF any_axis <= 1 OR all_axes <= 2:
    → NOISE (reject with reason)

ELSE:
    → USEFUL (flag for user review)
```

### Rejection Reasons (for NOISE items)

When moving items to `inbox/rejected/`, prepend a one-line reason to the filename:

Format: `REJECTED-[reason]-original-filename.ext`

Common reasons:
- `generic` — Rehashed common knowledge, no original insight
- `outdated` — References deprecated features or old data
- `unsourced` — Claims without data or attribution
- `off-topic` — Not relevant to local SEO skills
- `duplicate` — Information already present in existing skills

## Edge Cases

### When in Doubt → USEFUL

The threshold for EXPERT is intentionally high. If any uncertainty exists about quality, classify as USEFUL and surface to the user. False negatives (missing a good update) are recoverable; false positives (polluting skills with bad info) are not.

### Partial Quality

An item might have one excellent insight buried in otherwise mediocre content. In this case:
- Classify the item as USEFUL
- In the summary, highlight the specific valuable insight
- Let the user decide whether to extract just that insight

### Conflicting Sources

If two inbox items contradict each other:
- Classify both as USEFUL regardless of individual scores
- Flag the conflict explicitly in the evaluation summary
- Let the user resolve the conflict before proceeding to diff

### Data vs. Opinion

Prioritize data-backed claims over opinion:
- "Rankings dropped 15% after removing service area pages" (data) → higher signal
- "I think service area pages are important" (opinion) → lower signal
- Both can be EXPERT-level if authority is high, but data always scores higher on signal
