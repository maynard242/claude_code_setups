# CLAUDE.md

Developer guide for Claude Code when working with this repository.

## Repository Overview

This repository contains a Claude Code configuration with specialized agents, custom commands, and MCP server integrations.

**Repository:** https://github.com/maynard242/claude_code_setups

## Structure

```
claude_code_setups/
├── streamlined/              # Active setup
│   └── .claude/
│       ├── settings.json     # Permissions, MCP config
│       ├── agents/           # 6 specialized agents
│       ├── commands/         # 3 slash commands
│       └── skills/           # Auto-activating skills
├── templates/                # Template files
├── switch-setup.sh           # Setup installer
├── README.md                 # Main documentation
├── GETTING_STARTED.md        # Installation guide
├── QUICK_REFERENCE.md        # Cheat sheet
├── MCP_SETUP.md              # MCP server configuration
├── ARCHITECTURE.md           # System architecture
└── CHANGELOG.md              # Version history
```

## Setup Components

### settings.json

```json
{
  "permissions": {
    "allow": ["WebSearch", "Bash(git:*)"],
    "ask": ["Bash(rm:*)", "Bash(sudo:*)", "Bash(curl:*)"]
  },
  "statusLine": {
    "type": "command",
    "command": "bash_command_here"
  },
  "mcpServers": {
    "server_name": { ... }
  }
}
```

### Agent Files

Location: `streamlined/.claude/agents/<agent-name>.md`

```markdown
---
name: agent-name
description: When to invoke this agent
model: sonnet  # or haiku, opus
color: blue
---

Agent instructions...
```

### Command Files

Location: `streamlined/.claude/commands/<command-name>.md`

```markdown
---
description: What this command does
---

Command instructions...
```

Invoke with `/command-name` in Claude Code.

## Current Agents

| Agent | Purpose |
|-------|---------|
| researcher | Research, OSINT, fact-checking with Claude-first methodology |
| developer | Python/ML development with type safety |
| financial-analyst | Financial analysis and valuation |
| academic-writer | Scientific writing and papers |
| presentation-builder | PowerPoint design |
| statement-processor | Bank statement processing |

## Current Commands

| Command | Purpose |
|---------|---------|
| /graham | Talent evaluation framework |
| /deep-research | Comprehensive research protocol |
| /process-statement | PDF statement to CSV |

## MCP Servers

Configured in `~/.claude.json` (global) or `settings.json` (project-level):

| Server | Type | Purpose |
|--------|------|---------|
| Crawl4AI | SSE | Web scraping, screenshots, PDFs |
| Perplexity | stdio | AI-powered search and research |

Environment variables:
- `PERPLEXITY_API_KEY`
- `CRAWL4AI_URL`
- `CRAWL4AI_TOKEN`

## Common Tasks

### Validate Configuration

```bash
cat streamlined/.claude/settings.json | jq .
```

### Check Permissions

```bash
cat streamlined/.claude/settings.json | jq .permissions
```

### Test Installation

```bash
./switch-setup.sh --current
```

### Creating a New Agent

1. Create file: `streamlined/.claude/agents/my-agent.md`
2. Add frontmatter (name, description, model, color)
3. Add agent instructions
4. Test by asking Claude a relevant question

### Creating a New Command

1. Create file: `streamlined/.claude/commands/my-command.md`
2. Add frontmatter (description)
3. Add command instructions
4. Test with `/my-command` in Claude Code

## File Locations

| Path | Purpose |
|------|---------|
| `~/.claude/` | User's active setup |
| `~/.claude.json` | Global Claude config (MCP servers) |
| `~/.claude.backup.*` | Timestamped backups |
| `streamlined/.claude/` | Repository setup source |

## Version Control

- Main branch: `main`
- Never commit API keys or credentials
- MCP credentials configured locally via environment variables

## Switch Script

```bash
./switch-setup.sh              # Install (copy)
./switch-setup.sh --link       # Install (symlink)
./switch-setup.sh --current    # Show current
./switch-setup.sh --restore    # Restore backup
./switch-setup.sh --help       # Help
```

