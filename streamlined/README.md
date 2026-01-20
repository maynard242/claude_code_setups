# Streamlined Claude Code Setup

A universal Claude Code configuration that consolidates all capabilities into a single, powerful setup with 6 specialized agents, 3 slash commands, and integrated MCP servers for comprehensive research.

## Research Strategy: Claude-First Methodology

This setup implements an optimized **Claude-First** research approach that prioritizes accuracy, reliability, and efficiency:

### Tool Hierarchy (Use in Order)

| Tier | Tool | Cost | When to Use |
|------|------|------|-------------|
| **0** | Claude Native | Free | Static knowledge, explanations, historical facts |
| **1** | WebSearch | Free | URL discovery, verification, current events |
| **2** | WebFetch | Free | Simple HTML pages, documentation |
| **3** | Perplexity | Medium | AI synthesis, current events, quick lookups |
| **4** | Brave/Exa | Medium | Diverse search, semantic/code search |
| **5** | Firecrawl | High | JS-heavy sites, structured extraction |
| **6** | OpenRouter | Variable | Cross-model validation for high-stakes |

### Key Principle
**Always leverage Claude's knowledge first.** Skip external tools when:
- Query is about well-established, static knowledge
- Information unlikely to have changed since May 2025
- Claude can provide a confident, detailed answer

## Features

### 6 Consolidated Agents (All use Opus model)

| Agent | Description | Use Cases |
|-------|-------------|-----------|
| **researcher** | Web, academic, market research + OSINT | Research questions, fact-checking, background investigations, competitive analysis |
| **developer** | Python + ML/PyTorch development | Code development, ML training, testing, type safety |
| **financial-analyst** | Valuation and investment research | Stock analysis, DCF modeling, financial statements |
| **academic-writer** | Research papers, grants, LaTeX | Scientific writing, grant proposals, statistical reporting |
| **presentation-builder** | PowerPoint design | Pitch decks, business reports, training materials |
| **statement-processor** | Bank statement processing | Transaction extraction, categorization, CSV export |

### 3 Slash Commands

| Command | Description |
|---------|-------------|
| `/graham` | Evaluate talent using Paul Graham's framework |
| `/deep-research` | Conduct comprehensive multi-source research with Claude-first methodology |
| `/process-statement` | Process bank/credit card statements to CSV |

### MCP Server Integrations

| Server | Description | Required Env Var |
|--------|-------------|------------------|
| **Firecrawl** | Web scraping and content extraction | `FIRECRAWL_API_KEY` |
| **Perplexity** | AI-powered search with Sonar Pro models | `PERPLEXITY_API_KEY` |
| **OpenRouter** | Multi-model access and validation | `OPENROUTER_API_KEY` |
| **Brave Search** | Independent search index, diverse results | `BRAVE_API_KEY` |
| **Exa** | Neural/semantic search, code context | `EXA_API_KEY` |

#### Perplexity MCP Tools
- `perplexity_search` - Direct web search with ranked results
- `perplexity_ask` - Conversational AI with real-time search (sonar-pro)
- `perplexity_research` - Deep research with sonar-deep-research model
- `perplexity_reason` - Advanced reasoning with sonar-reasoning-pro

#### OpenRouter MCP Tools
- `cross_model_validation` - Verify claims across multiple AI models
- `ensemble_reasoning` - Complex problem solving with model consensus
- `collective_chat_completion` - Multi-model synthesis
- `chat_with_model` - Query specific models for specialized tasks

#### Firecrawl MCP Tools
- `firecrawl_scrape` - Single page extraction (JS-heavy sites)
- `firecrawl_map` - Discover all URLs on a site
- `firecrawl_crawl` - Multi-page extraction
- `firecrawl_extract` - Structured data with JSON schema

## Installation

### Quick Install

```bash
./switch-setup.sh streamlined
```

### Symlink Install (auto-updates)

```bash
./switch-setup.sh --link streamlined
```

### Manual Install

```bash
cp -r streamlined/.claude ~/
```

## Configuration

### Required Environment Variables

Set these in your shell profile (`~/.zshrc` or `~/.bashrc`):

```bash
# Core research tools (recommended)
export PERPLEXITY_API_KEY="your_perplexity_api_key"
export FIRECRAWL_API_KEY="your_firecrawl_api_key"

# Advanced verification (optional but recommended for high-stakes research)
export OPENROUTER_API_KEY="your_openrouter_api_key"

# Diverse search (optional)
export BRAVE_API_KEY="your_brave_api_key"
export EXA_API_KEY="your_exa_api_key"
```

Get API keys from:
- Perplexity: https://www.perplexity.ai/account/api/group
- Firecrawl: https://firecrawl.dev
- OpenRouter: https://openrouter.ai/keys
- Brave: https://brave.com/search/api/
- Exa: https://exa.ai

## Research Depth Levels

The `/deep-research` command supports multiple depth levels:

| Depth | Use When | Tools Used |
|-------|----------|------------|
| **Claude-Only** | Static facts, explanations, historical | Claude native knowledge only |
| **Quick** | Simple current events | Claude + Perplexity |
| **Standard** | Most research | Claude + WebSearch + Perplexity + WebFetch |
| **Deep** | Complex/high-stakes | All tools including Firecrawl, OpenRouter |

## Permissions

### Auto-allowed (no confirmation)

- **Web**: WebSearch, WebFetch, all MCP servers
- **Git**: All git operations
- **Development**: npm, npx, node, python, pip, pytest, mypy, ruff, black, poetry, uv
- **Documents**: pdflatex, bibtex, pandoc, pdftotext, pdftk
- **Files**: ls, cat, grep, find, mkdir, cp, mv, curl, jq, wc, head, tail

### Requires confirmation

- `rm` - File deletion
- `sudo` - Elevated privileges
- `kill` - Process termination
- `chmod` - Permission changes

## Agent Auto-Selection

Agents are automatically selected based on your query:

- **Research questions** → researcher agent
- **Python/ML coding** → developer agent
- **Financial analysis** → financial-analyst agent
- **Academic writing** → academic-writer agent
- **Presentations** → presentation-builder agent
- **Bank statements** → statement-processor agent

## Directory Structure

```
streamlined/.claude/
├── settings.json              # Universal config with all permissions
├── agents/
│   ├── researcher.md          # Claude-first research + OSINT agent
│   ├── developer.md           # Merged Python + ML agent
│   ├── financial-analyst.md   # Financial analysis
│   ├── academic-writer.md     # Academic writing
│   ├── presentation-builder.md # Presentations
│   └── statement-processor.md # Statement processing
├── commands/
│   ├── graham.md              # Talent evaluation
│   ├── deep-research.md       # Claude-first research protocol
│   └── process-statement.md   # Statement to CSV
├── skills/
│   └── tool-orchestration.md  # Research tool selection guidance
└── plugins/
    └── marketplaces/          # MCP plugin configs
```

## Confidence Scoring

Research outputs include confidence scores based on:

| Condition | Adjustment |
|-----------|-----------|
| Claude confident + external confirms | +10% |
| Perplexity + Firecrawl agree | +15% |
| Multiple WebSearch URLs corroborate | +10% |
| OpenRouter 3+ models consensus | +15% |
| Tools return contradictory info | -20% |
| Single tool, single source | -10% |

## Archived Setups

Previous specialized setups are preserved in the `archive/` directory:
- general_ai, code_ai, deep_research, ppt_builder
- osint_ai, science_ai, finance_ai, bookkeeping_ai, unified

These can be restored if needed using:
```bash
./switch-setup.sh --restore
```
