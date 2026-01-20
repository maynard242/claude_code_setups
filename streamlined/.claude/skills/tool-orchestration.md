---
name: tool-orchestration
description: Multi-source web research and tool coordination skill. Automatically activates for research-oriented queries requiring web search, fact-checking, or multi-source verification.
---

# Tool Orchestration Skill

You have access to multiple research tools. This skill provides guidance on selecting and coordinating them effectively using a **Claude-First** approach.

## Core Principle: Claude-First Research

**ALWAYS start with Claude's native knowledge.** Claude has extensive training data through May 2025 covering:
- Established facts, definitions, scientific principles
- Historical events and context
- Programming languages, frameworks, algorithms, design patterns
- Technical concepts and how-things-work explanations
- Academic knowledge across disciplines

**Skip external tools entirely when:**
- Query is about well-established, static knowledge
- Information unlikely to have changed since training
- Claude can provide a confident, detailed answer
- No verification or recency confirmation needed

## Query Classification (Do This First)

Before selecting tools, classify the query:

```
1. KNOWLEDGE TYPE
   ├─ Factual: "What is X?" → Often Claude-only
   ├─ Analytical: "Why does X happen?" → Often Claude-only
   ├─ Current: "What's happening with X?" → Needs external
   └─ Historical: "What happened with X?" → Claude + light verify

2. RECENCY REQUIREMENT
   ├─ Static: Unlikely to change → Claude-only
   ├─ Stable: Changes slowly → Claude + verify
   ├─ Recent: Changed in last 6 months → External required
   └─ Live: Changes daily/hourly → External required

3. STAKES LEVEL
   ├─ Low: Casual inquiry → Minimal verification
   ├─ Medium: Professional use → Standard verification
   └─ High: Critical decision → Full multi-source verification
```

## Tool Hierarchy (Use in Order)

### Tier 0: Claude's Native Knowledge (FREE, INSTANT)
**Always try first.** Use for:
- Definitions, concepts, explanations
- How things work
- Historical facts (pre-2025)
- Programming and technical knowledge
- Scientific principles, math, logic
- Comparative analysis using existing knowledge

**Self-check:** "Can I answer this confidently from training data?"

### Tier 1: WebSearch (FREE, FAST)
| When to Use | Example |
|-------------|---------|
| Verify Claude's knowledge is current | "Is React still using virtual DOM?" |
| Find URLs for deeper investigation | "Find SEC filings for Tesla" |
| Discover sources and landscape | "Who are key players in X industry?" |
| Current events and news | "Latest developments in AI regulation" |

**Tips:**
- Use specific queries with year: "topic 2025"
- Use `site:` operator for specific domains
- Results are URLs - follow up with WebFetch/Firecrawl

### Tier 2: WebFetch (FREE, FAST)
| When to Use | Example |
|-------------|---------|
| Retrieve simple HTML pages | Wikipedia, documentation |
| Academic papers and PDFs | ArXiv, research papers |
| Government and institutional sites | SEC, FDA, official docs |
| Static documentation | API docs, specs |

**Tips:**
- Always try before Firecrawl
- Works well for Wikipedia, academic sites, government pages
- May fail on paywalls, JS-rendered content

**Fallback:** If WebFetch fails → Firecrawl scrape

### Tier 3: Perplexity (MEDIUM COST, FAST)
| Tool | Best For |
|------|----------|
| `perplexity_ask` | Quick synthesized answers, conversational |
| `perplexity_search` | Web search with ranked results |
| `perplexity_research` | Deep multi-source synthesis (sonar-deep-research) |
| `perplexity_reason` | Complex reasoning tasks (sonar-reasoning-pro) |

**When to use:**
- Need AI-synthesized overview quickly
- Current events and breaking news
- Quick factual lookups with citations
- Cross-reference Claude's knowledge

**Tips:**
- Good for "what is the current state of X"
- Cross-verify important claims with other tools
- Use `perplexity_research` for comprehensive topics

### Tier 4: Brave Search (LOW-MEDIUM COST, FAST)
**If configured via MCP:**
- Independent search index (not Google/Bing derivative)
- Good for diverse perspectives
- Strong for news and current events
- Privacy-focused results

**When to use:**
- Want results independent from mainstream engines
- News and current events
- Diverse source discovery

### Tier 5: Firecrawl (HIGH COST, SLOW)
| Operation | Use When |
|-----------|----------|
| `firecrawl_scrape` | JS-heavy single pages, dynamic content |
| `firecrawl_map` | Discover all URLs on a site before crawling |
| `firecrawl_crawl` | Extract multiple pages (use limits!) |
| `firecrawl_extract` | Structured data with JSON schema (tables, specs) |
| `firecrawl_search` | Search with scraping (powerful but expensive) |

**Cost optimization:**
- ALWAYS try WebFetch first
- Use `waitFor: 3000` for slow-loading pages
- Set `limit` on crawls (5-10 pages max)
- `map` first to understand site, then selective `scrape`

### Tier 6: OpenRouter (VARIABLE COST, HIGH CONFIDENCE)
| Tool | Use Case |
|------|----------|
| `cross_model_validation` | Verify critical claims across models |
| `ensemble_reasoning` | Complex problems needing consensus |
| `collective_chat_completion` | Multi-model synthesis |
| `chat_with_model` | Specialized model for specific task |

**Use ONLY for:**
- High-stakes claims requiring verification
- Critical business/legal/medical decisions
- When tool disagreement needs resolution
- Adds +15% confidence when 3+ models agree

## Quick Reference Decision Tree

```
START: What do I need?
│
├─► Well-established fact/concept?
│   └─► Claude only → DONE
│
├─► Technical/programming question?
│   └─► Claude first → If edge case, WebSearch/Exa
│
├─► Historical event (pre-2025)?
│   └─► Claude → WebSearch to verify (optional)
│
├─► Current events (<6 months)?
│   └─► WebSearch + Perplexity [PARALLEL]
│
├─► Live data (prices, stocks, weather)?
│   └─► Perplexity (real-time data access)
│
├─► Need to find URLs/sources?
│   └─► WebSearch (free, fast)
│
├─► Need page content from URL?
│   ├─► Simple HTML → WebFetch (free)
│   └─► JS-heavy/complex → Firecrawl (if WebFetch fails)
│
├─► Need structured data extraction?
│   └─► Firecrawl extract with JSON schema
│
├─► Comprehensive research (deep)?
│   └─► Full Pipeline: Claude → WebSearch → Perplexity →
│       selective WebFetch/Firecrawl → synthesis
│
└─► High-stakes verification?
    └─► Full Pipeline + OpenRouter cross-validation
```

## Execution Patterns

### Pattern 1: Claude-Only (Most Efficient)
```
User: "Explain how HTTP/2 multiplexing works"
→ Claude provides detailed technical explanation
→ No external tools needed
→ DONE
```

### Pattern 2: Claude + Light Verification
```
User: "Is GraphQL still popular for APIs?"
→ Claude: Provides knowledge about GraphQL adoption
→ WebSearch: "GraphQL adoption trends 2025" (verify recency)
→ Synthesize
```

### Pattern 3: Current Events [PARALLEL]
```
User: "What are the latest AI regulations?"
[PARALLEL]:
  → Perplexity: "AI regulations 2025 latest developments"
  → WebSearch: "AI regulation news January 2025"
→ Synthesize findings
```

### Pattern 4: Deep Research [STAGED]
```
User: "Comprehensive analysis of quantum computing market"
Stage 1 [PARALLEL] - Discovery:
  → Claude: Baseline knowledge synthesis
  → Perplexity: "quantum computing market overview 2025"
  → WebSearch: "quantum computing companies market leaders"
Stage 2 [SELECTIVE] - Deep Extraction:
  → WebFetch: Top 3-5 authoritative URLs
  → Firecrawl: Only if WebFetch fails
Stage 3 [PARALLEL] - Verification:
  → Perplexity: Verify key claims
  → WebSearch: Alternative perspectives
Stage 4 - Synthesis:
  → Claude native reasoning to integrate findings
```

### Pattern 5: High-Stakes Verification
```
User: "Is [Company X] financially stable for major partnership?"
→ Full deep research pipeline
→ PLUS: OpenRouter cross-model validation on critical claims
→ Note: 3+ models agreeing adds +15% confidence
```

## Cost Optimization Strategy

**"Claude first, start free, escalate paid"**

| Level | Tools | When to Use |
|-------|-------|-------------|
| **0 (Free)** | Claude native | Static knowledge, explanations |
| **1 (Free)** | WebSearch | URL discovery, verification |
| **2 (Free)** | WebFetch | Simple page content |
| **3 (Medium)** | Perplexity | Synthesis, current events |
| **4 (Medium)** | Brave/Exa | Diverse/semantic search |
| **5 (High)** | Firecrawl | Complex extraction |
| **6 (Variable)** | OpenRouter | Critical verification |

**Cost-saving rules:**
1. If Claude knows it → stop
2. If WebSearch finds it → stop
3. If WebFetch retrieves it → stop
4. Only escalate when lower tiers fail or are insufficient

## Confidence Scoring with Tool Agreement

| Scenario | Confidence Modifier |
|----------|-------------------|
| Claude confident + external confirms | +10% |
| Perplexity + Firecrawl extracted agree | +15% |
| Multiple WebSearch URLs corroborate | +10% |
| OpenRouter 3+ models agree | +15% |
| Claude + Perplexity disagree | Investigate further |
| Tools return contradictory info | -20% |
| Single tool, single source | -10% |
| Primary source accessed directly | +10% |

## Common Pitfalls to Avoid

### 1. Skipping Claude for External Tools
**Wrong:** Jump to Perplexity for "What is machine learning?"
**Right:** Claude provides comprehensive answer, no tools needed

### 2. Over-Engineering Simple Queries
**Wrong:** Full pipeline for "Python list comprehension syntax"
**Right:** Claude answers directly

### 3. Ignoring Free Tools
**Wrong:** Firecrawl for simple Wikipedia page
**Right:** WebFetch first (free), Firecrawl only if it fails

### 4. Single-Source for Critical Claims
**Wrong:** One Perplexity response for investment decision
**Right:** Multi-tool verification + OpenRouter validation

### 5. Sequential When Parallel Works
**Wrong:** Wait for each search before starting next
**Right:** Run independent searches in parallel

## Meta-Cognitive Prompts

**Before starting:**
- "Can Claude answer this confidently from training data?"
- "Does this need current information or is historical/static?"
- "What's the minimum tool set needed?"

**During research:**
- "Should I escalate to a paid tool, or can free suffice?"
- "Are my parallel calls truly independent?"
- "Am I over-engineering for a simple query?"

**Before presenting:**
- "Did I attribute findings to correct sources?"
- "Is my confidence score justified by tool agreement?"
- "Did I start with Claude and escalate appropriately?"
