# Getting Started

Quick setup guide for the Claude Code configuration.

## Prerequisites

1. **Claude Code CLI installed**
   ```bash
   which claude
   ```
   If not installed: [docs.anthropic.com/en/docs/claude-code](https://docs.anthropic.com/en/docs/claude-code)

2. **Git installed**
   ```bash
   git --version
   ```

3. **Node.js** (for Perplexity MCP server)
   ```bash
   node --version  # v18 or higher
   ```

## Installation

### Step 1: Clone Repository

```bash
git clone https://github.com/maynard242/claude_code_setups.git ~/data/Setups/claude_code_setups
cd ~/data/Setups/claude_code_setups
```

### Step 2: Make Script Executable

```bash
chmod +x switch-setup.sh
```

### Step 3: Install Setup

```bash
# Copy setup to ~/.claude
./switch-setup.sh

# Or symlink for auto-updates when you git pull
./switch-setup.sh --link
```

### Step 4: Configure MCP Servers (Optional)

Add to `~/.zshrc` or `~/.bashrc`:

```bash
export PERPLEXITY_API_KEY="pplx-your-key"
export CRAWL4AI_URL="http://your-server:11235/mcp/sse"
export CRAWL4AI_TOKEN="your-token"
```

Reload shell:
```bash
source ~/.zshrc
```

### Step 5: Verify Installation

```bash
./switch-setup.sh --current
claude
```

## What You Get

### 6 Agents (auto-activate based on task)

| Agent | Use Case |
|-------|----------|
| researcher | Research, OSINT, fact-checking |
| developer | Python/ML development |
| financial-analyst | Financial analysis |
| academic-writer | Scientific writing |
| presentation-builder | PowerPoint design |
| statement-processor | Bank statement processing |

### 3 Commands

- `/graham` - Talent evaluation
- `/deep-research` - Comprehensive research
- `/process-statement` - PDF to CSV conversion

### MCP Servers

- **Crawl4AI** - Web scraping, screenshots, PDFs
- **Perplexity** - AI-powered search and research

## First Steps

Start Claude Code in your project:

```bash
cd ~/your-project
claude
```

Try these:

```
# Research (auto-activates researcher agent)
"Research the latest developments in quantum computing"

# Code (auto-activates developer agent)
"Write a Python function with type hints and tests"

# Commands
/graham
/deep-research "AI regulation"
```

## Setup Management

```bash
./switch-setup.sh              # Install
./switch-setup.sh --link       # Symlink
./switch-setup.sh --current    # Check status
./switch-setup.sh --restore    # Restore backup
```

## Troubleshooting

### Setup not loading

```bash
ls -la ~/.claude/
cat ~/.claude/settings.json | jq .
```

### Agents not found

```bash
ls ~/.claude/agents/
```

### MCP not working

```bash
echo $PERPLEXITY_API_KEY
cat ~/.claude.json | jq .mcpServers
```

### Permissions denied

```bash
cat ~/.claude/settings.json | jq .permissions
```

## Next Steps

- [Quick Reference](QUICK_REFERENCE.md) - Commands cheat sheet
- [MCP Setup](MCP_SETUP.md) - Configure MCP servers
- [Architecture](ARCHITECTURE.md) - How it works
- [Developer Guide](CLAUDE.md) - Create custom agents

## Getting Help

- Run `/help` in Claude Code
- Check [README.md](README.md)
- Open [GitHub issue](https://github.com/maynard242/claude_code_setups/issues)
