# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains a collection of specialized Claude Code configurations optimized for different professional workflows. Each setup includes pre-configured permissions, specialized agents, custom slash commands, and MCP server integrations designed for specific use cases.

**Repository:** https://github.com/maynard242/claude_code_setups

## Architecture

### Setup Structure

Each specialized setup follows a consistent directory structure:

```
<setup_name>/
├── .claude/
│   ├── settings.json        # Permissions, status line, MCP integrations
│   ├── agents/              # Specialized sub-agents (optional)
│   │   └── *.md            # Agent definitions with frontmatter
│   ├── commands/            # Slash commands (optional)
│   │   └── *.md            # Command prompts with frontmatter
│   ├── skills/              # Auto-activating skills (optional)
│   │   └── *.md            # Skill definitions
│   └── plugins/             # MCP server plugins (optional)
└── README.md                # Setup-specific documentation
```

### Available Setups

1. **general_ai/** - Multi-source research, document creation, talent evaluation
2. **code_ai/** - Python/ML development with PyTorch and type safety
3. **deep_research/** - Academic and market research with evidence-based analysis
4. **ppt_builder/** - PowerPoint presentation design and storytelling
5. **osint_ai/** - OSINT/investigative research and background checks
6. **science_ai/** - Scientific/academic writing with LaTeX support
7. **finance_ai/** - Financial analysis and investment research
8. **bookkeeping_ai/** - Bank statement processing and categorization

### Setup Switcher

The `switch-setup.sh` script automates setup installation and management:

**Interactive mode:**
```bash
./switch-setup.sh
```

**Direct installation:**
```bash
./switch-setup.sh <setup_name>
```

**Symlink (auto-updates):**
```bash
./switch-setup.sh --link <setup_name>
```

**Management commands:**
```bash
./switch-setup.sh --current   # Show active setup
./switch-setup.sh --backup    # Create timestamped backup
./switch-setup.sh --restore   # Restore from backup
./switch-setup.sh --list      # List available backups
```

The script validates input for security, creates automatic timestamped backups before switching, and supports both copy and symlink modes.

## Common Development Tasks

### Testing Setup Configurations

After creating or modifying a setup:

1. Validate `settings.json` syntax:
```bash
cat <setup_name>/.claude/settings.json | jq .
```

2. Check permissions structure:
```bash
cat <setup_name>/.claude/settings.json | jq .permissions
```

3. Test setup installation:
```bash
./switch-setup.sh --backup  # Backup current setup first
./switch-setup.sh <setup_name>
```

### Creating New Agents

Agent files use frontmatter for metadata:

```markdown
---
name: agent-name
description: Brief description for when to invoke this agent
model: sonnet  # or haiku, opus
color: blue    # Visual distinction in UI
---

Agent instructions and expertise...
```

Place in `<setup_name>/.claude/agents/<agent-name>.md`

### Creating New Slash Commands

Command files use frontmatter for metadata:

```markdown
---
description: Brief description of command functionality
---

Command instructions and expected output format...
```

Place in `<setup_name>/.claude/commands/<command-name>.md`

Access with `/command-name` in Claude Code.

### Settings.json Configuration

Key configuration sections:

**Permissions:**
```json
{
  "permissions": {
    "allow": ["WebSearch", "Bash(git:*)"],
    "ask": ["Bash(rm:*)", "Bash(sudo:*)"]
  }
}
```

**Status Line (custom command):**
```json
{
  "statusLine": {
    "type": "command",
    "command": "your_bash_command_here"
  }
}
```

**MCP Integration:**
```json
{
  "enabledPlugins": {
    "exa-mcp-server@exa-mcp-server": true,
    "document-skills@anthropic-agent-skills": true
  }
}
```

**Always Thinking Mode:**
```json
{
  "alwaysThinkingEnabled": true
}
```

## MCP Server Integration

Several setups integrate with MCP servers for enhanced functionality:

**Supported MCP servers:**
- **Exa** (exa-mcp-server): Neural search and code context
- **Firecrawl**: Web scraping and content extraction
- **Day One**: Journaling integration
- **n8n**: Workflow automation

MCP servers are configured in `~/.claude/settings.json` or Claude Desktop's `claude_desktop_config.json`.

## Key Design Patterns

### Permission Strategy

Each setup follows the principle of least privilege:
- **allow**: Tools that don't require user confirmation (e.g., git, npm, WebSearch)
- **ask**: Potentially destructive operations (e.g., rm, sudo, kill)

### Agent Specialization

Agents are designed for complex, multi-step domain-specific tasks:
- **web-researcher** (general_ai): Multi-tool research orchestration
- **python-expert** (code_ai): Type safety and modern Python patterns
- **ml-engineer** (code_ai): PyTorch, training loops, MLOps
- **researcher** (deep_research): Evidence-based analysis with source tiering
- **investigator** (osint_ai): OSINT with confidence scoring
- **academic-writer** (science_ai): Research papers and statistical reporting
- **financial-analyst** (finance_ai): Valuation and investment analysis
- **statement-processor** (bookkeeping_ai): Transaction extraction and categorization

### Command Philosophy

Slash commands encapsulate common, well-defined workflows:
- `/graham` - Talent evaluation framework (general_ai)
- `/deep-research` - Comprehensive research protocol (general_ai)
- `/process-statement` - PDF statement to CSV conversion (bookkeeping_ai)

## Notable Implementation Details

### Bookkeeping AI Validation Flow

The `/process-statement` command implements a rigorous validation workflow:
1. Extract statement totals from PDF metadata
2. Parse all transactions
3. Verify transaction count matches statement
4. Verify debit/credit totals match statement
5. Verify net change = closing balance - opening balance
6. Output single CSV without header line

### Setup Detection

The switch script detects current setup via:
1. **Primary**: `setupId` field in settings.json (recommended)
2. **Fallback**: Pattern matching in status line configuration
3. **Symlink**: Direct readlink resolution

### Status Line Patterns

**Git-aware** (most setups):
```bash
Shows: ➜ directory git:(branch) [dirty indicator]
```

**Python version** (code_ai):
```bash
Shows: Python 3.x.x + git info
```

## Contributing New Setups

When creating a new setup:

1. Create setup directory with `.claude/` structure
2. Define clear use case and target audience
3. Configure minimal necessary permissions
4. Create specialized agents for domain expertise
5. Add slash commands for common workflows
6. Write comprehensive README with examples
7. Test thoroughly before committing
8. Add setup to SETUPS list in switch-setup.sh

## File Locations

**User's active setup:** `~/.claude/`

**Repository setups:** `/Users/levi/data/Setups/claude_code_setups/<setup_name>/.claude/`

**Backups:** `~/.claude.backup.YYYYMMDD_HHMMSS/`

**Claude Desktop MCP config:** `~/Library/Application Support/Claude/claude_desktop_config.json`

## Version Control

This repository uses git. The main branch is `main`.

**Important:** When working on setups, be careful not to commit sensitive information like API keys. MCP server credentials should be configured locally, not in the repository.
