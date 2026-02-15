# Claude Code Setup

A production-ready Claude Code configuration with specialized agents, custom commands, and MCP server integrations.

## Quick Start

```bash
# Clone the repository
git clone https://github.com/maynard242/claude_code_setups.git
cd claude_code_setups

# Install the setup
./switch-setup.sh

# Or use symlink for auto-updates
./switch-setup.sh --link
```

## What's Included

### 6 Specialized Agents

Agents activate automatically based on your task - no manual configuration needed.

| Agent | Purpose |
|-------|---------|
| **researcher** | Web/academic/market research, OSINT investigations, fact-checking |
| **developer** | Python/ML development with type safety, testing, modern patterns |
| **financial-analyst** | Financial analysis, valuation modeling, investment research |
| **academic-writer** | Scientific writing, research papers, grants, statistical reporting |
| **presentation-builder** | PowerPoint design, storytelling, visual communication |
| **statement-processor** | Bank/credit card statement processing, transaction categorization |

### 3 Slash Commands

| Command | Purpose |
|---------|---------|
| `/graham` | Talent evaluation using Paul Graham's framework |
| `/deep-research` | Comprehensive multi-source research protocol |
| `/process-statement` | Convert bank statement PDF to categorized CSV |

### MCP Servers

| Server | Purpose |
|--------|---------|
| **Crawl4AI** | Web crawling, scraping, screenshots, PDF generation |
| **Perplexity** | AI-powered web search, deep research, reasoning |

### Tool Hierarchy

The setup follows a Claude-first methodology:

```
Claude → WebSearch → WebFetch → Perplexity → Crawl4AI
```

Use Claude's knowledge first, then escalate to external tools as needed.

## Documentation

- **[Getting Started](GETTING_STARTED.md)** - Installation walkthrough
- **[Quick Reference](QUICK_REFERENCE.md)** - Commands and agents cheat sheet
- **[MCP Setup](MCP_SETUP.md)** - Configure Crawl4AI and Perplexity
- **[Architecture](ARCHITECTURE.md)** - How the setup works internally
- **[Developer Guide](CLAUDE.md)** - Create custom agents and commands

## Setup Management

```bash
./switch-setup.sh              # Install setup
./switch-setup.sh --link       # Symlink (auto-updates)
./switch-setup.sh --current    # Show current setup
./switch-setup.sh --restore    # Restore from backup
./switch-setup.sh --help       # Show all options
```

## Environment Variables

Required for MCP servers:

```bash
# Add to ~/.zshrc or ~/.bashrc
export PERPLEXITY_API_KEY="pplx-your-key"
export CRAWL4AI_URL="http://your-server:11235/mcp/sse"
export CRAWL4AI_TOKEN="your-token"
```

## Permissions

**Auto-approved tools:**
- WebSearch, WebFetch, MCP servers (Crawl4AI, Perplexity)
- git, npm, npx, node
- python, pip, pytest, mypy, ruff, black, poetry, uv
- pdflatex, bibtex, pandoc, pdftotext, pdftk
- mkdir, jq, wc

**Requires confirmation:**
- rm, sudo, kill, chmod, curl, cp, mv

## Example Usage

```bash
# Start Claude Code in your project
cd ~/your-project
claude

# In Claude Code:
"Research the latest developments in quantum computing"
# → researcher agent activates automatically

"Write a Python function with type hints and tests"
# → developer agent activates automatically

/graham
# → Talent evaluation command

/deep-research "AI regulation trends"
# → Comprehensive research protocol
```

## File Structure

```
~/.claude/
├── settings.json           # Permissions, MCP config
├── agents/                 # Specialized agents
│   ├── researcher.md
│   ├── developer.md
│   ├── financial-analyst.md
│   ├── academic-writer.md
│   ├── presentation-builder.md
│   └── statement-processor.md
└── commands/               # Slash commands
    ├── graham.md
    ├── deep-research.md
    └── process-statement.md
```

## Customization

### Add a New Agent

Create `~/.claude/agents/my-agent.md`:

```markdown
---
name: my-agent
description: Brief description for when to invoke
model: sonnet
color: blue
---

Agent instructions...
```

### Add a New Command

Create `~/.claude/commands/my-command.md`:

```markdown
---
description: What this command does
---

Command instructions...
```

Use with `/my-command` in Claude Code.

## Troubleshooting

### Setup not loading
```bash
ls -la ~/.claude/
cat ~/.claude/settings.json | jq .
```

### MCP servers not working
```bash
cat ~/.claude/settings.json | jq .mcpServers
echo $PERPLEXITY_API_KEY
```

### Permissions issues
```bash
cat ~/.claude/settings.json | jq .permissions
```

## Resources

- [Claude Code Docs](https://docs.anthropic.com/en/docs/claude-code)
- [MCP Protocol](https://modelcontextprotocol.io)
- [Crawl4AI](https://github.com/unclecode/crawl4ai)
- [Perplexity API](https://docs.perplexity.ai)

## License

MIT License - See [LICENSE](LICENSE)

---

**Version**: 2.3
**Last Updated**: 2026-01-23
**Maintained By**: [maynard242](https://github.com/maynard242)
