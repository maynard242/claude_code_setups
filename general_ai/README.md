# General AI Assistant - Claude Code Setup

A comprehensive, production-ready Claude Code configuration for general-purpose AI assistance with advanced web research, document processing, and intelligent orchestration capabilities.

## 🎯 Overview

This setup transforms Claude into a powerful general-purpose assistant capable of:
- **Multi-source web research** with semantic search and deep scraping
- **Intelligent task orchestration** across complex workflows
- **Document creation and manipulation** (PDF, DOCX, XLSX, PPTX)
- **Talent evaluation** using structured frameworks
- **Creative work** (art generation, design, presentations)
- **Development support** with common dev tools auto-approved

## 📋 Features

### Core Capabilities

#### 🔍 Advanced Web Research
- **Internet Search Skill**: Multi-source research with verification
- **Web-Researcher Agent**: Specialized agent for deep web investigations
- **Deep Research Command**: Comprehensive structured research reports
- **Tools**: WebSearch, WebFetch, Exa (neural search), Firecrawl (scraping)
- **Search Tools Guide**: See [SEARCH_TOOLS_GUIDE.md](SEARCH_TOOLS_GUIDE.md) for optimal usage strategies and cost optimization

#### 📄 Document Skills
- **PDF**: Creation, editing, form filling, manipulation
- **DOCX**: Word document generation and editing
- **XLSX**: Spreadsheet creation and data analysis
- **PPTX**: PowerPoint presentation building

#### 🧠 Specialized Agents
- **web-researcher**: Expert web search orchestration (Haiku model for speed)

#### ⚡ Slash Commands
- **/graham**: Talent evaluation using Graham Duncan's framework
- **/deep-research**: Multi-source comprehensive research investigations

#### 🎨 Creative Skills
- Algorithmic art generation
- Canvas design
- Theme factory (10+ professional themes)
- Slack GIF creation
- Brand guidelines

#### 🛠️ Development Skills
- MCP server builder
- Skill creator
- Web app testing
- Internal communications

### Permissions & Tools

#### Auto-Approved
- WebSearch (built-in)
- Development tools: git, gh, npm, yarn, pnpm, pip, pipenv, python, node, npx
- Containerization: docker, docker-compose
- Package managers: brew

#### MCP Integrations
- **Exa**: Neural web & code search
- **Firecrawl**: Advanced web scraping and extraction
- **Day One**: Journaling integration

#### Requires Confirmation
- Destructive operations: rm, sudo, kill, pkill

## 🚀 Setup Instructions

### Prerequisites
- Claude Code (Desktop or CLI)
- macOS (tested) or Linux
- API keys for enhanced features (optional):
  - Exa API key (for neural search)
  - Firecrawl API key (for advanced scraping)

### Installation

#### Step 1: Copy Setup to Your Mac

```bash
# Option A: Copy entire directory to your home .claude folder
cp -r /path/to/this/general_ai/.claude ~/

# Option B: Symlink for easier updates
ln -s /path/to/this/general_ai/.claude ~/.claude
```

#### Step 2: Configure MCP Servers (Optional but Recommended)

Edit your Claude Desktop config:
```bash
nano ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

Add MCP servers:
```json
{
  "mcpServers": {
    "exa": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-exa"],
      "env": {
        "EXA_API_KEY": "your-exa-api-key"
      }
    },
    "firecrawl": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-firecrawl"],
      "env": {
        "FIRECRAWL_API_KEY": "your-firecrawl-api-key"
      }
    }
  }
}
```

Get API keys:
- **Exa**: https://exa.ai (neural search - highly recommended)
- **Firecrawl**: https://firecrawl.dev (advanced scraping - recommended)

#### Step 3: Verify Installation

Launch Claude Code and test:
```
"What are the latest developments in AI?"
/graham "Elon Musk"
/deep-research "quantum computing breakthroughs"
```

---

**Version**: 1.0  
**Last Updated**: 2025-11-17  
**Tested On**: macOS (Claude Code Desktop + CLI)

Happy researching! 🚀
