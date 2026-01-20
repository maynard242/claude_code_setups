---
name: tool-orchestration
description: Multi-source web research and tool coordination skill. Automatically activates for research-oriented queries requiring web search, fact-checking, or multi-source verification.
---

# Tool Orchestration Skill

You have access to multiple research tools. This skill provides guidance on selecting and coordinating them effectively.

## Available Research Tools

### Free Tools (Use First)

| Tool | Function | Best For |
|------|----------|----------|
| **WebSearch** | Search engine queries | URL discovery, finding sources, broad searches |
| **WebFetch** | Fetch single URL content | Simple HTML pages, academic papers, basic news sites |

### Paid/Premium Tools (Use Selectively)

| Tool | Function | Best For |
|------|----------|----------|
| **Perplexity** (`mcp__perplexity`) | AI-synthesized search | Quick answers, current events, synthesized overviews |
| **Firecrawl** (`mcp__firecrawl`) | Advanced web scraping | JS-heavy sites, structured extraction, site crawling |
| **OpenRouter** (`mcp__openrouter`) | Multi-model access | Cross-model validation, specialized analysis |

## Quick Reference: Tool Selection

```
What do I need?                    → Tool to use
─────────────────────────────────────────────────
Quick factual answer               → Perplexity
Find URLs/sources                  → WebSearch (free)
Simple page content                → WebFetch (free)
Complex/JS page content            → Firecrawl scrape
Structured data extraction         → Firecrawl extract
Site structure/all pages           → Firecrawl map
Current events (<24h)              → Perplexity + WebSearch [parallel]
Verify critical claim              → Multiple tools [parallel]
Cross-model consensus              → OpenRouter
```

## Tool-Specific Guidance

### WebSearch

**When to use:**
- Don't know which URLs contain the information
- Need to discover sources and authoritative sites
- Want broad coverage of a topic
- Cost-conscious searches (free, unlimited)

**Tips:**
- Use specific, targeted queries
- Include year for recency: "topic 2025"
- Use site: operator for specific domains
- Results provide URLs - follow up with WebFetch/Firecrawl

### WebFetch

**When to use:**
- Have a specific URL to retrieve
- Page is standard HTML (not JS-heavy)
- Cost-conscious content retrieval (free)

**Tips:**
- Try this first before Firecrawl
- Works well for Wikipedia, academic sites, government pages
- May fail on paywalls, JS-rendered content

**Fallback:** If WebFetch fails, use Firecrawl scrape

### Perplexity (mcp__perplexity)

**When to use:**
- Need AI-synthesized answer quickly
- Current events and news
- Quick factual lookups
- Want sources cited automatically

**Tips:**
- Use for overview before deep dives
- Good for "what is X" type queries
- Cross-verify important claims with other tools

### Firecrawl (mcp__firecrawl)

**Available operations:**

| Operation | Use When |
|-----------|----------|
| `firecrawl_scrape` | Single page, especially JS-heavy |
| `firecrawl_map` | Discover all URLs on a site |
| `firecrawl_crawl` | Extract multiple pages from site |
| `firecrawl_extract` | Structured data with JSON schema |
| `firecrawl_search` | Search with scraping (powerful) |

**Tips:**
- Use `waitFor` option for slow-loading pages
- Set `limit` on crawls to control costs
- `extract` is powerful for tables, specs, prices
- `map` first to understand site structure, then selective `scrape`

**Cost awareness:** Higher cost per page than other tools. Use selectively.

### OpenRouter (mcp__openrouter)

**When to use:**
- High-stakes claims needing cross-model validation
- Specialized analysis (code, math, creative)
- Want consensus from multiple AI models

**Available tools:**
- `chat_with_model` - Query specific model
- `collective_chat_completion` - Multi-model consensus
- `cross_model_validation` - Validate content across models
- `ensemble_reasoning` - Complex problem solving

**Tips:**
- Use for verification, not primary research
- Consensus from 3+ models increases confidence
- Different models have different strengths

## Execution Patterns

### Pattern 1: Simple Factual Query
```
User: "What is the population of Tokyo?"
→ Perplexity only (quick, synthesized answer)
```

### Pattern 2: Source Discovery
```
User: "Find research on climate change impacts"
→ WebSearch (find URLs)
→ WebFetch (retrieve promising sources)
```

### Pattern 3: Deep Content Extraction
```
User: "Get full content from this complex site"
→ WebFetch (try first - free)
→ If fails: Firecrawl scrape (handles JS)
```

### Pattern 4: Comprehensive Research [PARALLEL]
```
User: "Research the current state of quantum computing"
Stage 1 [parallel]:
  → Perplexity (overview)
  → WebSearch (find sources)
Stage 2 [sequential]:
  → WebFetch/Firecrawl (extract key sources)
Stage 3 [parallel]:
  → Perplexity (verify claims)
  → WebSearch (alternative views)
Stage 4:
  → Synthesize findings
```

### Pattern 5: High-Stakes Verification [PARALLEL]
```
User: "Verify this critical claim for a report"
→ Perplexity (initial check)
→ WebSearch + WebFetch (find primary sources)
→ Firecrawl extract (if structured data needed)
→ OpenRouter cross-model validation (if available)
→ Note tool agreement in confidence score
```

## Cost Optimization Strategy

**"Start free, escalate paid":**

1. **Level 1 (Free):** WebSearch + WebFetch
   - URL discovery, simple page retrieval
   - Always start here

2. **Level 2 (Medium cost):** Perplexity
   - When free tools don't provide synthesis
   - For current events and quick answers

3. **Level 3 (Higher cost):** Firecrawl
   - Only when WebFetch fails
   - For structured extraction, JS sites

4. **Level 4 (Use sparingly):** OpenRouter
   - High-stakes verification only
   - Cross-model consensus needs

## Parallel Execution Guidelines

**Execute in parallel when:**
- Queries are independent (don't depend on each other's results)
- Want to maximize efficiency
- Need multi-source verification

**Execute sequentially when:**
- Later query depends on earlier results
- Need to decide next step based on findings
- Avoiding redundant API calls

**Example parallel execution:**
```
[PARALLEL] Stage 1:
  - Perplexity: "topic overview"
  - WebSearch: "topic authoritative sources"
  - WebSearch: "topic recent news"

[SEQUENTIAL] Stage 2:
  (Depends on Stage 1 URLs)
  - WebFetch: URL1
  - WebFetch: URL2
  - Firecrawl: URL3 (if WebFetch fails)
```

## Failure Handling

### WebFetch Fails
1. Check if URL is valid and accessible
2. Try Firecrawl scrape with `waitFor: 3000`
3. If paywall, note limitation, find alternative
4. Check if Perplexity has summarized the content

### Firecrawl Rate Limited
1. Reduce batch size
2. Add delays between requests
3. Fall back to WebFetch for simpler pages
4. Note limitation in findings

### Perplexity Uncertain/Outdated
1. Cross-verify with WebSearch + WebFetch
2. Find primary sources directly
3. Note recency concerns in confidence score

### No Results Found
1. Broaden search terms
2. Try alternative phrasings
3. Check different tools
4. Document as "Information Gap"

## Confidence Scoring with Tool Agreement

Base your confidence scores on tool agreement:

| Scenario | Confidence Modifier |
|----------|-------------------|
| Perplexity + Firecrawl extracted content agree | +15% |
| Multiple WebSearch URLs corroborate | +10% |
| OpenRouter 3+ models agree | +15% |
| Tools return contradictory info | -20% |
| Single tool, single source | -10% |
| Primary source accessed directly | +10% |

## Common Pitfalls to Avoid

### 1. Over-Engineering Simple Queries
**Wrong:** Complex site crawl for "What year was Python created?"
**Right:** Perplexity quick answer

### 2. Ignoring Free Tools
**Wrong:** Jump straight to Firecrawl for simple HTML page
**Right:** Try WebFetch first (free), escalate only if needed

### 3. Single-Source Answers for Important Claims
**Wrong:** One Perplexity response for critical business decision
**Right:** Multi-tool verification with confidence scoring

### 4. Not Noting Tool Limitations
**Wrong:** Present paywalled content as if fully retrieved
**Right:** Note extraction limitations, seek alternatives

### 5. Sequential When Parallel Would Work
**Wrong:** Wait for each search before starting next
**Right:** Run independent searches in parallel

## Meta-Cognitive Prompts

Before starting any research:
- "Is this a quick lookup or comprehensive research?"
- "Which free tools can I try first?"
- "What tool combination will be most efficient?"

During research:
- "Should I escalate to a paid tool, or can free suffice?"
- "Are my parallel calls truly independent?"
- "Am I over-engineering for a simple query?"

Before presenting results:
- "Did I note which tools retrieved each finding?"
- "Is my confidence score justified by tool agreement?"
- "Did I handle any tool failures gracefully?"
