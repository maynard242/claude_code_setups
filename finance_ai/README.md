# Financial / Investment Research Setup

Financial analysis and investment research configuration for Claude Code.

## Use Cases

- Stock and equity research
- Financial statement analysis
- Valuation modeling (DCF, comps)
- Earnings call analysis
- Industry and competitive analysis
- Investment thesis development

## Features

### Specialized Agent
- **financial-analyst**: Investment research specialist with valuation frameworks, financial metrics, and risk assessment expertise

### Auto-Approved Tools
- WebSearch, WebFetch
- Data: python, curl, jq
- MCP: Exa (market search), Firecrawl (data extraction)

### Status Line
Shows finance mode indicator with current directory

## Quick Start

```bash
# Install
cp -r finance_ai/.claude ~/

# Or use setup switcher
./switch-setup.sh finance_ai

# Test
claude
> "Analyze Apple's latest 10-K filing"
> "Build a DCF model for [company]"
> "Compare valuation multiples for [industry]"
```

## Analysis Framework

### Key Metrics
- **Profitability**: Gross margin, operating margin, ROE, ROIC
- **Growth**: Revenue growth, EPS growth, EBITDA growth
- **Valuation**: P/E, EV/EBITDA, P/S, FCF yield
- **Quality**: FCF conversion, debt/EBITDA, interest coverage

### Valuation Methods
- Discounted Cash Flow (DCF)
- Comparable Company Analysis
- Precedent Transactions
- Sum-of-Parts

## Report Format

- Executive summary with recommendation
- Company and industry overview
- Financial analysis with tables
- Valuation with multiple methods
- Bull/bear case scenarios
- Risk assessment

## Common Tasks

- Parse SEC filings (10-K, 10-Q, 8-K)
- Analyze earnings transcripts
- Build financial models
- Screen stocks by criteria
- Compare peer valuations
- Identify red flags

## Best For

- Equity researchers
- Investment analysts
- Portfolio managers
- Individual investors
- M&A professionals
- Financial advisors
