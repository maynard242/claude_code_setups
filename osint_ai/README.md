# OSINT / Investigative Research Setup

Open-source intelligence and investigative research configuration for Claude Code.

## Use Cases

- Background investigations on people and companies
- Fact-checking and claim verification
- Digital footprint and social media analysis
- Corporate due diligence
- Domain and website investigation
- Timeline construction from multiple sources

## Features

### Specialized Agent
- **investigator**: OSINT specialist with systematic evidence gathering, source documentation, and confidence scoring

### Auto-Approved Tools
- WebSearch, WebFetch
- DNS: whois, dig, nslookup
- Data: curl, wget, jq, python
- MCP: Exa (semantic search), Firecrawl (deep scraping)

### Status Line
Shows investigation mode indicator with current directory

## Quick Start

```bash
# Install
cp -r osint_ai/.claude ~/

# Or use setup switcher
./switch-setup.sh osint_ai

# Test
claude
> "Investigate the background of company XYZ Corp"
> "Verify the claims made in this article: [URL]"
> "Build a timeline of events for [subject]"
```

## Investigation Methodology

1. **Scope Definition**: Define objectives, subjects, boundaries
2. **Information Gathering**: Wide net → deep dive → cross-reference
3. **Analysis**: Pattern recognition, timeline, red flags
4. **Reporting**: Evidence-based findings with confidence levels

## Evidence Standards

- **High Confidence**: Multiple primary sources, official records
- **Medium Confidence**: Single authoritative source, consistent secondary
- **Low Confidence**: Unverified single source, circumstantial

## Ethical Guidelines

- Only use publicly available information
- Respect privacy boundaries
- Don't misrepresent identity
- Document all sources with timestamps
- Note legal limitations

## Best For

- Due diligence research
- Journalism and fact-checking
- Competitive intelligence
- Fraud investigation
- Background checks
