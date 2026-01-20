---
description: Conduct comprehensive research using Claude-first methodology with evidence-based analysis
---

Conduct comprehensive research on the topic using the **Claude-First** methodology.

## Step 0: Query Classification

Before selecting tools, classify this query:

| Dimension | Options | This Query |
|-----------|---------|------------|
| **Knowledge Type** | Factual / Analytical / Current / Historical | [Assess] |
| **Recency Need** | Static / Stable / Recent (<6mo) / Live | [Assess] |
| **Stakes Level** | Low / Medium / High | [Assess] |

## Depth Selection

Based on classification, select appropriate depth:

| Depth | Use When | Stages | Tools |
|-------|----------|--------|-------|
| **Claude-Only** | Static facts, explanations, historical | 0 only | Claude native knowledge |
| **Quick** | Simple current events, quick lookups | 0-1 | Claude + Perplexity |
| **Standard** | Most research requests | 0-3 | Claude + WebSearch + Perplexity + WebFetch |
| **Deep** | Complex topics, high-stakes, comprehensive | 0-4 | All tools including Firecrawl, OpenRouter |

---

## Stage 0: Claude Knowledge Synthesis

**Goal:** Establish what Claude knows before reaching for external tools

**Actions:**
1. Synthesize Claude's baseline knowledge on the topic
2. Identify knowledge gaps requiring external verification
3. Determine if external tools are actually needed

**Self-check:**
- [ ] Can Claude answer this confidently from training data?
- [ ] Is the information likely still current (pre-2025 knowledge)?
- [ ] What specific gaps need external verification?

**If Claude-Only depth:** Provide complete answer from Claude's knowledge → DONE

---

## Stage 1: Landscape Discovery [PARALLEL]

**Goal:** Verify Claude's knowledge and discover sources

**Execute in parallel (only if recency verification needed):**

1. **WebSearch Discovery (FREE):**
   - Query: "[topic] authoritative sources official"
   - Query: "[topic] recent developments 2025"

2. **Perplexity Overview (if current events):**
   - Use `mcp__perplexity` for AI-synthesized overview
   - Query: "[topic] current state key developments"

3. **Brave Search (for diverse perspectives):**
   - Use `mcp__brave_search` for independent index
   - Good for news, alternative viewpoints

**Checkpoint:**
- [ ] Claude's knowledge verified as current OR updates identified
- [ ] 5-10 potentially authoritative sources discovered
- [ ] Subtopics needing deeper investigation identified
- [ ] Determined if Standard or Deep depth needed

**If Quick depth:** Synthesize Claude + Perplexity findings → Skip to Stage 4

---

## Stage 2: Deep Content Extraction [SELECTIVE]

**Goal:** Extract content from high-value sources beyond what Claude knows

**Cost-Optimized Tool Selection:**

| Source Type | First Try (FREE) | Fallback (PAID) |
|-------------|------------------|-----------------|
| Wikipedia, docs | WebFetch | N/A |
| Academic papers | WebFetch | N/A |
| Government sites | WebFetch | N/A |
| News articles | WebFetch | Firecrawl (if paywall) |
| JS-heavy sites | — | Firecrawl scrape |
| Data tables/specs | — | Firecrawl extract |
| Code/technical | Exa semantic search | Firecrawl |

**Cost Optimization Rules:**
1. **Skip if Claude already knows** - Don't fetch what Claude can explain
2. **Skip if Perplexity summarized** - Don't duplicate AI synthesis
3. **WebFetch before Firecrawl** - Always try free first
4. **Limit Firecrawl crawls** - 5-10 pages maximum

**Execute extractions:**
- Process only sources that add NEW information beyond Claude's knowledge
- Note extraction method for each source

**Checkpoint:**
- [ ] Extracted content from key authoritative sources
- [ ] Noted what's NEW vs. what confirms Claude's knowledge
- [ ] Identified access limitations (paywalls, etc.)

---

## Stage 3: Verification [PARALLEL]

**Goal:** Cross-check claims, especially where Claude + external differ

**Execute in parallel:**

1. **Perplexity Fact-Check:**
   - Query: "verify [specific claim]"
   - Query: "is it true that [key finding]"

2. **Alternative Perspective Search:**
   - WebSearch: "[topic] criticism concerns limitations"
   - Brave: "[topic] alternative viewpoints debate"

3. **Recency Verification:**
   - WebSearch: "[topic] latest news [current month year]"

**For High-Stakes Claims (Deep depth only):**
- Use `mcp__openrouter` cross-model validation
- Use `mcp__exa` for semantic search verification
- Query same claim to multiple models, note consensus

**Checkpoint:**
- [ ] Key claims verified across 2+ independent sources
- [ ] Contradictions between Claude and external sources documented
- [ ] Tool agreement/disagreement assessed for confidence scoring

---

## Stage 4: Synthesis

**Goal:** Integrate Claude's knowledge with external findings

**Apply Source Tiering:**
- **Tier 1**: Peer-reviewed papers, official docs, government data, primary sources
- **Tier 2**: Reputable news, industry reports, expert analysis
- **Tier 3**: General web content, blogs, forums, unverified

**Calculate Confidence Scores:**

Base confidence from sources:
- Multiple Tier 1 sources + Claude agree: High (90-100%)
- Claude + Tier 1-2 external agree: Medium-High (70-89%)
- Tier 2-3 sources, some disagreement: Medium (50-69%)
- Single source or Claude/external contradict: Low (30-49%)

Apply tool agreement modifiers:
- Claude confident + external confirms: +10%
- Perplexity + Firecrawl agree: +15%
- Multiple WebSearch URLs corroborate: +10%
- OpenRouter 3+ models consensus: +15%
- Claude + external disagree: Investigate, note uncertainty
- Tools return contradictory info: -20%
- Single tool, single source: -10%

---

## Deliverable Format

### Executive Summary
- Key findings in 3-5 bullet points
- Overall confidence level with justification
- Critical insights or red flags
- **Claude knowledge vs. new findings** highlighted

### Methodology
- Query classification (knowledge type, recency, stakes)
- Research depth applied (Claude-Only/Quick/Standard/Deep)
- **Claude's baseline knowledge** summary
- Tools used with rationale
- Sources consulted with tier classification

### Detailed Findings

#### [Theme/Topic 1]
**Claude's Baseline Knowledge:** [What Claude knew from training]
**External Verification:** [What tools confirmed/updated/contradicted]
**Synthesized Finding:** [Integrated conclusion]
**Evidence:** [Specific data/quotes with citations]
**Source Tier:** [1/2/3]
**Tool Agreement:** [Which sources/tools corroborated]
**Confidence:** [High/Medium-High/Medium/Low] - [justification]

#### [Theme/Topic 2]
[Same structure...]

### Cross-Source Analysis
- Points where Claude + external agree (high confidence)
- Where external updated Claude's knowledge
- Contradictions found and resolution
- Information gaps identified

### Conclusion
- Synthesis of findings
- Actionable recommendations
- Areas requiring further investigation

### Sources
Complete citations with:
1. [Title] - [URL] - [Access date] - [Tier] - [Tool used]
2. [Continue...]

Note: "Claude baseline" as source for information from training data

---

## Failure Recovery

**If WebFetch fails:**
1. Try Firecrawl scrape with `waitFor: 3000`
2. Check if Perplexity/Claude already has the content
3. Note limitation and find alternative source

**If Perplexity returns uncertain/outdated:**
1. Cross-verify with WebFetch to primary sources
2. Check against Claude's baseline knowledge
3. Note recency concerns in confidence

**If Claude and external sources conflict:**
1. Document both perspectives
2. Weight by source tier
3. Apply -20% confidence if unresolved
4. Recommend further verification

**If no external results found:**
1. Broaden search terms
2. Rely on Claude's knowledge with noted limitations
3. Explicitly note as "Based on Claude's training, unverified externally"
