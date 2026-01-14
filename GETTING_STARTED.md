# Getting Started with Claude Code Setups

Welcome! This guide will walk you through setting up and using the specialized Claude Code configurations in this repository.

## What Are These Setups?

This repository contains 8 specialized Claude Code configurations, each optimized for different professional workflows:

- **general_ai** - Multi-source research and document creation
- **code_ai** - Python/ML development with type safety
- **deep_research** - Academic and market research
- **ppt_builder** - PowerPoint presentation design
- **osint_ai** - OSINT/investigative research
- **science_ai** - Scientific/academic writing with LaTeX
- **finance_ai** - Financial analysis and investment research
- **bookkeeping_ai** - Bank statement processing

Each setup includes:
- Pre-configured permissions for relevant tools
- Specialized AI agents for domain-specific tasks
- Custom slash commands for common workflows
- Optimized status line displays

## Prerequisites

Before you begin, ensure you have:

1. **Claude Code CLI installed**
   ```bash
   # Check if installed
   which claude
   ```
   If not installed, visit [https://claude.com/claude-code](https://claude.com/claude-code) for installation instructions.

2. **Git installed** (for cloning the repository)
   ```bash
   git --version
   ```

3. **Node.js installed** (optional, for MCP servers)
   ```bash
   node --version
   # Recommended: v18 or higher
   ```

4. **Basic terminal familiarity**
   - Running bash commands
   - Navigating directories
   - Managing files

## Installation

### Step 1: Clone the Repository

```bash
# Clone to your preferred location
git clone https://github.com/maynard242/claude_code_setups.git ~/data/Setups/claude_code_setups

# Navigate to the directory
cd ~/data/Setups/claude_code_setups
```

### Step 2: Make Scripts Executable

```bash
# Make the setup switcher executable
chmod +x switch-setup.sh zshrc-helper.sh
```

### Step 3: Choose Your First Setup

Not sure which setup to start with? Here's a quick guide:

| If you want to... | Use this setup |
|---|---|
| Do general research and document writing | **general_ai** |
| Write Python or ML code | **code_ai** |
| Conduct deep research with evidence analysis | **deep_research** |
| Create PowerPoint presentations | **ppt_builder** |
| Do investigative research/OSINT | **osint_ai** |
| Write scientific papers with LaTeX | **science_ai** |
| Analyze financial data and investments | **finance_ai** |
| Process bank statements | **bookkeeping_ai** |

**For most users, start with `general_ai`** - it's the most versatile setup.

### Step 4: Install Your First Setup

```bash
# Interactive installation (recommended for first-time users)
./switch-setup.sh

# Or install directly
./switch-setup.sh general_ai
```

The script will:
1. Create a backup of your current setup (if any) at `~/.claude.backup.YYYYMMDD_HHMMSS/`
2. Copy the selected setup to `~/.claude/`
3. Confirm the installation

**Note**: The installation creates a copy (not a symlink) by default. If you want the setup to auto-update when you pull changes from the repo, use `./switch-setup.sh --link general_ai`.

### Step 5: Verify Installation

```bash
# Check which setup is active
./switch-setup.sh --current

# Test Claude Code
claude
```

You should see your custom status line (e.g., `➜ directory git:(branch)` for general_ai).

## First Steps with Your Setup

### 1. Explore the Setup Features

Each setup has a README with detailed information:

```bash
# View setup documentation
cat general_ai/README.md
```

### 2. Try Basic Commands

Start a Claude Code session:

```bash
cd ~/your-project
claude
```

In the Claude Code session:

```
# For general_ai setup, try:
/graham  # Talent evaluation framework
/deep-research  # Comprehensive research protocol

# For bookkeeping_ai setup, try:
/process-statement  # Convert bank statement PDF to CSV
```

### 3. Test Specialized Agents

Agents are automatically invoked for relevant tasks. Try asking:

```
# In general_ai:
"Research the latest developments in quantum computing"

# In code_ai:
"Write a Python function to calculate fibonacci numbers with type hints"

# In deep_research:
"Conduct comprehensive research on the effectiveness of carbon taxes"
```

The appropriate specialized agent will automatically handle the task.

### 4. Check Permissions

Each setup has different permissions. Test what's allowed:

```bash
# In Claude Code:
git status  # Usually allowed
npm install  # Allowed in general_ai, code_ai
pip install  # Allowed in code_ai, science_ai
```

Commands that require confirmation (like `rm`, `sudo`) will prompt you first.

## Switching Between Setups

You can switch setups anytime:

```bash
# Interactive menu
./switch-setup.sh

# Direct switch
./switch-setup.sh code_ai

# Your previous setup is automatically backed up
```

## Optional: Configure MCP Servers

MCP (Model Context Protocol) servers enhance Claude Code with external tools like neural search and web scraping.

**Recommended setups with MCP:**
- general_ai (Exa, Firecrawl, Day One)
- deep_research (Exa, Firecrawl)
- osint_ai (Exa, Firecrawl)
- science_ai (Exa, Firecrawl)
- finance_ai (Exa, Firecrawl)

See [MCP_SETUP.md](MCP_SETUP.md) for detailed configuration instructions.

## Troubleshooting

### Setup doesn't switch

**Problem**: After running switch-setup.sh, Claude Code still shows old setup.

**Solution**:
1. Verify the setup was copied: `ls -la ~/.claude/`
2. Restart your terminal or Claude Code session
3. Check for errors: `./switch-setup.sh --current`

### Permissions errors

**Problem**: Claude Code says a command is not permitted.

**Solution**:
1. Check the setup's permissions: `cat ~/.claude/settings.json | jq .permissions`
2. If the command should be allowed, edit `~/.claude/settings.json`
3. Or switch to a setup with broader permissions (e.g., general_ai)

### Agent not found

**Problem**: Claude Code says an agent doesn't exist.

**Solution**:
1. Check if the agent file exists: `ls ~/.claude/agents/`
2. Verify the agent is listed in the setup's README
3. Re-install the setup: `./switch-setup.sh <setup_name>`

### Status line not showing

**Problem**: Status line is blank or shows errors.

**Solution**:
1. Check status line command: `cat ~/.claude/settings.json | jq .statusLine`
2. Test the command manually: Run the command shown in the `command` field
3. If using git-aware status line, ensure you're in a git repository

### MCP servers not working

**Problem**: MCP servers don't respond or show errors.

**Solution**:
1. Verify MCP config exists: `cat ~/Library/Application\ Support/Claude/claude_desktop_config.json`
2. Check API keys are set correctly
3. Ensure Node.js is installed: `node --version`
4. See [MCP_SETUP.md](MCP_SETUP.md) for detailed troubleshooting

## Next Steps

Once you're comfortable with your first setup:

1. **Explore other setups** - Try setups for different workflows
2. **Customize your setup** - Edit `~/.claude/settings.json` to adjust permissions
3. **Create custom agents** - Add your own specialized agents (see CLAUDE.md)
4. **Configure MCP servers** - Enable advanced features (see MCP_SETUP.md)
5. **Share your experience** - Contribute improvements via GitHub issues/PRs

## Additional Resources

- [README.md](README.md) - Complete documentation for all setups
- [QUICK_REFERENCE.md](QUICK_REFERENCE.md) - Cheat sheet for common commands
- [ARCHITECTURE.md](ARCHITECTURE.md) - Deep dive into how setups work
- [MCP_SETUP.md](MCP_SETUP.md) - MCP server configuration guide
- [CLAUDE.md](CLAUDE.md) - Development guide for creating custom setups
- [CHANGELOG.md](CHANGELOG.md) - Version history and updates

## Getting Help

- **Repository Issues**: [GitHub Issues](https://github.com/maynard242/claude_code_setups/issues)
- **Claude Code Help**: Run `/help` in Claude Code or visit [https://claude.com/code/docs](https://claude.com/code/docs)
- **Setup Documentation**: Each setup has its own README with detailed examples

## Welcome!

You're all set! Start with simple tasks to get familiar with your setup, then gradually explore more advanced features. Each setup is designed to make you more productive in its specific domain.

Happy coding with Claude!
