# Quick Reference Guide

Fast reference for Claude Code setups, commands, agents, and permissions.

## Setup Comparison Table

| Setup | Best For | Key Permissions | Agents | Commands | MCP Servers |
|---|---|---|---|---|---|
| **general_ai** | Research, documents, general tasks | Web, git, npm, python | web-researcher | /graham, /deep-research | Exa, Firecrawl, Day One |
| **code_ai** | Python/ML development | Python tools, git | python-expert, ml-engineer | - | Optional: Exa |
| **deep_research** | Academic/market research | Web, git, read-only | researcher | - | Exa, Firecrawl |
| **ppt_builder** | PowerPoint creation | Web, python, git | presentation-builder | - | - |
| **osint_ai** | OSINT investigations | Web, git, read-only | investigator | - | Exa, Firecrawl |
| **science_ai** | Scientific writing | Web, LaTeX, python, git | academic-writer | - | Exa, Firecrawl |
| **finance_ai** | Financial analysis | Web, python, git | financial-analyst | - | Exa, Firecrawl |
| **bookkeeping_ai** | Statement processing | Python, PDF tools, git | statement-processor | /process-statement | - |

## Quick Commands

### Setup Management

```bash
# Switch setups (interactive)
./switch-setup.sh

# Install specific setup
./switch-setup.sh <setup_name>

# Install as symlink (auto-updates)
./switch-setup.sh --link <setup_name>

# Check current setup
./switch-setup.sh --current

# Create backup
./switch-setup.sh --backup

# Restore from backup
./switch-setup.sh --restore

# List backups
./switch-setup.sh --list
```

### Setup Information

```bash
# View setup documentation
cat <setup_name>/README.md

# Check permissions
cat ~/.claude/settings.json | jq .permissions

# List agents
ls ~/.claude/agents/

# List commands
ls ~/.claude/commands/

# Check status line config
cat ~/.claude/settings.json | jq .statusLine
```

## Agents Quick Reference

Agents are automatically invoked for relevant tasks.

| Agent | Setup | When to Use | Key Features |
|---|---|---|---|
| **web-researcher** | general_ai | Multi-source research | Cross-reference, source evaluation, synthesis |
| **python-expert** | code_ai | Python development | Type safety, modern patterns, testing |
| **ml-engineer** | code_ai | ML/PyTorch work | Training loops, MLOps, optimization |
| **researcher** | deep_research | Evidence-based research | 4-tier source credibility, confidence scoring |
| **investigator** | osint_ai | Background research, OSINT | Red flag identification, confidence levels |
| **academic-writer** | science_ai | Research papers, grants | Scientific style, statistical reporting |
| **financial-analyst** | finance_ai | Valuation, investment analysis | Financial metrics, DCF, comparables |
| **statement-processor** | bookkeeping_ai | Transaction extraction | PDF parsing, categorization, validation |
| **presentation-builder** | ppt_builder | PowerPoint design | Storytelling, visual communication |

## Slash Commands Quick Reference

Commands are explicitly invoked with `/command-name`.

| Command | Setup | Usage | Purpose |
|---|---|---|---|
| **/graham** | general_ai | `/graham` | Talent evaluation using Paul Graham's framework |
| **/deep-research** | general_ai | `/deep-research` | Comprehensive multi-source research protocol |
| **/process-statement** | bookkeeping_ai | `/process-statement` | Convert bank statement PDF to categorized CSV |

## Permission Levels Explained

### Always Allowed (No Prompt)
These commands execute immediately without user confirmation:

- **WebSearch** - Web search functionality
- **WebFetch** - Fetch content from URLs
- **Bash(git:\*)** - All git commands
- **Bash(ls:\*)** - List directory contents
- **Bash(cat:\*)** - Read file contents
- **Bash(grep:\*)** - Search file contents
- **Bash(find:\*)** - Find files

### Setup-Specific Allowed Commands

| Setup | Additional Allowed |
|---|---|
| **general_ai** | npm, node, python, pip |
| **code_ai** | python, pip, pytest, mypy, ruff, black, poetry, uv |
| **science_ai** | python, pdflatex, bibtex, pandoc |
| **bookkeeping_ai** | python, pdftotext, pdftk |
| **finance_ai** | python |
| **ppt_builder** | python |

### Always Ask (Requires Confirmation)
These commands always prompt for user approval:

- **Bash(rm:\*)** - Delete files (destructive)
- **Bash(sudo:\*)** - Run as superuser (security risk)
- **Bash(kill:\*)** - Kill processes
- **Bash(chmod:\*)** - Change file permissions

## Status Line Indicators

Each setup has a unique status line:

```bash
# general_ai
➜ directory git:(branch) ✗

# code_ai
Python 3.12.1 ➜ directory git:(branch)

# deep_research
🔬 research mode ➜ directory

# ppt_builder
📊 presentation mode ➜ directory

# osint_ai
🔍 OSINT mode ➜ directory

# science_ai
🔬 science mode ➜ directory

# finance_ai
💰 finance mode ➜ directory

# bookkeeping_ai
💳 bookkeeping mode ➜ directory
```

**Status line symbols:**
- `➜` - Ready for input
- `git:(branch)` - Current git branch
- `✗` - Uncommitted changes (dirty)
- No `✗` - Clean working directory

## MCP Servers by Setup

| MCP Server | Purpose | Setups Using It |
|---|---|---|
| **Exa** | Neural search, code context | general_ai, deep_research, osint_ai, science_ai, finance_ai |
| **Firecrawl** | Web scraping, content extraction | general_ai, deep_research, osint_ai, science_ai, finance_ai |
| **Day One** | Journaling integration | general_ai |

See [MCP_SETUP.md](MCP_SETUP.md) for configuration instructions.

## Common Workflows

### Switch to Different Setup
```bash
# From your terminal:
cd ~/data/Setups/claude_code_setups
./switch-setup.sh code_ai
# Then start Claude Code in your project
cd ~/your-project
claude
```

### Check What's Installed
```bash
# Show current setup
./switch-setup.sh --current

# Show all agents
ls -1 ~/.claude/agents/

# Show all commands
ls -1 ~/.claude/commands/
```

### Backup Before Experimenting
```bash
# Create backup
./switch-setup.sh --backup

# Experiment with different setup
./switch-setup.sh science_ai

# If you want to revert:
./switch-setup.sh --restore
```

### Edit Permissions
```bash
# Edit settings file
nano ~/.claude/settings.json

# Or use your preferred editor
code ~/.claude/settings.json

# Verify JSON is valid
cat ~/.claude/settings.json | jq .
```

## Configuration File Locations

```
~/.claude/                            # Active setup
~/.claude/settings.json              # Main config
~/.claude/agents/                    # Specialized agents
~/.claude/commands/                  # Slash commands
~/.claude.backup.YYYYMMDD_HHMMSS/   # Timestamped backups

# Repository
~/data/Setups/claude_code_setups/   # Setup repository
~/data/Setups/claude_code_setups/<setup>/.claude/  # Setup configs

# MCP Configuration (external)
~/Library/Application Support/Claude/claude_desktop_config.json
```

## Validation & Testing

```bash
# Validate settings.json
cat ~/.claude/settings.json | jq .

# Check agent file format
head ~/.claude/agents/researcher.md

# Test command file format
head ~/.claude/commands/graham.md

# Verify git status (should be clean)
cd ~/data/Setups/claude_code_setups && git status

# Test MCP servers (if configured)
# In Claude Code: try a task requiring MCP (e.g., web search)
```

## Troubleshooting Checklist

- [ ] Check setup is installed: `./switch-setup.sh --current`
- [ ] Verify files exist: `ls ~/.claude/`
- [ ] Validate JSON: `cat ~/.claude/settings.json | jq .`
- [ ] Check permissions: `jq .permissions ~/.claude/settings.json`
- [ ] Restart terminal/Claude Code
- [ ] Review setup README: `cat <setup>/README.md`
- [ ] Check backups: `./switch-setup.sh --list`
- [ ] Verify git repo clean: `git status`

## Quick Tips

1. **Start with general_ai** - Most versatile for beginners
2. **Use symlinks for auto-updates** - `--link` flag keeps setup current
3. **Backups are automatic** - Every switch creates a timestamped backup
4. **Permissions are cumulative** - More specific rules override general ones
5. **Agents activate automatically** - No need to invoke them explicitly
6. **Commands need /** prefix - Slash commands like `/graham`
7. **Status line is customizable** - Edit the bash command in settings.json
8. **MCP servers are optional** - Setups work fine without them

## Example Session

```bash
# 1. Navigate to setup directory
cd ~/data/Setups/claude_code_setups

# 2. Switch to research setup
./switch-setup.sh deep_research

# 3. Go to your project
cd ~/my-research-project

# 4. Start Claude Code
claude

# 5. In Claude Code:
"Research the economic impact of renewable energy adoption"
# The 'researcher' agent will automatically handle this with:
# - Multi-source research
# - Evidence-based analysis
# - Source credibility tiers
# - Confidence scoring

# 6. When done, exit
exit
```

## Learn More

- [GETTING_STARTED.md](GETTING_STARTED.md) - Step-by-step setup guide
- [ARCHITECTURE.md](ARCHITECTURE.md) - How setups work internally
- [MCP_SETUP.md](MCP_SETUP.md) - Configure MCP servers
- [README.md](README.md) - Complete documentation
- [CLAUDE.md](CLAUDE.md) - Developer guide for customization

---

**Bookmark this page for quick reference!**
