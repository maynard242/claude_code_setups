# Streamlined Claude Code Setup

A universal Claude Code configuration that consolidates all capabilities into a single, powerful setup with 6 specialized agents, 3 slash commands, and integrated MCP servers for web scraping and AI-powered search.

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
| `/deep-research` | Conduct comprehensive multi-source research |
| `/process-statement` | Process bank/credit card statements to CSV |

### MCP Server Integrations

| Server | Description | Required Env Var |
|--------|-------------|------------------|
| **Firecrawl** | Web scraping and content extraction | `FIRECRAWL_API_KEY` |
| **Perplexity** | AI-powered search with Sonar Pro models | `PERPLEXITY_API_KEY` |

#### Perplexity MCP Tools

- `perplexity_search` - Direct web search with ranked results
- `perplexity_ask` - Conversational AI with real-time search (sonar-pro)
- `perplexity_research` - Deep research with sonar-deep-research model
- `perplexity_reason` - Advanced reasoning with sonar-reasoning-pro

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
# For Perplexity MCP (recommended)
export PERPLEXITY_API_KEY="your_perplexity_api_key"

# For Firecrawl MCP (recommended)
export FIRECRAWL_API_KEY="your_firecrawl_api_key"
```

Get API keys from:
- Perplexity: https://www.perplexity.ai/account/api/group
- Firecrawl: https://firecrawl.dev

## Permissions

### Auto-allowed (no confirmation)

- **Web**: WebSearch, WebFetch, Firecrawl MCP, Perplexity MCP
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
│   ├── researcher.md          # Merged research + OSINT agent
│   ├── developer.md           # Merged Python + ML agent
│   ├── financial-analyst.md   # Financial analysis
│   ├── academic-writer.md     # Academic writing
│   ├── presentation-builder.md # Presentations
│   └── statement-processor.md # Statement processing
├── commands/
│   ├── graham.md              # Talent evaluation
│   ├── deep-research.md       # Research protocol
│   └── process-statement.md   # Statement to CSV
└── plugins/
    └── marketplaces/          # MCP plugin configs
```

## Archived Setups

Previous specialized setups are preserved in the `archive/` directory:
- general_ai, code_ai, deep_research, ppt_builder
- osint_ai, science_ai, finance_ai, bookkeeping_ai, unified

These can be restored if needed using:
```bash
./switch-setup.sh --restore
```
