# Architecture Overview

How the Claude Code setup works internally.

## System Architecture

```
┌─────────────────────────────────────────────────┐
│                  Claude Code CLI                 │
│            (github.com/anthropics/claude-code)   │
└───────────────────────┬─────────────────────────┘
                        │ Reads configuration from
                        ▼
┌─────────────────────────────────────────────────┐
│              Active Setup (~/.claude/)            │
├─────────────────────────────────────────────────┤
│  settings.json     Permissions, MCP config       │
│  agents/*.md       6 specialized sub-agents      │
│  commands/*.md     3 slash commands              │
└───────────────────────┬─────────────────────────┘
                        │
              ┌─────────┴─────────┐
              ▼                   ▼
  ┌─────────────────┐   ┌──────────────────┐
  │   Crawl4AI MCP  │   │  Perplexity MCP  │
  │   (SSE, remote) │   │  (stdio, local)  │
  └─────────────────┘   └──────────────────┘
```

## Directory Structure

```
claude_code_setups/
├── streamlined/              # Active setup (source of truth)
│   ├── .claude/
│   │   ├── settings.json     # Permissions, MCP, status line
│   │   ├── agents/           # 6 specialized agents
│   │   └── commands/         # 3 slash commands
│   └── README.md
├── templates/                # CLAUDE.md template
├── switch-setup.sh           # Installer script
├── README.md                 # Main documentation
├── GETTING_STARTED.md        # Installation guide
├── QUICK_REFERENCE.md        # Cheat sheet
├── MCP_SETUP.md              # MCP configuration
├── ARCHITECTURE.md           # This file
├── SECURITY_REVIEW.md        # Security audit
├── CHANGELOG.md              # Version history
└── LICENSE                   # MIT
```

## Configuration Format

### settings.json

```json
{
  "permissions": {
    "allow": ["WebSearch", "Bash(git:*)"],
    "ask": ["Bash(rm:*)", "Bash(sudo:*)"]
  },
  "statusLine": {
    "type": "command",
    "command": "printf '>>> '; basename \"$PWD\""
  },
  "mcpServers": {
    "crawl4ai": { "type": "sse", "url": "${CRAWL4AI_URL}" },
    "perplexity": { "type": "stdio", "command": "npx", "args": [...] }
  }
}
```

### Agent Files (`agents/<name>.md`)

```markdown
---
name: agent-name
description: When to invoke this agent
model: opus
color: blue
---

Agent instructions...
```

- Frontmatter required: name, description
- Description determines automatic invocation
- Content is the agent's system prompt

### Command Files (`commands/<name>.md`)

```markdown
---
description: What this command does
---

Command instructions...
```

- Invoked explicitly with `/command-name`
- Content is appended to conversation context

## Flows

### Startup
1. User runs `claude`
2. CLI reads `~/.claude/settings.json`
3. Loads agents from `~/.claude/agents/`
4. Loads commands from `~/.claude/commands/`
5. Connects to MCP servers
6. Executes status line command
7. Ready for input

### Agent Invocation
1. User enters request
2. Claude Code matches request against agent descriptions
3. Loads matched agent as system prompt
4. Agent executes with full tool access
5. Returns structured response

### Permission Check
1. Claude Code wants to run a command
2. Checks `permissions.allow` - execute immediately if matched
3. Checks `permissions.ask` - prompt user if matched
4. If not in either list - denied

### Setup Installation
1. User runs `./switch-setup.sh`
2. Script backs up existing `~/.claude/` (timestamped)
3. Copies (or symlinks) `streamlined/.claude/` to `~/.claude/`
4. User restarts Claude Code

## Security Model

```
Permission Hierarchy:

1. Allow (permissions.allow)
   - Executes without confirmation
   - Safe commands: git, python, npm, WebSearch

2. Ask (permissions.ask)
   - Prompts user before execution
   - Destructive/sensitive: rm, sudo, kill, chmod, curl, cp, mv

3. Denied (not in either list)
   - Cannot be executed
```

## MCP Integration

| Server | Type | Transport | Purpose |
|--------|------|-----------|---------|
| Crawl4AI | Remote | SSE | Web scraping, screenshots, PDF, JS execution |
| Perplexity | Local | stdio (npx) | AI search, research, reasoning |

Credentials are configured via environment variables (`CRAWL4AI_URL`, `CRAWL4AI_TOKEN`, `PERPLEXITY_API_KEY`) and referenced in settings.json using `${VAR}` syntax.

## Design Decisions

**Single streamlined setup** over multiple specialized setups:
- Reduced cognitive overhead
- All agents available without switching
- Simpler maintenance

**Copy mode by default** over symlink:
- Stable, predictable behavior
- Won't break if repo has changes
- Symlink available for development via `--link`

**Agents (automatic)** vs **Commands (explicit)**:
- Agents: complex, domain-specific workflows triggered by task analysis
- Commands: well-defined, repeatable workflows the user explicitly invokes
