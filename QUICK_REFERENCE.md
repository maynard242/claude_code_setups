# Quick Reference

Fast reference for commands, agents, and permissions.

## Setup Management

```bash
./switch-setup.sh              # Install setup
./switch-setup.sh --link       # Symlink (auto-updates)
./switch-setup.sh --current    # Show current setup
./switch-setup.sh --restore    # Restore from backup
./switch-setup.sh --help       # Show all options
```

## Agents

Agents activate automatically based on your task.

| Agent | Triggers On | Key Features |
|-------|-------------|--------------|
| **researcher** | Research, OSINT, fact-checking | Claude-first methodology, confidence scoring, source tiers |
| **developer** | Python, ML, coding tasks | Type safety, testing, modern patterns, PyTorch |
| **financial-analyst** | Finance, valuation, investing | DCF, comparables, financial metrics |
| **academic-writer** | Papers, grants, science | IMRaD structure, statistical reporting, citations |
| **presentation-builder** | PowerPoint, slides | Storytelling, visual design, templates |
| **statement-processor** | Bank statements, transactions | PDF extraction, categorization, validation |

## Slash Commands

| Command | Purpose | Usage |
|---------|---------|-------|
| `/graham` | Talent evaluation | `/graham` then provide context |
| `/deep-research` | Comprehensive research | `/deep-research "topic"` |
| `/process-statement` | PDF to CSV | `/process-statement` then provide file |

## MCP Servers

| Server | Tools | Purpose |
|--------|-------|---------|
| **Crawl4AI** | md, html, screenshot, pdf, execute_js, crawl | Web scraping |
| **Perplexity** | ask, search, research, reason | AI-powered search |

## Tool Hierarchy

```
Claude → WebSearch → WebFetch → Perplexity → Crawl4AI
```

Use Claude's knowledge first, escalate as needed.

## Permissions

### Auto-Approved

```
WebSearch, WebFetch
mcp__crawl4ai, mcp__perplexity
git, npm, npx, node
python, python3, pip, pip3
pytest, mypy, ruff, black, poetry, uv
pdflatex, bibtex, pandoc, pdftotext, pdftk
ls, cat, grep, find, mkdir, cp, mv, curl, jq, wc, head, tail
```

### Requires Confirmation

```
rm, sudo, kill, chmod
```

## Environment Variables

```bash
# Required for MCP servers
export PERPLEXITY_API_KEY="pplx-your-key"
export CRAWL4AI_URL="http://your-server:11235/mcp/sse"
export CRAWL4AI_TOKEN="your-token"
```

## File Locations

```
~/.claude/                    # Active setup
~/.claude/settings.json       # Config
~/.claude/agents/             # Agent definitions
~/.claude/commands/           # Slash commands
~/.claude.json                # Global Claude config (MCP servers)
~/.claude.backup.*/           # Timestamped backups
```

## Common Tasks

### Check current setup
```bash
./switch-setup.sh --current
cat ~/.claude/settings.json | jq .setupId
```

### List agents
```bash
ls ~/.claude/agents/
```

### List commands
```bash
ls ~/.claude/commands/
```

### Validate JSON
```bash
cat ~/.claude/settings.json | jq .
```

### Check MCP config
```bash
cat ~/.claude.json | jq .mcpServers
```

## Status Line

Shows: `>>> directory git:(branch) *`

- `>>>` - Ready
- `directory` - Current folder
- `git:(branch)` - Git branch
- `*` - Uncommitted changes

## Confidence Scoring (Research)

| Level | Score | Meaning |
|-------|-------|---------|
| High | 90-100% | Multiple authoritative sources |
| Medium-High | 70-89% | Multiple sources, minor gaps |
| Medium | 50-69% | Limited sources |
| Low | 30-49% | Single source or unverified |
| Very Low | <30% | Unreliable or contradictory |

## Source Tiers (Research)

| Tier | Sources |
|------|---------|
| **1** | Peer-reviewed, government, SEC, court records |
| **2** | Reputable news, industry reports |
| **3** | Blogs, forums, social media (corroborate) |

## Troubleshooting

- [ ] Setup installed: `./switch-setup.sh --current`
- [ ] Files exist: `ls ~/.claude/`
- [ ] JSON valid: `cat ~/.claude/settings.json | jq .`
- [ ] MCP configured: `cat ~/.claude.json | jq .mcpServers`
- [ ] Env vars set: `echo $PERPLEXITY_API_KEY`

## Quick Links

- [README](README.md) - Overview
- [Getting Started](GETTING_STARTED.md) - Installation
- [MCP Setup](MCP_SETUP.md) - Configure MCP servers
- [Architecture](ARCHITECTURE.md) - How it works
- [Developer Guide](CLAUDE.md) - Customization
