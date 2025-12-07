# Search Tools Usage Guide

This guide provides best practices for using the three primary search tools available in the general_ai setup: **WebSearch**, **Exa**, and **Firecrawl**.

## Quick Reference

| Tool | Best For | Cost | Speed |
|------|----------|------|-------|
| WebSearch | Current events, general queries, news | Free | Fast |
| Exa | Code context, technical docs, academic research | Paid | Medium |
| Firecrawl | Deep site extraction, structured scraping | Paid | Slow |

## Tool 1: WebSearch (Native/Brave)

### When to Use
- **Current events** and breaking news
- **General web search** queries
- **Quick fact-checking** and basic research
- **Recent information** (within last few months)
- **Cost-sensitive** queries where accuracy isn't mission-critical

### Optimal Strategy
- Use for initial exploration before diving into specialized tools
- Great for getting a broad overview of a topic
- Best for queries that benefit from recency
- **No API costs** - use liberally for exploratory research

### Example Use Cases
```
- "Latest developments in AI regulation 2025"
- "Current stock price of AAPL"
- "Recent news about climate change"
- "How to reset password on GitHub"
```

### Limitations
- May return less authoritative sources
- No specialized filtering for code or technical content
- Limited control over source quality

---

## Tool 2: Exa (Neural Search)

### When to Use
- **Code context** and programming documentation
- **Technical documentation** from authoritative sources
- **Academic research** and scholarly articles
- **High-quality content** from curated sources
- When you need **semantic search** rather than keyword matching

### Optimal Strategy
- Use `get_code_context_exa` for ANY programming-related queries
- Specify token limits based on context needs:
  - **1,000-2,000 tokens**: Quick reference, specific API docs
  - **5,000 tokens** (default): Balanced context for most use cases
  - **10,000-20,000 tokens**: Comprehensive guides, full tutorials
  - **50,000 tokens** (max): Extensive documentation review

- Use `web_search_exa` for high-quality web content
- Configure search parameters:
  - `type: 'auto'` - Balanced search (default)
  - `type: 'fast'` - Quick results when speed matters
  - `type: 'deep'` - Comprehensive search for critical queries
  - `numResults: 8` (default) - Adjust based on breadth needed

### Example Use Cases
```
# Code Context
- "React useState hook implementation details"
- "PyTorch model training loop best practices"
- "Next.js 14 app router configuration"

# Technical Research
- "GraphQL subscription architecture patterns"
- "Kubernetes autoscaling strategies"
- "Machine learning model versioning approaches"

# Academic Content
- "Recent papers on transformer architecture improvements"
- "Statistical methods for A/B testing"
```

### Cost Optimization
- Start with lower token counts and increase if needed
- Use 'fast' mode for exploratory searches
- Reserve 'deep' mode for critical research
- Batch related queries together

### Limitations
- Higher cost per query than WebSearch
- May have slight delay compared to WebSearch
- Best for technical/professional content (not ideal for news/entertainment)

---

## Tool 3: Firecrawl (Web Scraping)

### When to Use
- **Deep content extraction** from specific websites
- **Structured data extraction** from web pages
- **Site mapping** and understanding site structure
- **Crawling entire sites** or sections for comprehensive data
- When you need **full page content** not just snippets

### Available Operations

#### `firecrawl_scrape`
- Extract clean content from a single URL
- Returns markdown-formatted text
- Best for: Reading full articles, documentation pages, blog posts

#### `firecrawl_search`
- Search-like interface to find and scrape relevant pages
- Combines search with content extraction
- Best for: Finding specific content across the web

#### `firecrawl_map`
- Map out the structure of a website
- Returns list of all URLs on a site
- Best for: Understanding site architecture, finding all pages

#### `firecrawl_crawl`
- Recursively crawl multiple pages on a site
- Follow links and extract content from each page
- Best for: Extracting comprehensive information from a domain

#### `firecrawl_extract`
- Extract structured data using custom schemas
- Parse specific fields from pages
- Best for: Data extraction with specific formats (prices, dates, etc.)

### Optimal Strategy
- **Start small**: Use `scrape` for single pages before crawling
- **Map first**: Use `firecrawl_map` to understand site structure
- **Targeted crawling**: Limit crawl depth and page count to control costs
- **Schema extraction**: Define clear schemas for `extract` to get structured data
- **Cache results**: Save extracted content to avoid redundant calls

### Example Use Cases
```
# Single Page Extraction
- Extract full content from a research paper PDF
- Get complete text from a company's about page
- Parse documentation from a specific API reference

# Site Mapping
- Map all URLs on a company website
- Understand blog structure for content analysis
- Find all product pages on an e-commerce site

# Comprehensive Crawling
- Extract all blog posts from a technical blog
- Gather pricing information across competitor websites
- Build knowledge base from documentation site

# Structured Extraction
- Extract product names, prices, and descriptions
- Parse event dates, locations, and details
- Gather contact information from directory sites
```

### Cost Optimization
- **Limit crawl depth**: Use `maxDepth` parameter to control recursion
- **Limit page count**: Set `limit` to cap number of pages crawled
- **Use targeted URLs**: Be specific about starting points
- **Cache aggressively**: Store results locally to avoid re-crawling
- **Consider alternatives**: If you just need metadata, WebSearch or Exa may be cheaper

### Limitations
- **Highest cost** of the three tools (charged per page)
- **Slowest** operation (especially crawls)
- May be blocked by anti-scraping measures on some sites
- Rate limiting may require patience for large crawls

---

## Decision Tree

```
START
  │
  ├─ Need current news/events?
  │   └─ YES → WebSearch
  │
  ├─ Need code/technical docs?
  │   └─ YES → Exa (get_code_context_exa)
  │
  ├─ Need full page content/scraping?
  │   └─ YES → Firecrawl (scrape)
  │
  ├─ Need to crawl entire site?
  │   └─ YES → Firecrawl (map + crawl)
  │
  ├─ Need high-quality research?
  │   └─ YES → Exa (web_search_exa with 'deep')
  │
  └─ General query, cost-sensitive?
      └─ YES → WebSearch
```

## Best Practices

### 1. Layer Your Searches
- **Start broad**: WebSearch for overview
- **Go deep**: Exa for authoritative sources
- **Extract details**: Firecrawl for comprehensive content

### 2. Cost Management
- Use WebSearch for exploration (free)
- Use Exa for quality over quantity (moderate cost)
- Use Firecrawl sparingly for specific extraction needs (highest cost)

### 3. Quality vs Speed
- **Fast & Free**: WebSearch
- **Quality & Moderate**: Exa
- **Comprehensive & Slow**: Firecrawl

### 4. Avoid Redundancy
- Don't use Firecrawl if Exa can get the information
- Don't use Exa if WebSearch provides sufficient results
- Don't crawl entire sites if you only need a few pages

### 5. Combine Strategically
```python
# Example workflow for deep research:

# Step 1: Broad overview (WebSearch)
# "What are the main GraphQL clients for React?"

# Step 2: Technical details (Exa)
# "Apollo Client vs URQL detailed comparison with code examples"

# Step 3: Extract specific content (Firecrawl)
# Scrape official docs from apollographql.com for latest API reference
```

## Tool Selection Examples

| Query | Recommended Tool | Reasoning |
|-------|------------------|-----------|
| "Latest AI news" | WebSearch | Current events, free |
| "PyTorch distributed training tutorial" | Exa | Technical docs, code context |
| "Extract all products from competitor site" | Firecrawl | Structured extraction |
| "How does JWT authentication work?" | Exa or WebSearch | Exa for depth, WebSearch for quick answer |
| "Scrape all blog posts from example.com" | Firecrawl | Site-wide crawling |
| "React hooks documentation" | Exa | Authoritative code docs |
| "Current Bitcoin price" | WebSearch | Real-time data |

## Summary

- **WebSearch**: Your default for general queries, current events, and cost-sensitive searches
- **Exa**: Your technical expert for code, documentation, and high-quality research
- **Firecrawl**: Your scraping specialist for deep content extraction and site crawling

Always start with the least expensive tool that meets your needs, and escalate to more specialized tools only when necessary.
