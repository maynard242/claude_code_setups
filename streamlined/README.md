# Streamlined Claude Code Setup

A universal Claude Code configuration with 6 specialized agents, 3 slash commands, and a Claude-first research methodology.

## Research Tool Hierarchy

| Tier | Tool | Use When |
|------|------|----------|
| **0** | Claude | Static knowledge, explanations, facts within training data |
| **1** | WebSearch | Find URLs, verify recency, discover sources |
| **2** | WebFetch | Simple HTML (Wikipedia, docs, government sites) |
| **3** | Perplexity | AI-synthesized current events with citations |
| **4** | Crawl4AI md | WebFetch failed, need cleaner extraction |
| **5** | Crawl4AI execute_js | JS-heavy sites (SPAs, React/Vue apps) |

**Key principle:** Always try Claude first. Skip external tools when Claude can answer confidently.

## Features

### 6 Agents

| Agent | Use For |
|-------|---------|
| **researcher** | Web/academic/market research, OSINT, fact-checking |
| **developer** | Python, ML/PyTorch, testing, type safety |
| **financial-analyst** | Stock analysis, DCF modeling, SEC filings |
| **academic-writer** | Research papers, grants, LaTeX |
| **presentation-builder** | Pitch decks, business reports |
| **statement-processor** | Bank statement → CSV |

### 3 Commands

| Command | Description |
|---------|-------------|
| `/graham` | Evaluate talent using Paul Graham's framework |
| `/deep-research` | Comprehensive multi-source research |
| `/process-statement` | Process bank/credit card statements |

## Installation

```bash
# Quick install
./switch-setup.sh

# Or symlink (auto-updates)
./switch-setup.sh --link
```

## Configuration

### Required: Perplexity API Key

```bash
# Add to ~/.zshrc or ~/.bashrc
export PERPLEXITY_API_KEY="your_key_here"
```

Get key: https://www.perplexity.ai/settings/api

### Optional: Crawl4AI

Crawl4AI should be available as an MCP server. If self-hosting:

```json
{
  "mcpServers": {
    "crawl4ai": {
      "command": "uvx",
      "args": ["crawl4ai-mcp"]
    }
  }
}
```

## Directory Structure

```
streamlined/.claude/
├── settings.json
├── agents/
│   ├── researcher.md
│   ├── developer.md
│   ├── financial-analyst.md
│   ├── academic-writer.md
│   ├── presentation-builder.md
│   └── statement-processor.md
└── commands/
    ├── graham.md
    ├── deep-research.md
    └── process-statement.md
```

## Permissions

**Auto-allowed:** WebSearch, WebFetch, Crawl4AI, Perplexity, git, npm, python, pip, pytest, LaTeX/PDF tools, mkdir, jq, wc

**Requires confirmation:** rm, sudo, kill, chmod, curl, cp, mv
