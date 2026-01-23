---
description: Conduct comprehensive research using Claude-first methodology
---

Conduct comprehensive research on the topic using **Claude-First** methodology.

## Step 1: Classify the Query

| Question | Answer → Action |
|----------|-----------------|
| Is this static/historical knowledge? | Yes → Claude only, skip tools |
| Does this need current info (<6 months)? | Yes → Use Perplexity or WebSearch |
| What are the stakes? | Low → minimal verification / High → multi-source |

## Step 2: Follow the 4-Stage Pipeline

### Stage 0: Claude Baseline
Synthesize what Claude knows. Identify what needs external verification.

### Stage 1: Discovery
- **Current events:** Use Perplexity for AI-synthesized overview with citations
- **Find sources:** WebSearch to discover URLs and authoritative sources
- **Goal:** 3-5 high-quality sources to investigate

### Stage 2: Extraction
Extract content from key sources:
- Simple HTML → WebFetch
- WebFetch fails → Crawl4AI md (f=fit)
- JS-heavy sites → Crawl4AI execute_js

Only extract sources that add NEW information beyond Claude's baseline.

### Stage 3: Synthesis
Integrate findings:
- What did Claude know vs. what's new?
- Where do sources agree/disagree?
- Assign confidence: High / Medium / Low

## Deliverable Format

### Executive Summary
- Key findings (3-5 bullets)
- Overall confidence level
- Critical insights or caveats

### Findings

#### [Topic 1]
**Claude baseline:** [What Claude knew]
**External findings:** [What sources added/confirmed]
**Conclusion:** [Synthesized finding]
**Confidence:** High / Medium / Low

### Sources
1. [Title] - [URL] - Tier 1/2/3

---

## Tool Quick Reference

| Tool | When |
|------|------|
| Claude | Static knowledge, explanations |
| WebSearch | Find URLs, verify recency |
| Perplexity | Current events, AI-synthesized answers |
| WebFetch | Simple HTML pages |
| Crawl4AI md | Better extraction, WebFetch fallback |
| Crawl4AI execute_js | JS-rendered sites |

## Source Tiers

- **Tier 1 (High):** Peer-reviewed, official docs, government, SEC filings
- **Tier 2 (Medium):** Reputable news, industry reports, experts
- **Tier 3 (Low):** Blogs, forums, social media (corroborate these)
