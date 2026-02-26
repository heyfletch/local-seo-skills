# Keyword Research Guide

## Keyword Categories

### A. Service Keywords (Commercial Intent) — Target: Service Pages
- Primary: [service type] — e.g., "eye exam", "pediatric dentist"
- Modifiers: "best", "affordable", "emergency", "certified", "top"
- Combined: [modifier] + [service] — e.g., "best pediatric dentist"

### B. Location Keywords (Local Intent) — Target: Service Area Pages
- Primary: [service] + [city] — e.g., "eye doctor Bethesda"
- Neighborhood: [service] + [neighborhood] — e.g., "dentist near Chevy Chase"
- Do NOT optimize explicitly for "near me" — this is implicit in mobile search

### C. Long-tail Keywords (Informational) — Target: Blog/FAQ
- Question-based: "how often should I get an eye exam"
- Problem-solving: "signs you need new glasses"
- Comparison: "glasses vs contacts for kids"

### D. Zero Search Volume Keywords — Target: Blog/FAQ
- Very specific, long-tail queries from GSC
- Often show 0 volume but indicate real search behavior
- High conversion potential due to specificity

### E. AI/LLM Sub-Query Keywords — Target: Service Pages & Blog

When someone prompts an AI ("recommend 5 dentists in Denver that accept Delta Dental"), the LLM breaks this into 8+ background sub-queries. Understanding these sub-queries reveals keywords traditional tools miss.

**How to discover LLM sub-queries:**
- Chrome DevTools: Network tab → search "search_model_queries" (for ChatGPT)
- Gemini Grounding API: returns the searches Gemini will perform
- queryfanout.com: free tool that automates the process
- Run your target keywords through ChatGPT with different customer personas and note what attributes it searches for

These sub-queries often focus on specific business attributes (insurance, certifications, specializations) rather than generic "[service] [city]" patterns.

## AI/RAG Keyword Research Workflow

A more systematic approach to AI keyword research:
1. Start with your traditional keyword list
2. Create 3-5 customer personas (demographics, preferences, constraints)
3. Prompt LLMs: "If I was [persona] trying to find [keyword], what might I ask?" — generates 4-5 conversational prompt variations per keyword
4. Feed those prompts into AlsoAsked to map where conversations go next
5. Use grounding prediction tools to filter for queries that actually trigger web search (grounding threshold ~0.6)
6. For grounded queries, discover the actual background searches (Chrome DevTools or Gemini API)
7. Optimize service pages and content for those background search terms

This workflow identifies keywords traditional tools miss — the conversational, attribute-rich queries people actually ask AI assistants.

## Keyword Metrics to Document

For each keyword:
- Search Volume (monthly)
- Keyword Difficulty (0-100)
- Current Ranking (if any)
- Search Intent (informational / commercial / transactional / local)
- Traffic Tier: High (>1000) / Medium (250-1000) / Low (<250)
- Priority Score (1-10 based on volume + difficulty + intent + relevance)

## Keyword Golden Ratio (KGR) for Quick Wins

**Formula:** (Allintitle results) ÷ (Monthly search volume) where volume < 250

- **KGR < 0.25** — Excellent, should rank quickly
- **KGR 0.25-1.0** — Good opportunity
- **KGR > 1.0** — More competitive

Flag all KGR < 0.25 keywords as quick-win content targets.

## ICE Scoring for Content Prioritization

When deciding which keywords/pages to tackle first, consider the ICE framework:
- **Impact (40% weight):** Estimated traffic × revenue potential. Traffic without revenue is vanity.
- **Confidence (30%):** Can you realistically rank within 6 months given your DA and competition? If top 10 is all DR 90+ sites, confidence is low.
- **Effort-inverted (30%):** Design needs, dev dependencies, research depth, approval processes. Score 1-10, invert (low effort = higher score).

This often reveals uncomfortable truths: a viral content idea might score low on business impact, while an unglamorous comparison page scores highest.
