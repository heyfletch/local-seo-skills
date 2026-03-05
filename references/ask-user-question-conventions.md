# AskUserQuestion Conventions

Shared rules for all skills that use AskUserQuestion to collect text input from users.

---

## Rule 1: Known values are selectable options

If a value is already known (from client profile, prior discovery, or previous input), show it as a regular selectable option.

## Rule 2: Freeform input uses descriptive "Other" labels

The freeform text option must:
- Be labeled descriptively: "Enter a different URL", "Enter a different business name", "Type a custom path", etc.
- Be the **"Other" option** in the AskUserQuestion call — this is the only option type that triggers a text input box in Claude Code's UI
- Never be labeled "I'll type it", "I'll provide a URL", or just "Other"

## Rule 3: First-time collection with no known value = open text

When collecting a value for the first time with no known/discovered value to offer, ask as an open text question with no options. Example: "What's the website URL for [business name]?"

## Rule 4: Multi-choice questions are fine as-is

Questions with predefined choices (audit scope, budget ranges, yes/no) don't need freeform input. These are unaffected by these conventions.

---

## Examples

### Text input WITH a known value

```
AskUserQuestion:
"What is the website URL?"
- rollinsdogtraining.com                  <-- regular option (from profile)
- "Enter a different URL" (Other)         <-- freeform, triggers text box
```

### Text input with NO known value (first time)

```
AskUserQuestion:
"What's the website URL for Rollins Dog Training?"
- Open text input (user types the URL)
```

### Anti-patterns (never do these)

- "I'll provide a URL" as a selectable option (selecting it does nothing useful)
- "I'll type it" as a selectable option (same problem — no text box appears)
- "Other" as the label for freeform input (unclear what it does)
- Guessing a domain via WebSearch and presenting it as the only option
