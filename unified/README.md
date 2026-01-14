# Unified Setup - All-in-One Claude Code Configuration

The most comprehensive Claude Code setup combining all specialized agents and commands from across the repository. Perfect for users who want maximum flexibility without switching between setups.

## 🎯 Overview

The **unified** setup is a powerhouse configuration that includes:
- **All 9 specialized agents** - Automatically invoked based on your task
- **All 3 slash commands** - Explicitly called when needed
- **Comprehensive permissions** - Tools for research, development, and analysis
- **Zero manual configuration** - Agents work automatically out of the box

## ✨ What Makes This Special

Unlike specialized setups that focus on specific workflows, the unified setup gives you **everything at once**:

### Automatic Agent Invocation
Agents are **automatically selected by Claude Code** based on your request. You don't need to manually choose or configure them - just ask naturally:

- Ask "Research quantum computing" → **web-researcher** agent activates
- Ask "Write a Python ML model" → **python-expert** or **ml-engineer** activates
- Ask "Analyze this financial statement" → **financial-analyst** activates
- Ask "Write a research paper intro" → **academic-writer** activates

**No setup required. No manual selection. It just works.**

## 📦 What's Included

### 🤖 All 9 Agents (Automatic)

These agents are invoked automatically when Claude Code detects a matching task:

| Agent | Automatically Invoked For | Key Capabilities |
|---|---|---|
| **web-researcher** | Multi-source research tasks | Cross-referencing, source evaluation, synthesis |
| **python-expert** | Python development | Type safety, modern patterns, testing |
| **ml-engineer** | Machine learning tasks | PyTorch, training loops, MLOps |
| **researcher** | Evidence-based research | 4-tier source credibility, academic research |
| **investigator** | OSINT/background research | Red flag identification, confidence scoring |
| **academic-writer** | Scientific writing | Research papers, grants, statistical reporting |
| **financial-analyst** | Financial analysis | Valuation models, investment research |
| **statement-processor** | Transaction processing | PDF extraction, categorization |
| **presentation-builder** | Presentation creation | PowerPoint design, storytelling |

**Important**: You never need to explicitly call these agents. Just describe your task naturally, and Claude Code will automatically use the right agent(s).

### 🔧 All 3 Commands (Manual)

These commands are explicitly invoked with `/command-name`:

| Command | Invocation | Purpose |
|---|---|---|
| **/graham** | `/graham` | Talent evaluation using Paul Graham's framework |
| **/deep-research** | `/deep-research` | Comprehensive multi-source research protocol |
| **/process-statement** | `/process-statement` | Bank statement PDF to categorized CSV conversion |

**Note**: Commands require explicit invocation with the `/` prefix.

### 🔐 Comprehensive Permissions

Pre-configured and ready to use:

**Web & Research:**
- WebSearch, WebFetch

**Development:**
- git, npm, node
- python, pip, pytest, mypy, ruff, black, poetry, uv

**Scientific:**
- pdflatex, bibtex, pandoc

**Data Processing:**
- pdftotext, pdftk

**File Operations:**
- ls, cat, grep, find, mkdir, cp, mv

**Requires Confirmation:**
- rm, sudo, kill, chmod (destructive operations)

### 📊 Smart Status Line

Git-aware status line showing:
```
➜ directory git:(branch) ✗
```
- Current directory name
- Git branch (if in repo)
- Dirty indicator (✗) for uncommitted changes

## 🚀 Installation

### Quick Install

```bash
# Using setup switcher (recommended)
cd ~/data/Setups/claude_code_setups
./switch-setup.sh unified

# Manual install
cp -r ~/data/Setups/claude_code_setups/unified/.claude ~/
```

### Verify Installation

```bash
# Check setup is active
cd ~/data/Setups/claude_code_setups
./switch-setup.sh --current

# Should show: "unified"
```

## 📖 How to Use

### Agents Work Automatically

Just start Claude Code and ask naturally. The right agent will be invoked automatically:

```bash
cd ~/your-project
claude
```

**Example conversations:**

```
You: "Research the latest developments in quantum computing"
# web-researcher agent automatically activates
# Performs multi-source research with citations

You: "Write a Python function to train a neural network with PyTorch"
# ml-engineer agent automatically activates
# Creates training loop with best practices

You: "Analyze Apple's latest financial statements"
# financial-analyst agent automatically activates
# Performs financial analysis with metrics

You: "Write an introduction for a research paper on climate change"
# academic-writer agent automatically activates
# Creates academic-style content with proper citations
```

**You never need to say "use the X agent" or configure anything. It's automatic.**

### Commands Need Explicit Invocation

For specialized workflows, use slash commands:

```
You: /deep-research
# Activates comprehensive research protocol

You: /graham
# Activates talent evaluation framework

You: /process-statement
# Activates bank statement processing workflow
```

## 🎨 Use Cases

Perfect for users who:

- **Work across multiple domains** - Research, coding, analysis, writing
- **Want maximum flexibility** - Don't want to switch setups constantly
- **Need all tools available** - Web research, Python dev, LaTeX, PDF processing
- **Value convenience** - One setup for everything
- **Trust automatic selection** - Let Claude Code choose the right agent

## 🆚 When to Use Specialized vs Unified

| Scenario | Recommendation |
|---|---|
| **Working on a focused task** (e.g., only Python dev) | Use specialized setup (code_ai) |
| **Minimal permissions for security** | Use specialized setup |
| **Working across multiple domains** | Use unified setup |
| **Don't want to switch setups** | Use unified setup |
| **Need all capabilities available** | Use unified setup |
| **Learning/exploring Claude Code** | Use unified setup |

## 🔧 Customization

### Add More Agents

Simply add new `.md` files to `~/.claude/agents/`:

```markdown
---
name: my-custom-agent
description: When to invoke this agent
model: sonnet
color: blue
---

Agent instructions here...
```

Claude Code will automatically detect and use it.

### Add More Commands

Add new `.md` files to `~/.claude/commands/`:

```markdown
---
description: What this command does
---

Command instructions here...
```

Invoke with `/my-custom-command`.

### Adjust Permissions

Edit `~/.claude/settings.json`:

```json
{
  "permissions": {
    "allow": ["your-new-command"],
    "ask": ["dangerous-command"]
  }
}
```

## ⚡ Performance Notes

**Startup:** Slightly longer than specialized setups (loads all 9 agents)
**Runtime:** No performance difference once running
**Memory:** ~50KB additional memory for agent files (negligible)

**Recommendation:** The convenience far outweighs the minimal startup overhead.

## 🔐 Security

All destructive operations require confirmation:
- `rm` - File deletion
- `sudo` - Superuser commands
- `kill` - Process termination
- `chmod` - Permission changes

**Principle of Least Privilege:** Even with comprehensive permissions, dangerous operations require explicit approval.

## 💡 Pro Tips

1. **Let Claude Code choose** - Don't try to specify which agent to use; just describe your task naturally
2. **Combine agents** - Claude Code can use multiple agents in one conversation
3. **Use commands for workflows** - `/deep-research` is better than asking "do deep research"
4. **Customize over time** - Add agents and commands as your needs evolve
5. **Trust the automation** - Agent selection is intelligent and context-aware

## 🎓 Understanding Agent vs Command

**Agents (Automatic):**
- Located in `~/.claude/agents/*.md`
- Invoked automatically by Claude Code based on task analysis
- Used for: Complex, domain-specific tasks requiring specialized expertise
- Example: "Research X" → web-researcher agent activates

**Commands (Manual):**
- Located in `~/.claude/commands/*.md`
- Invoked explicitly with `/command-name`
- Used for: Well-defined workflows you want to explicitly trigger
- Example: `/deep-research` → runs comprehensive research protocol

**Both are pre-configured and ready to use. No manual setup required.**

## 📚 Additional Resources

- [GETTING_STARTED.md](../GETTING_STARTED.md) - Installation guide
- [QUICK_REFERENCE.md](../QUICK_REFERENCE.md) - Command cheat sheet
- [ARCHITECTURE.md](../ARCHITECTURE.md) - How agents work internally
- [MCP_SETUP.md](../MCP_SETUP.md) - Optional MCP server setup
- [CLAUDE.md](../CLAUDE.md) - Create custom agents and commands

## 🤝 Related Setups

If the unified setup is too broad, try these focused alternatives:

- **general_ai** - Research and documents (lighter weight)
- **code_ai** - Python/ML only
- **deep_research** - Academic research only
- **science_ai** - Scientific writing only
- **finance_ai** - Financial analysis only

## ⚙️ Configuration Details

**Setup ID:** `unified`
**Model:** Sonnet (default, configurable)
**Always Thinking:** Enabled
**Agents:** 9 (all specialized agents)
**Commands:** 3 (/graham, /deep-research, /process-statement)

## 🎉 Summary

The unified setup gives you:
- ✅ **All agents** - Automatically invoked, no configuration needed
- ✅ **All commands** - Ready to use with `/command-name`
- ✅ **All permissions** - Comprehensive but secure
- ✅ **Zero setup** - Install and start using immediately
- ✅ **Maximum flexibility** - One setup for all workflows

**Just install, ask naturally, and let Claude Code handle the rest.**

---

**Version:** 2.2
**Last Updated:** 2026-01-14
**Recommended For:** Multi-domain work, maximum flexibility, convenience

Happy coding with the unified setup! 🚀
