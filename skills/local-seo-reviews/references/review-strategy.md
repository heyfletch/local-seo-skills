# Review Strategy

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

- **Never** offer incentives for reviews (violates Google policies → suspension risk)
- **Never** ask only happy customers (selective solicitation)
- **Never** write fake reviews or have employees/family review
- **Never** buy reviews from services
- **Never** post multiple reviews at the same time (looks suspicious)
- **Never** gate reviews (send happy customers to Google, unhappy ones to a private form) — Google explicitly prohibits this
- **Never** copy/paste the same response template for every review

## Review Content for AI Visibility (2026)

LLMs crawl your website's testimonial page. To maximize AI citation:

1. Display reviews on your website (not just on Google)
2. Include reviewer name and location
3. Organize reviews by service type
4. Include specific service mentions in displayed reviews
5. Mark up with Review schema (see local-seo-schema skill)
6. Keep testimonial page updated regularly

## Testimonials Page Title Optimization (QUICK WIN)

Most businesses title their testimonials page "Testimonials" — a massive missed opportunity. Changing the title tag to **"[Brand Name] Reviews"** can take the #1 position for "[brand] reviews" searches, displacing Yelp, Reddit, and other third-party sites.

**Implementation:**
- Title tag: `[Brand Name] Reviews — What Our [Clients/Patients/Customers] Say`
- H1: `[Brand Name] Reviews`
- URL: `/reviews` (not `/testimonials`)
- Include actual review content with names, locations, dates
- Link to Google review profile for fresh reviews
- This controls your brand's review narrative in both Google and AI search

**Why it matters:** Reddit threads for "[brand] reviews" now frequently appear in Google results and tend to be negative. Your optimized reviews page can outrank these.

## Reputation Defense: Reddit AMA Strategy

For businesses with some existing recognition, a Reddit AMA (Ask Me Anything) creates a high-engagement thread that ranks for brand + review queries.

**When to use:** Best for established businesses, agency owners, or professionals building a personal brand. NOT suitable for brand new businesses with no recognition.

**How:**
1. Find a relevant subreddit (r/[your city], r/[your industry], niche subreddits)
2. Post an AMA: "I'm a [role] in [city] who specializes in [service] — AMA"
3. Answer questions thoroughly and honestly
4. High engagement makes the thread sticky and hard to displace
5. Can outrank negative Reddit threads in search results

**Rules:**
- Be genuine — Reddit users detect and punish marketing attempts
- Do NOT create fake accounts or astroturf
- Do NOT coordinate upvotes
- Provide real value in answers, not sales pitches
