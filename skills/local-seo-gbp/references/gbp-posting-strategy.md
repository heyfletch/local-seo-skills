# GBP Posting Strategy

## Post Types & Mix

- **Updates** (40%) — Educational tips, insights, announcements
- **Offers** (30%) — Promotions, specials, seasonal deals
- **Events** (20%) — Workshops, webinars, community events
- **Products** (10%) — Product/package highlights (if applicable)

## Posting Schedule

- **Frequency:** 2-3 posts per week minimum
- **Best days:** Tuesday-Thursday (higher engagement)
- **Best times:** 9am-12pm in the business's local timezone (confirm timezone with client; default to ET if unknown)
- **Max length:** 1,500 chars (300-500 chars ideal for engagement)

## Batch Planning Workflow

Instead of deciding what to post each week (which causes decision fatigue and inconsistency), plan the entire month in one sitting:

1. **Set a primary monthly goal** (e.g., "Increase inbound calls by showcasing seasonal services")
2. **Define a primary offer/focus** for the month
3. **Assign weekly themes:**
   - Week 1: Seasonal/educational awareness
   - Week 2: Service highlight
   - Week 3: Social proof (testimonials, project photos)
   - Week 4: Offers and conversion push
4. **Batch-write all 4+ posts** in one session
5. **Review together, then schedule** all at once

For agencies managing multiple clients: batch by client in dedicated sessions. First few times may take 2 hours per location, but gets faster with practice. Can batch 2-3+ months ahead.

## Post Template

```
[Engaging opening line or question — hook the reader]

[2-3 sentences of VALUE — tip, insight, or useful information]

[Call-to-action — specific next step]

[Link to relevant website page]

[High-quality image — required for engagement]
```

## Sample Post Calendar (1 Month)

Generate 12-16 posts per month using this mix:

**Week 1:**
- Mon: Educational tip related to core service
- Wed: Seasonal offer or promotion
- Fri: Behind-the-scenes team photo/video

**Week 2:**
- Tue: FAQ answer (mirrors a common search query)
- Thu: Customer success story (anonymized if needed)

**Week 3:**
- Mon: Service spotlight (highlight a specific offering)
- Wed: Local community involvement or event
- Fri: Industry news or insight

**Week 4:**
- Tue: Before/after or case study
- Thu: Special offer with urgency
- Sat: Team or culture highlight

## Post Content Generation Prompt

```
Create [X] Google Business Profile posts for [Business Name], a [business type] in [city].

Post mix: 2 educational, 2 promotional, 1 engagement
Current month: [month] — incorporate seasonal relevance
Target services to highlight: [list]

For each post include:
- Type: Update / Offer / Event
- Content: 300-500 characters, value-driven, keyword-aware
- CTA: Specific action (Call Now, Learn More, Book Now)
- CTA URL: [relevant page]
- Image suggestion
- Best publish time
```

## Q&A Strategy

### Seed Questions (Create 5-10)

Ask and answer the questions potential customers would ask:

```
☐ "What does [service] cost?"
☐ "How long does [service] take?"
☐ "Do you serve [city/area]?"
☐ "What insurance do you accept?" (if applicable)
☐ "Do you offer free consultations?"
☐ "Are you licensed/certified?"
☐ "What are your hours?"
☐ "Do you offer [specific service variant]?"
☐ [2-3 industry-specific questions]
```

### Q&A Best Practices

- Answer your own questions thoroughly (include keywords naturally)
- Monitor daily for new questions from public
- Respond to all questions within 24 hours
- Upvote helpful questions
- Use answers to highlight differentiators
- Link to relevant website pages in answers when appropriate

## Automation Opportunities (n8n)

### Review Monitoring Workflow
- Schedule: Check every 4 hours
- New negative review → immediate Slack alert
- New positive review → draft response via Claude API
- Daily summary notification

### GBP Post Scheduler
- Pull scheduled posts from database/spreadsheet
- Auto-publish via GBP API
- Track post engagement metrics
- Error handling with retry logic

### Q&A Monitoring
- Daily check for new unanswered questions
- Generate draft answers via Claude API
- Queue for human review before posting
