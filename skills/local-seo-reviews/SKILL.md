---
name: local-seo-reviews
description: Review strategy, generation system, response templates, and monitoring for local businesses. Use when the user wants to get more reviews, respond to reviews, create a review generation system, handle negative reviews, improve review ratings, set up review monitoring, or discuss review strategy. Also triggers for "how to get more Google reviews", "respond to this review", "review request template", "negative review", "review management", or "reputation management".
---

# Local SEO Reviews Skill

Reviews account for 20% of local pack ranking and 16% of AI search visibility. In 2026, review RECENCY matters more than total volume. This skill covers generation, response, and monitoring.

## Review Health Benchmarks

| Metric | Poor | OK | Good | Excellent |
|---|---|---|---|---|
| Total reviews | <15 | 15-30 | 31-75 | 75+ |
| Average rating | <4.0 | 4.0-4.4 | 4.5-4.8 | 4.9-5.0 |
| Monthly velocity | 0 | 1-2 | 3-5 | 5+ |
| Response rate | <25% | 25-75% | 75-95% | 95-100% |
| Response time | >1 week | 3-7 days | 1-2 days | <24 hours |

## Review Generation System

### Goal: 2-5 new reviews per month (consistent, not in bursts)

### Timing
- **Service businesses:** Ask immediately after successful service completion
- **Follow-up:** Send request 24-48 hours later via email/SMS
- **NEVER ask:** During a sales pitch or before service is complete

### Methods by Conversion Rate

1. **In-Person Ask (~30% conversion)**
   - "Would you mind leaving us a review? It really helps other [clients/patients/customers] find us."
   - Hand them a card with QR code linking to Google review page
   - Show them on their phone if they're willing

2. **Text/SMS (~15-20% conversion)**
   - Send within 48 hours of service
   - Short, personal, with direct review link
   - Higher response than email

3. **Email (~5-10% conversion)**
   - Send 24-48 hours after service
   - Personalize with name and service details
   - Single clear CTA button

4. **Physical Materials (~10-15% conversion)**
   - Leave-behind card with QR code
   - Signage in waiting/reception area
   - Checkout counter tent card

5. **Email Signature (~1-2% conversion)**
   - Passive but compounds over time
   - "See what our clients say → [link]"

### Review Request Templates

**Text/SMS:**
```
Hi [Name]! Thanks for choosing [Company] for [service]. We'd love to hear about your experience — would you mind leaving a quick Google review?

[Direct Google review link]

It takes just a minute and helps us tremendously. Thank you!

- [Your Name]
```

**Email:**
```
Subject: How was your [service] experience?

Hi [Name],

Thanks for trusting us with [service] on [day]. We hope everything exceeded expectations!

If you have a moment, we'd greatly appreciate a quick Google review. It helps other [clients/patients] find us and supports our small business.

[CTA Button: Leave a Review]

Takes less than 2 minutes:
1. Click the button above
2. Select your star rating
3. Share a few words about your experience

Thank you for your support!

[Your Name]
[Company]

P.S. If anything wasn't perfect, please reply directly — we want to make it right.
```

## Review Response Templates

### Respond to ALL reviews within 24-48 hours.

**5-Star Review:**
```
Thank you so much, [Name]! We loved [working with you on / helping you with] [specific detail from review]. [Personal touch related to their experience].

We appreciate you taking the time to share!

- [Your Name], [Company]
```

**4-Star Review:**
```
Thanks for the kind review, [Name]! We're glad [specific positive from review]. [If they mentioned an area for improvement: "We appreciate the feedback on [topic] and are working on that."]

Thank you for your trust!

- [Your Name], [Company]
```

**3-Star Neutral Review:**
```
[Name], thank you for your honest feedback. [Acknowledge the specific concern]. We take this seriously and would love to discuss further.

Would you mind reaching out at [phone/email]? I'd like to understand how we can improve.

- [Your Name], [Company]
```

**1-2 Star Negative Review:**
```
[Name], I'm sorry your experience didn't meet expectations. [Brief acknowledgment of the specific issue — don't be defensive].

I'd like to make this right. Please contact me directly at [phone] or [email] so we can resolve this.

- [Your Name], [Title], [Company]
```

### Response Rules

**DO:**
- Use reviewer's name
- Reference specific details from their review (proves you read it)
- Keep responses genuine and human (not corporate-speak)
- Take negative conversations offline (phone/email)
- Respond to positive reviews too (engagement signal)

**DON'T:**
- Be defensive about negative reviews
- Offer compensation publicly (take offline)
- Use the same template response for every review
- Over-apologize to the point of seeming insincere
- Ignore negative reviews (worst option)
- Argue with reviewers publicly

## Review Monitoring System

### Manual Process
- Check Google Business Profile daily for new reviews
- Check Yelp, Facebook, industry sites weekly
- Log all reviews in a tracking spreadsheet

### Automated (n8n Workflow)
```
Schedule: Every 4 hours
1. Fetch reviews via GBP API
2. Compare to stored reviews in database
3. If new review detected:
   - Negative (1-3 stars) → Immediate Slack/email alert to owner
   - Positive (4-5 stars) → Queue response draft via Claude API
4. Store in database with metadata
5. Daily summary: new reviews count, pending responses, avg rating
6. Weekly report: velocity trend, rating trend, response rate
```

## Platform Priority

| Platform | Priority | Why |
|---|---|---|
| Google Business Profile | #1 | 32% of local pack weight, most visible |
| Yelp | #2 | ChatGPT/AI uses Yelp as data source |
| Facebook | #3 | Social proof + local community |
| BBB | #4 | AI search engines reference BBB ratings |
| Industry-specific (Healthgrades, Avvo, Zocdoc, etc.) | #5 | Industry authority signals |

## What NOT To Do

- ❌ **Never** offer incentives for reviews (violates Google policies → suspension risk)
- ❌ **Never** ask only happy customers (selective solicitation)
- ❌ **Never** write fake reviews or have employees/family review
- ❌ **Never** buy reviews from services
- ❌ **Never** post multiple reviews at the same time (looks suspicious)
- ❌ **Never** gate reviews (send happy customers to Google, unhappy ones to a private form) — Google explicitly prohibits this
- ❌ **Never** copy/paste the same response template for every review

## Review Content for AI Visibility ⚠️ 2026

LLMs crawl your website's testimonial page. To maximize AI citation:

1. Display reviews on your website (not just on Google)
2. Include reviewer name and location
3. Organize reviews by service type
4. Include specific service mentions in displayed reviews
5. Mark up with Review schema (see local-seo-schema skill)
6. Keep testimonial page updated regularly
