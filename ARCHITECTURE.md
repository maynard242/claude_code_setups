# Architecture Overview

Deep dive into how Claude Code setups work, their structure, and the relationships between components.

## System Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                         Claude Code CLI                              │
│                    (github.com/anthropics/claude-code)               │
└────────────────────────────────┬────────────────────────────────────┘
                                 │
                                 │ Reads configuration from
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│                      Active Setup (~/.claude/)                       │
├─────────────────────────────────────────────────────────────────────┤
│  settings.json          Core configuration (permissions, model)     │
│  agents/*.md            Specialized sub-agents                       │
│  commands/*.md          Slash commands                               │
│  plugins/               MCP plugin configurations (optional)         │
│  cache/                 Runtime cache (auto-generated)               │
│  plans/                 Planning mode files (auto-generated)         │
│  todos/                 Todo tracking (auto-generated)               │
└────────────────────────────────┬────────────────────────────────────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
                    ▼                         ▼
    ┌───────────────────────────┐   ┌────────────────────────────┐
    │   Claude Desktop MCP      │   │  Repository Setups         │
    │   (External Config)       │   │  (Source of Truth)         │
    ├───────────────────────────┤   ├────────────────────────────┤
    │ claude_desktop_config.json│   │ general_ai/.claude/        │
    │                           │   │ code_ai/.claude/           │
    │ • Exa API key             │   │ deep_research/.claude/     │
    │ • Firecrawl API key       │   │ ppt_builder/.claude/       │
    │ • Day One integration     │   │ osint_ai/.claude/          │
    │                           │   │ science_ai/.claude/        │
    │ Located at:               │   │ finance_ai/.claude/        │
    │ ~/Library/Application     │   │ bookkeeping_ai/.claude/    │
    │ Support/Claude/           │   │                            │
    └───────────────────────────┘   └────────────┬───────────────┘
                                                  │
                                                  │ Managed by
                                                  ▼
                                    ┌──────────────────────────────┐
                                    │   Setup Switcher Script      │
                                    │   (switch-setup.sh)          │
                                    ├──────────────────────────────┤
                                    │ • Interactive menu           │
                                    │ • Automatic backups          │
                                    │ • Copy or symlink mode       │
                                    │ • Validation                 │
                                    └──────────────────────────────┘
```

## Setup Structure Deep Dive

### Directory Hierarchy

```
claude_code_setups/                    # Repository root
│
├── README.md                          # Main documentation (all 8 setups)
├── GETTING_STARTED.md                 # Onboarding guide
├── QUICK_REFERENCE.md                 # Cheat sheet
├── MCP_SETUP.md                       # MCP configuration guide
├── ARCHITECTURE.md                    # This file
├── CLAUDE.md                          # Developer guide
├── CHANGELOG.md                       # Version history
├── SECURITY_REVIEW.md                 # Security audit
├── AGENT_IMPROVEMENTS.md              # Agent enhancements log
├── LICENSE                            # MIT license
├── .gitignore                         # Git exclusions
│
├── switch-setup.sh                    # Setup switcher/installer
├── zshrc-helper.sh                    # Shell integration helper
│
├── .claude/                           # Root-level config (local)
│   └── settings.local.json            # Local overrides
│
└── <setup_name>/                      # Each specialized setup
    ├── README.md                      # Setup-specific docs
    └── .claude/                       # Setup configuration
        ├── settings.json              # Core config
        ├── agents/                    # Specialized sub-agents (optional)
        │   └── *.md                   # Agent definitions
        ├── commands/                  # Slash commands (optional)
        │   └── *.md                   # Command definitions
        └── skills/                    # Auto-activating skills (optional)
            └── *.md                   # Skill definitions
```

### Active Setup Runtime Structure

When a setup is installed to `~/.claude/`, additional runtime directories are created:

```
~/.claude/                             # Active setup
├── settings.json                      # Core configuration
│
├── agents/                            # Specialized agents
│   ├── web-researcher.md
│   ├── python-expert.md
│   ├── ml-engineer.md
│   ├── researcher.md
│   ├── investigator.md
│   ├── academic-writer.md
│   ├── financial-analyst.md
│   ├── statement-processor.md
│   └── presentation-builder.md
│
├── commands/                          # Slash commands
│   ├── graham.md
│   ├── deep-research.md
│   └── process-statement.md
│
├── plugins/                           # MCP plugins (optional)
│
├── cache/                             # Runtime cache (auto-generated)
├── debug/                             # Debug logs (auto-generated)
├── file-history/                      # File edit history (auto-generated)
├── plans/                             # Planning mode files (auto-generated)
├── projects/                          # Project contexts (auto-generated)
├── session-env/                       # Session environment (auto-generated)
├── shell-snapshots/                   # Shell state snapshots (auto-generated)
├── todos/                             # Todo tracking (auto-generated)
├── statsig/                           # Analytics (auto-generated)
└── telemetry/                         # Telemetry data (auto-generated)
```

**Note**: Only `.claude/`, `agents/`, `commands/`, and `settings.json` are essential. Other directories are created by Claude Code at runtime.

## Configuration File Format

### settings.json Structure

```json
{
  "setupId": "general_ai",                    // Unique setup identifier
  "model": "sonnet",                          // Default model (sonnet, opus, haiku)
  "alwaysThinkingEnabled": true,              // Extended reasoning mode

  "permissions": {
    "allow": [                                // Execute without confirmation
      "WebSearch",                            // Web search capability
      "WebFetch",                             // Fetch URL content
      "Bash(git:*)",                          // All git commands
      "Bash(npm:*)",                          // npm commands
      "Bash(python:*)",                       // Python interpreter
      "Bash(ls:*)",                           // List directory
      "Bash(cat:*)",                          // Read files
      "Bash(grep:*)",                         // Search content
      "Bash(find:*)"                          // Find files
    ],
    "ask": [                                  // Require user confirmation
      "Bash(rm:*)",                           // Delete files (destructive)
      "Bash(sudo:*)",                         // Superuser commands (security)
      "Bash(kill:*)",                         // Kill processes
      "Bash(chmod:*)"                         // Change permissions
    ]
  },

  "statusLine": {
    "type": "command",                        // Status line type
    "command": "echo -n '➜ '; ..."            // Bash command to generate status
  }
}
```

### Agent File Format

Agents are markdown files with YAML frontmatter:

```markdown
---
name: agent-name                              # Agent identifier
description: When to invoke this agent        # Automatic invocation trigger
model: sonnet                                 # Model to use (sonnet, opus, haiku)
color: blue                                   # UI visual distinction
---

# Agent Name

Agent instructions and expertise...

## Core Capabilities
- Capability 1
- Capability 2

## Protocols
Step-by-step workflows...

## Output Format
Expected output structure...
```

**Key Points**:
- Frontmatter is required (name, description, model)
- Description determines when agent is automatically invoked
- Content after frontmatter is the agent's system prompt
- Agents have full access to Claude Code tools

### Command File Format

Commands are markdown files with YAML frontmatter:

```markdown
---
description: Brief description of command functionality
---

Command instructions and expected behavior...

## Steps
1. Step one
2. Step two

## Output
Expected output format...
```

**Key Points**:
- Invoked explicitly with `/command-name`
- Description shown in command autocomplete
- Content is appended to the conversation context when invoked
- Commands don't change base model behavior, just add context

## How Components Work Together

### Startup Flow

```
1. User runs `claude` in terminal
         ↓
2. Claude Code CLI starts
         ↓
3. Reads ~/.claude/settings.json
         ↓
4. Loads agents from ~/.claude/agents/
         ↓
5. Loads commands from ~/.claude/commands/
         ↓
6. Checks MCP servers (if configured in Claude Desktop)
         ↓
7. Displays status line (executes statusLine.command)
         ↓
8. Ready for user input
```

### Agent Invocation Flow

```
1. User enters request: "Research quantum computing"
         ↓
2. Claude Code analyzes request against agent descriptions
         ↓
3. Matches "web-researcher" agent (multi-source research)
         ↓
4. Loads web-researcher.md content as system prompt
         ↓
5. Agent executes with specialized behavior
         ↓
6. Agent uses tools (WebSearch, WebFetch, etc.)
         ↓
7. Agent returns structured response
         ↓
8. Response displayed to user
```

**Important**: Agents are invoked **automatically** based on task matching, not explicitly by the user.

### Command Invocation Flow

```
1. User enters: "/deep-research"
         ↓
2. Claude Code looks for ~/.claude/commands/deep-research.md
         ↓
3. Loads command file content
         ↓
4. Appends content to conversation context
         ↓
5. Claude Code follows command instructions
         ↓
6. Executes multi-step research protocol
         ↓
7. Returns comprehensive research report
```

**Important**: Commands are invoked **explicitly** with `/command-name` by the user.

### Permission Check Flow

```
1. Claude Code wants to execute: `git status`
         ↓
2. Checks settings.json permissions.allow array
         ↓
3. Finds "Bash(git:*)" in allow list
         ↓
4. Executes without user confirmation
         ↓
5. Returns output

Alternative flow for destructive commands:

1. Claude Code wants to execute: `rm file.txt`
         ↓
2. Checks settings.json permissions.allow array
         ↓
3. Not in allow list, checks permissions.ask array
         ↓
4. Finds "Bash(rm:*)" in ask list
         ↓
5. Prompts user: "Allow rm file.txt? [y/n]"
         ↓
6. Waits for user confirmation
         ↓
7. Executes only if user approves
```

### Setup Switcher Flow

```
1. User runs: ./switch-setup.sh code_ai
         ↓
2. Script validates input (security check)
         ↓
3. Creates backup: ~/.claude.backup.YYYYMMDD_HHMMSS/
         ↓
4. Removes old ~/.claude/ (if exists)
         ↓
5. Copies code_ai/.claude/ to ~/.claude/
         ↓
6. Reports success
         ↓
7. User starts Claude Code with new setup
```

**Backup Strategy**: Every switch creates a timestamped backup, allowing easy rollback with `./switch-setup.sh --restore`.

## Data Flow Diagram

```
┌──────────────┐
│    User      │
└──────┬───────┘
       │ Enters request or command
       ▼
┌─────────────────────────────────────────┐
│         Claude Code CLI                 │
│  (Reads ~/.claude/settings.json)        │
└──────────┬──────────────────────────────┘
           │
           ├─ Automatic Agent Selection ──────┐
           │                                    │
           ├─ Explicit Command (/cmd) ─────────┤
           │                                    │
           ├─ Permission Check ────────────────┤
           │                                    │
           └─ MCP Server Integration ──────────┤
                                                ▼
                                    ┌──────────────────────┐
                                    │   Execute Action     │
                                    │                      │
                                    │ • Load agent context │
                                    │ • Check permissions  │
                                    │ • Call MCP servers   │
                                    │ • Use built-in tools │
                                    └──────────┬───────────┘
                                               │
                                               ▼
                                    ┌──────────────────────┐
                                    │   Return Response    │
                                    └──────────────────────┘
```

## Security Model

### Permission Boundaries

```
Permission Hierarchy:

1. Explicitly Allowed (permissions.allow)
   ├─ Executes immediately without confirmation
   ├─ Used for safe, read-only, or common commands
   └─ Examples: git, ls, cat, WebSearch

2. Requires Confirmation (permissions.ask)
   ├─ Prompts user before execution
   ├─ Used for destructive or security-sensitive operations
   └─ Examples: rm, sudo, kill, chmod

3. Implicitly Denied (not in either list)
   ├─ Cannot be executed
   ├─ Claude Code will refuse the operation
   └─ Example: dd, mkfs, format (if not explicitly allowed)
```

### Isolation Between Setups

Each setup operates independently:

```
general_ai setup:
├─ Has: WebSearch, WebFetch, npm, python, git
├─ Limited to web research and general development
└─ Cannot: Format disks, modify system files (without sudo prompt)

bookkeeping_ai setup:
├─ Has: Python, PDF tools, git
├─ Limited to statement processing and data manipulation
└─ Cannot: Access web (no WebSearch/WebFetch), run npm
```

**Benefits**:
- Principle of least privilege
- Reduced attack surface per workflow
- Clear separation of concerns

## MCP Integration Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Claude Desktop                            │
│  (Manages MCP server lifecycle)                              │
└────────────┬────────────────────────────────────────────────┘
             │
             │ Reads MCP configuration
             ▼
┌─────────────────────────────────────────────────────────────┐
│  claude_desktop_config.json                                  │
│  ~/Library/Application Support/Claude/                       │
├─────────────────────────────────────────────────────────────┤
│  {                                                           │
│    "mcpServers": {                                           │
│      "exa": { "command": "npx", "args": [...] },            │
│      "firecrawl": { "command": "npx", "args": [...] }       │
│    }                                                         │
│  }                                                           │
└────────────┬────────────────────────────────────────────────┘
             │
             │ Spawns MCP server processes
             ▼
┌───────────────────────────┐  ┌───────────────────────────┐
│   Exa MCP Server          │  │  Firecrawl MCP Server     │
│   (Neural Search)         │  │  (Web Scraping)           │
└───────────┬───────────────┘  └──────────┬────────────────┘
            │                              │
            │  Provides tools via MCP      │
            └──────────────┬───────────────┘
                           │
                           ▼
              ┌────────────────────────────┐
              │   Claude Code CLI          │
              │   (Inherits MCP servers)   │
              └────────────────────────────┘
```

**Key Points**:
- MCP configuration is **external** to Claude Code setups
- Claude Desktop manages MCP server processes
- Claude Code inherits MCP capabilities automatically
- All setups share the same MCP servers (global config)

## Design Philosophy

### Why Separate Setups?

**Alternative**: One massive config with all permissions and all agents.

**Problem**:
- Overwhelming choice
- Security risk (too many permissions)
- Cognitive overhead (too many agents)
- Performance impact (loading unused agents)

**Solution**: Specialized setups for specific workflows.

### Why Copy Instead of Symlink by Default?

**Symlink Mode**: `./switch-setup.sh --link general_ai`
- Pro: Auto-updates when repo changes
- Con: Unstable if repo has breaking changes
- Use case: Active development, testing

**Copy Mode**: `./switch-setup.sh general_ai` (default)
- Pro: Stable, predictable behavior
- Con: Manual updates needed
- Use case: Production use, stability

### Why Agents vs Commands?

**Agents** (Automatic):
- Invoked based on task analysis
- Complex, multi-step workflows
- Domain expertise required
- Example: Research, code generation

**Commands** (Explicit):
- Invoked with `/command-name`
- Well-defined, repeatable workflows
- User controls when to use
- Example: /deep-research, /process-statement

## Extension Points

### Adding a New Agent

1. Create agent file: `~/.claude/agents/my-agent.md`
2. Add frontmatter with name, description, model
3. Write agent instructions
4. Claude Code will automatically detect and use it

### Adding a New Command

1. Create command file: `~/.claude/commands/my-command.md`
2. Add frontmatter with description
3. Write command instructions
4. Use with `/my-command` in Claude Code

### Creating a New Setup

1. Create directory: `new-setup/.claude/`
2. Create `settings.json` with permissions
3. Add agents (optional): `new-setup/.claude/agents/`
4. Add commands (optional): `new-setup/.claude/commands/`
5. Create `README.md` documenting the setup
6. Add to SETUPS list in `switch-setup.sh`

### Custom Status Line

Edit `settings.json` statusLine.command:

```json
{
  "statusLine": {
    "type": "command",
    "command": "echo -n 'Your custom status here'"
  }
}
```

**Examples**:
- Show current Python version
- Display git branch and status
- Show directory with emoji
- Include timestamp

## Performance Considerations

### Agent Loading

- Agents are loaded at Claude Code startup
- More agents = slightly longer startup time
- **Recommendation**: Keep agents focused and minimal per setup

### Status Line Execution

- Status line command runs on every prompt
- Complex commands slow down the prompt display
- **Recommendation**: Keep status line commands fast (<100ms)

### MCP Server Overhead

- Each MCP server is a separate process
- Adds memory and startup overhead
- **Recommendation**: Only configure MCP servers you actually use

## Troubleshooting Architecture

### Setup Not Switching

**Check**:
1. Is switch-setup.sh executable? `ls -l switch-setup.sh`
2. Does the setup directory exist? `ls -d code_ai/.claude/`
3. Was backup created? `ls -ld ~/.claude.backup.*/`
4. Is settings.json valid? `cat ~/.claude/settings.json | jq .`

### Agent Not Loading

**Check**:
1. Does agent file exist? `ls ~/.claude/agents/researcher.md`
2. Is frontmatter valid? `head ~/.claude/agents/researcher.md`
3. Is filename correct? (must be `.md`)
4. Restart Claude Code session

### Permission Denied

**Check**:
1. Is command in allow list? `jq .permissions.allow ~/.claude/settings.json`
2. Is command in ask list? `jq .permissions.ask ~/.claude/settings.json`
3. Did you approve the prompt? (for ask list commands)

## Comparison with Other Approaches

### vs Single Monolithic Config

| Aspect | Specialized Setups | Monolithic Config |
|---|---|---|
| Permissions | Minimal per-setup | All permissions always |
| Agent Loading | Only relevant agents | All agents always |
| Cognitive Load | Focused workflow | Overwhelming choice |
| Security | Least privilege | Broad access |
| Performance | Optimized | Slower startup |

### vs Manual Config Editing

| Aspect | Setup Switcher | Manual Editing |
|---|---|---|
| Switching Speed | One command | Multiple steps |
| Backup | Automatic | Manual |
| Error Prone | Low (validated) | High (typos) |
| Rollback | Easy (`--restore`) | Manual (if backup exists) |
| Learning Curve | Simple | Requires JSON knowledge |

## Future Architecture Considerations

Potential enhancements (not yet implemented):

1. **Per-Setup MCP Config**: Different MCP servers per setup
2. **Agent Chaining**: Agents calling other agents
3. **Dynamic Permissions**: Context-based permission adjustment
4. **Setup Profiles**: Combine multiple setups into one session
5. **Cloud Sync**: Sync setups across machines

## Additional Resources

- [GETTING_STARTED.md](GETTING_STARTED.md) - Setup and installation
- [QUICK_REFERENCE.md](QUICK_REFERENCE.md) - Command reference
- [MCP_SETUP.md](MCP_SETUP.md) - MCP server configuration
- [CLAUDE.md](CLAUDE.md) - Developer guide for customization
- [README.md](README.md) - Complete documentation

---

**Understanding the architecture helps you customize and extend Claude Code setups effectively!**
