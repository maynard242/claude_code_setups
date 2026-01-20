# Claude Code Configuration Guide

This document explains how your Claude Code setup is organized and when to use universal vs project-specific configurations.

## Directory Structure

```
~/.claude/                              # Universal configuration (applies everywhere)
├── README.md                           # This file
├── settings.json                       # Global settings and permissions
├── agents/
│   └── web-researcher.md              # Universal research agent (Exa + Firecrawl)
├── commands/
│   └── graham.md                      # Universal talent evaluation command
├── plugins/                            # Plugin management
│   ├── installed_plugins.json
│   └── marketplaces/
├── projects/                           # Per-project session data (auto-managed)
├── .credentials.json                   # API credentials
├── history.jsonl                       # Command history
└── todos/                             # Task tracking

PROJECT/.claude/                        # Project-specific overrides (rare)
├── settings.local.json                 # Project permission overrides
├── agents/                            # Project-only agents (rare)
└── commands/                          # Project-only commands (rare)

PROJECT/CLAUDE.md                       # Project context (NOT configuration)
```

## Configuration Philosophy

### Universal (Global) Configurations

**Location:** `~/.claude/`

**What goes here:**
- Commands used across multiple projects (`/graham`)
- General-purpose agents (`web-researcher`)
- Default permissions for common tools
- Plugin management
- API credentials

**Examples:**
- Research workflows
- Talent evaluation
- Documentation generation
- Code review patterns
- General development tools

### Project-Specific Configurations

**Location:** `PROJECT/.claude/`

**What goes here:**
- Permission **overrides** (add restrictions or special permissions)
- Project-specific agents (when truly needed)
- Project-specific commands (rarely needed)

**When to create project-specific configs:**
- Need more restrictive permissions than global
- Need additional permissions not in global
- Project requires specialized agents with unique tools
- Project has domain-specific workflows

**Default approach:** Most projects don't need `.claude/` directory at all!

### Project Context Files

**Location:** `PROJECT/CLAUDE.md`

**What goes here:**
- Project architecture and structure
- Setup and installation instructions
- Dependencies and prerequisites
- Testing procedures
- Gotchas and quirks specific to this project
- API endpoints and documentation

**What does NOT go here:**
- Tool usage instructions (belongs in agents)
- Universal workflows (belongs in commands)
- Permission settings (belongs in settings.json)
- Generic templates (remove boilerplate)

## Current Setup

### Global Permissions

Your global permissions are **permissive** by default:

**Allowed automatically:**
- WebSearch
- Common dev tools: git, gh, npm, pip, python, node, docker, etc.
- All MCP servers: Exa, Firecrawl, Day One, n8n

**Requires confirmation:**
- Destructive operations: rm, sudo, kill, pkill

**Philosophy:** Trust by default, ask only for risky operations.

### Universal Commands

#### `/graham` - Talent Evaluation
Analyzes public profiles using Graham Duncan's framework.

**Usage:** `/graham [person's name]`

**Works in:** Any directory

**Output:** Structured talent assessment report

### Universal Agents

#### `web-researcher`
Specialized research agent using Exa and Firecrawl tools.

**Model:** Haiku (fast and cost-effective)

**Specialization:** Web search orchestration, documentation scraping, code examples

**When triggered:** Research tasks, gathering current information

### Installed Plugins

1. **exa-mcp-server** - Web and code search via Exa
2. **document-skills** - PDF, DOCX, XLSX, PPTX manipulation
3. **example-skills** - Skill creation, MCP building, art generation, testing, etc.

## Best Practices

### 1. Skills Management

**Your choice:** Plugin-based system ✓

- Skills come from installed plugins
- No manual `~/.claude/skills/` directory needed
- Skills auto-discovered from plugin packages
- Update plugins to get new skills

### 2. When to Create Project-Specific Config

**Create `PROJECT/.claude/settings.local.json` when:**
- Need to restrict certain tools (add to `deny` array)
- Need special permissions not in global (add to `allow` array)
- Working with sensitive data (add extra restrictions)

**Don't create if:**
- Global permissions are sufficient (most cases)
- No special restrictions needed

**Example - Restrict rm in production project:**
```json
{
  "permissions": {
    "allow": [],
    "deny": ["Bash(rm:*)"],
    "ask": []
  }
}
```

### 3. When to Create Project-Specific Agent

**Create `PROJECT/.claude/agents/my-agent.md` when:**
- Agent needs deep project-specific knowledge
- Agent requires unique tool combinations
- Workflow only makes sense in this project context

**Examples of project-specific agents:**
- Database migration agent for specific schema
- API testing agent for project's endpoints
- Deployment agent with project's infrastructure

**Don't create if:**
- Agent could be useful in other projects (make it universal)
- Simple prompt would suffice (use command instead)

### 4. When to Create Project-Specific Command

**Create `PROJECT/.claude/commands/my-command.md` when:**
- Command only makes sense in this project
- Command requires project-specific context

**Example:**
- `/deploy-staging` for project with specific deployment
- `/run-migrations` for database project

**Don't create if:**
- Command could be useful elsewhere (make it universal)
- Command is just a bash alias (document in CLAUDE.md instead)

### 5. CLAUDE.md Writing Guidelines

**Do include:**
```markdown
# Project Name

## Architecture
[How the system is structured]

## Setup
[How to get started]

## Key Files
[Important files to know about]

## Dependencies
[What this project needs]

## Testing
[How to run tests]

## Gotchas
[Project-specific quirks]
```

**Don't include:**
```markdown
# ❌ Generic templates
# ❌ Tool usage instructions
# ❌ Universal workflows
# ❌ Claude Code usage guides
```

## Permission Hierarchy

Permissions are evaluated in this order:

1. **Project local `deny`** - Blocks even if globally allowed
2. **Project local `allow`** - Adds to global permissions
3. **Global `deny`** - Blocks unless project allows
4. **Global `allow`** - Default permissions
5. **Global `ask`** - Requires confirmation

**Example:**

```
Global settings.json:
  allow: ["Bash(git:*)"]
  ask: ["Bash(rm:*)"]

Project settings.local.json:
  allow: ["Bash(rm:*)"]      # Override: rm now allowed in this project
  deny: ["Bash(git push:*)"]  # Override: git push blocked in this project
```

## Adding New Universal Commands

1. Create markdown file in `~/.claude/commands/`
2. Add frontmatter with description:
   ```markdown
   ---
   description: Brief description of what this command does
   ---

   [Command prompt/instructions]
   ```
3. Command is immediately available as `/filename`

## Adding New Universal Agents

1. Create markdown file in `~/.claude/agents/`
2. Include frontmatter with configuration:
   ```markdown
   ---
   model: haiku  # or sonnet/opus
   color: blue   # or any color for visual distinction
   ---

   You are a [role] specialized in [task].

   [Agent instructions]
   ```
3. Agent is available for Task tool invocations

## MCP Server Configuration

Your MCP servers are configured in:
`~/Library/Application Support/Claude/claude_desktop_config.json`

**Active servers:**
- **exa** - Web and code search
- **firecrawl** - Web scraping and crawling
- **dayone** - Day One journaling
- **n8n** - Workflow automation

**All MCP tools are globally permitted** in `~/.claude/settings.json`

## Troubleshooting

### Command not found
- Check file is in `~/.claude/commands/`
- Verify filename (command is `/filename` without `.md`)
- Restart Claude Code if needed

### Permission denied
- Check `~/.claude/settings.json` for global permissions
- Check `PROJECT/.claude/settings.local.json` for local overrides
- Tool may be in `deny` array or missing from `allow` array

### Agent not triggering
- Verify agent file exists in `~/.claude/agents/` or `PROJECT/.claude/agents/`
- Check agent description matches use case
- Use Task tool explicitly if needed

### CLAUDE.md not being used
- Verify file is named exactly `CLAUDE.md` (case-sensitive)
- Check file is in project root
- File is automatically loaded when working in that directory

## Migration Notes

### What Changed (2025-11-04)

**Consolidated:**
- ✓ Graham command moved from project to universal
- ✓ Removed manual `/Users/levi/data/skills/` directory
- ✓ Using plugin-based skill system only

**Simplified:**
- ✓ Global permissions now permissive by default
- ✓ Project-specific permissions simplified (removed redundancies)
- ✓ CLAUDE.md files cleaned of generic templates

**Organized:**
- ✓ Clear separation: universal vs project-specific
- ✓ Documentation added (this file)
- ✓ Structure aligned with Claude Code best practices

## Quick Reference

| Configuration | Location | Purpose |
|--------------|----------|---------|
| Commands (universal) | `~/.claude/commands/` | Available everywhere |
| Commands (project) | `PROJECT/.claude/commands/` | Only in that project |
| Agents (universal) | `~/.claude/agents/` | Available everywhere |
| Agents (project) | `PROJECT/.claude/agents/` | Only in that project |
| Permissions (global) | `~/.claude/settings.json` | Default permissions |
| Permissions (project) | `PROJECT/.claude/settings.local.json` | Override global |
| Project context | `PROJECT/CLAUDE.md` | Project-specific info |
| Skills | Plugins | Via installed plugins |
| MCP servers | Claude Desktop config | Global integrations |

## Further Resources

- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- [MCP Documentation](https://modelcontextprotocol.io)
- Project-specific docs in respective CLAUDE.md files
