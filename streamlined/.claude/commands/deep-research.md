---
description: Conduct comprehensive research with evidence-based analysis
---

Conduct comprehensive research on the topic using the following protocol.

## Depth Control

Assess the query complexity and select appropriate depth:

| Depth | Use When | Stages | Tools |
|-------|----------|--------|-------|
| **Quick** | Simple factual questions, definitions | 1 only | Perplexity only |
| **Standard** | Most research requests | 1-3 | Perplexity + WebSearch + selective WebFetch |
| **Deep** | Complex topics, high-stakes decisions, comprehensive analysis | 1-4 | All tools including Firecrawl extraction |

Default to **Standard** unless the query clearly warrants Quick or Deep.

---

## Stage 1: Landscape Discovery [PARALLEL]

**Goal:** Understand the terrain, discover sources, identify key players

**Execute these searches in parallel:**

1. **Perplexity Overview:**
   - Use `mcp__perplexity` for AI-synthesized overview
   - Query: "[topic] overview current state key developments"

2. **WebSearch Discovery:**
   - Use `WebSearch` to find authoritative URLs
   - Query: "[topic] authoritative sources official"
   - Query: "[topic] recent news developments 2024 2025"

**Checkpoint after Stage 1:**
- [ ] Understand topic scope and key subtopics
- [ ] Identified 5-10 potentially authoritative sources
- [ ] Know what questions need deeper investigation
- [ ] Determined if Standard or Deep depth is needed

**If Quick depth:** Skip to Stage 4 synthesis with Perplexity results only.

---

## Stage 2: Deep Content Extraction [SELECTIVE]

**Goal:** Extract full content from high-value sources identified in Stage 1

**Tool Selection per Source:**

| Source Type | Tool | Notes |
|-------------|------|-------|
| Simple HTML pages | `WebFetch` | Free, fast, try first |
| Academic papers | `WebFetch` | Usually works well |
| News articles | `WebFetch` → `Firecrawl` | Fallback if paywall |
| JS-heavy sites | `Firecrawl scrape` | Use `waitFor` option |
| Data tables/specs | `Firecrawl extract` | Use JSON schema |
| Multiple pages same site | `Firecrawl crawl` | Limit to 5-10 pages |

**Cost Optimization Rules:**
1. Start with `WebFetch` (free) for each URL
2. Only escalate to Firecrawl if WebFetch fails or returns incomplete content
3. Skip extraction if Perplexity already provided adequate summary

**Execute extractions:**
- Process top 3-5 most authoritative sources from Stage 1
- For each source, use appropriate tool from table above
- Note extraction method in findings

**Checkpoint after Stage 2:**
- [ ] Extracted content from key authoritative sources
- [ ] Have primary source data (not just summaries)
- [ ] Identified any access limitations (paywalls, etc.)

---

## Stage 3: Verification [PARALLEL]

**Goal:** Cross-check claims, verify facts, identify contradictions

**Execute these verifications in parallel:**

1. **Perplexity Fact-Check:**
   - Query: "verify [specific claim from Stage 2]"
   - Query: "is it true that [key finding]"

2. **Alternative Perspective Search:**
   - WebSearch: "[topic] criticism concerns limitations"
   - WebSearch: "[topic] alternative viewpoints debate"

3. **Recency Verification:**
   - WebSearch: "[topic] latest news updates [current month year]"
   - Perplexity: "most recent developments [topic] [current year]"

**For High-Stakes Claims (Deep depth only):**
- Use `mcp__openrouter` cross-model validation if available
- Query same claim to multiple models, note consensus/disagreement

**Checkpoint after Stage 3:**
- [ ] Key claims verified across 2+ independent sources
- [ ] Contradictions identified and documented
- [ ] Recency of information confirmed
- [ ] Tool agreement assessed for confidence scoring

---

## Stage 4: Synthesis

**Goal:** Integrate findings into coherent analysis with proper confidence scoring

**Apply Source Tiering:**
- **Tier 1**: Peer-reviewed papers, official docs, government data, primary sources
- **Tier 2**: Reputable news, industry reports, expert analysis
- **Tier 3**: General web content, blogs, forums, unverified sources

**Calculate Confidence Scores:**

Base confidence from source quality:
- Multiple Tier 1 sources agree: High (90-100%)
- Mix of Tier 1-2 sources agree: Medium-High (70-89%)
- Tier 2-3 sources, some disagreement: Medium (50-69%)
- Single source or contradictions: Low (30-49%)

Apply tool agreement modifiers:
- Perplexity + Firecrawl extracted content agree: +15%
- Multiple WebSearch URLs corroborate: +10%
- OpenRouter cross-model consensus: +15%
- Tools return contradictory info: -20%
- Single tool, single source: -10%

---

## Deliverable Format

Provide a structured report:

### Executive Summary
- Key findings in 3-5 bullet points
- Overall confidence level with justification
- Critical insights or red flags

### Methodology
- Research depth applied (Quick/Standard/Deep)
- Tools used: [list with rationale]
- Sources consulted with tier classification
- Scope and limitations noted

### Detailed Findings

#### [Theme/Topic 1]
**Finding:** [Clear statement]
**Evidence:** [Specific data/quotes with citations]
**Source Tier:** [1/2/3]
**Tool Agreement:** [Which tools corroborated]
**Confidence:** [High/Medium-High/Medium/Low] - [justification]

#### [Theme/Topic 2]
[Same structure...]

### Cross-Source Analysis
- Points of consensus across sources
- Contradictions or disagreements found
- Information gaps identified

### Conclusion
- Synthesis of findings
- Actionable recommendations
- Areas requiring further investigation

### Sources
Complete citations with:
1. [Title] - [URL] - [Access date] - [Tier] - [Extraction tool used]
2. [Continue...]

---

## Failure Recovery

**If WebFetch fails on a URL:**
1. Try Firecrawl scrape with `waitFor: 3000`
2. If still fails, check if Perplexity has summarized the content
3. Note limitation and find alternative source

**If Perplexity returns uncertain/outdated info:**
1. Cross-verify with direct WebFetch to primary sources
2. Run WebSearch for more recent coverage
3. Note recency concerns in confidence assessment

**If no results found for a subtopic:**
1. Broaden search terms
2. Try alternative phrasings
3. Explicitly note as "Information Gap" in findings

**If tools return contradictory information:**
1. Document both findings with sources
2. Apply -20% confidence modifier
3. Recommend further verification in conclusions
