# MCP Server Setup Guide

Complete guide to configuring Model Context Protocol (MCP) servers with Claude Code setups.

## What Are MCP Servers?

MCP (Model Context Protocol) servers extend Claude Code with external tools and data sources. They run as separate processes and provide capabilities like:

- **Web crawling & scraping** (Crawl4AI) - Extract content from websites, generate PDFs/screenshots, execute JavaScript
- **AI-powered search** (Perplexity) - Search the web, conduct research, and reason about topics

**Key Point**: MCP servers are **optional enhancements**. All setups work without them, but they significantly improve capabilities for research and web content workflows.

## Current MCP Server Stack

| Server | Type | Purpose |
|--------|------|---------|
| **Crawl4AI** | SSE | Web crawling, scraping, screenshots, PDF generation, JS execution |
| **Perplexity** | stdio | AI-powered web search, deep research, reasoning |

## Prerequisites

Before configuring MCP servers:

1. **Node.js installed** (v18 or higher)
   ```bash
   node --version
   ```
   If not installed: [https://nodejs.org/](https://nodejs.org/)

2. **API Keys/Credentials**
   - Crawl4AI: Server URL and authentication token
   - Perplexity: API key from [https://perplexity.ai/](https://www.perplexity.ai/)

## Configuration Locations

MCP servers can be configured in two places:

### Global Configuration (recommended)
```
~/.claude.json
```
Settings here apply to all Claude Code sessions.

### Project-Level Configuration
```
~/.claude/settings.json
```
Or in a project's `.claude/settings.json` for project-specific servers.

## Step-by-Step Setup

### Step 1: Configure Environment Variables (Recommended)

Add credentials to your shell profile (`~/.zshrc` or `~/.bashrc`):

```bash
# Crawl4AI
export CRAWL4AI_URL="http://your-server:11235/mcp/sse"
export CRAWL4AI_TOKEN="your-auth-token"

# Perplexity
export PERPLEXITY_API_KEY="pplx-your-api-key"
```

Reload your shell:
```bash
source ~/.zshrc
```

### Step 2: Configure MCP Servers

#### Option A: Global Configuration (~/.claude.json)

Add the `mcpServers` section to your `~/.claude.json`:

```json
{
  "mcpServers": {
    "crawl4ai": {
      "type": "sse",
      "url": "http://your-server:11235/mcp/sse",
      "headers": {
        "Authorization": "Bearer your-auth-token"
      }
    },
    "perplexity": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@perplexity-ai/mcp-server"],
      "env": {
        "PERPLEXITY_API_KEY": "your-perplexity-api-key"
      }
    }
  }
}
```

#### Option B: Project Settings (~/.claude/settings.json)

Add to the `mcpServers` section with environment variable references:

```json
{
  "mcpServers": {
    "crawl4ai": {
      "type": "sse",
      "url": "${CRAWL4AI_URL}",
      "headers": {
        "Authorization": "Bearer ${CRAWL4AI_TOKEN}"
      }
    },
    "perplexity": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@perplexity-ai/mcp-server"],
      "env": {
        "PERPLEXITY_API_KEY": "${PERPLEXITY_API_KEY}"
      }
    }
  }
}
```

### Step 3: Validate Configuration

Check that your JSON is valid:

```bash
cat ~/.claude.json | jq .mcpServers
```

### Step 4: Restart Claude Code

For the changes to take effect, start a new Claude Code session:

```bash
claude
```

## MCP Server Details

### Crawl4AI

A powerful web crawling and scraping server that provides:

**Tools Available:**
- `mcp__crawl4ai__md` - Fetch URL and convert to markdown
- `mcp__crawl4ai__html` - Get preprocessed HTML for schema extraction
- `mcp__crawl4ai__screenshot` - Capture full-page PNG screenshots
- `mcp__crawl4ai__pdf` - Generate PDF documents from URLs
- `mcp__crawl4ai__execute_js` - Execute JavaScript on pages
- `mcp__crawl4ai__crawl` - Batch crawl multiple URLs
- `mcp__crawl4ai__ask` - Query Crawl4AI documentation

**Example Usage:**
```
"Fetch the main content from https://example.com and convert to markdown"
"Take a screenshot of https://example.com"
"Generate a PDF of this webpage"
```

**Server Types:**
- **SSE (Server-Sent Events)**: Connects to a remote Crawl4AI server
- Requires: Server URL and authentication token

### Perplexity

AI-powered search and research capabilities:

**Tools Available:**
- `mcp__perplexity__perplexity_ask` - Conversational AI responses
- `mcp__perplexity__perplexity_search` - Web search with ranked results
- `mcp__perplexity__perplexity_research` - Deep research with citations
- `mcp__perplexity__perplexity_reason` - Complex reasoning tasks

**Example Usage:**
```
"Search for recent news about AI developments"
"Research the history of quantum computing with citations"
"Reason through this complex problem step by step"
```

**Server Type:**
- **stdio**: Runs locally via npx
- Requires: Perplexity API key

## Setting Up Crawl4AI Server

Crawl4AI requires a running server. Options:

### Option 1: Self-Hosted (Docker)

```bash
docker run -d -p 11235:11235 unclecode/crawl4ai
```

### Option 2: Self-Hosted (Python)

```bash
pip install crawl4ai
crawl4ai-server --port 11235
```

### Option 3: Remote Server

Use a hosted Crawl4AI instance (requires URL and auth token from provider).

## Getting Perplexity API Key

1. Visit [https://www.perplexity.ai/](https://www.perplexity.ai/)
2. Sign up or log in
3. Navigate to API settings
4. Generate an API key (starts with `pplx-`)
5. Add to your configuration

## Security Best Practices

### 1. Protect Credentials

**DO:**
- Store credentials in environment variables
- Use `${VAR}` syntax in config files for portability
- Set restrictive file permissions: `chmod 600 ~/.claude.json`

**DON'T:**
- Commit credentials to git repositories
- Share configuration files with embedded credentials
- Store credentials in plain text in public locations

### 2. Environment Variables Setup

```bash
# Add to ~/.zshrc or ~/.bashrc
export CRAWL4AI_URL="http://your-server:11235/mcp/sse"
export CRAWL4AI_TOKEN="your-token"
export PERPLEXITY_API_KEY="pplx-your-key"
```

## Troubleshooting

### MCP servers not responding

**Symptoms**: Claude Code doesn't use MCP tools, or errors about servers not found.

**Solutions**:
1. Verify config file exists and is valid JSON:
   ```bash
   cat ~/.claude.json | jq .mcpServers
   ```

2. Check Node.js is installed (for Perplexity):
   ```bash
   node --version
   ```

3. Test Crawl4AI server connectivity:
   ```bash
   curl -H "Authorization: Bearer YOUR_TOKEN" http://your-server:11235/health
   ```

4. Start a fresh Claude Code session

### API key errors

**Symptoms**: "Invalid API key" or "Authentication failed" errors.

**Solutions**:
1. Verify API keys are correct (no extra spaces)
2. Check API key hasn't expired
3. Verify account has sufficient credits/quota
4. Test Perplexity key:
   ```bash
   curl -H "Authorization: Bearer pplx-YOUR_KEY" https://api.perplexity.ai/health
   ```

### npx command not found

**Symptoms**: Error about `npx` not being recognized.

**Solutions**:
1. Install Node.js from [nodejs.org](https://nodejs.org/)
2. Verify installation: `which npx`
3. Restart terminal
4. Update npm: `npm install -g npm@latest`

### Crawl4AI connection refused

**Symptoms**: Cannot connect to Crawl4AI server.

**Solutions**:
1. Verify server is running and accessible
2. Check firewall rules allow the connection
3. Verify URL and port are correct
4. Check authentication token is valid

## Permissions Configuration

To use MCP tools without confirmation prompts, add to your `settings.json`:

```json
{
  "permissions": {
    "allow": [
      "mcp__crawl4ai",
      "mcp__perplexity"
    ]
  }
}
```

## When to Use Which Tool

| Task | Recommended Tool | Why |
|------|------------------|-----|
| Fetch webpage content | `mcp__crawl4ai__md` | Clean markdown extraction |
| Screenshot a page | `mcp__crawl4ai__screenshot` | Full-page PNG capture |
| Generate PDF | `mcp__crawl4ai__pdf` | Archivable document |
| Quick web search | `mcp__perplexity__perplexity_search` | Fast ranked results |
| Deep research | `mcp__perplexity__perplexity_research` | Comprehensive with citations |
| Complex reasoning | `mcp__perplexity__perplexity_reason` | Step-by-step analysis |
| Interactive pages | `mcp__crawl4ai__execute_js` | JS execution needed |
| Batch URL processing | `mcp__crawl4ai__crawl` | Multiple pages at once |

## Remember

- **MCP servers are optional** - All setups work without them
- **Credentials security** - Never commit API keys to repositories
- **Environment variables** - Use `${VAR}` syntax for portable configs
- **Server availability** - Crawl4AI requires a running server instance

## Getting Help

- **Setup issues**: See [GETTING_STARTED.md](GETTING_STARTED.md)
- **Claude Code issues**: Run `/help` in Claude Code
- **Crawl4AI docs**: [https://github.com/unclecode/crawl4ai](https://github.com/unclecode/crawl4ai)
- **Perplexity docs**: [https://docs.perplexity.ai/](https://docs.perplexity.ai/)
- **Repository issues**: [GitHub Issues](https://github.com/maynard242/claude_code_setups/issues)
