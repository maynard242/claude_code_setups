# MCP Server Setup Guide

Complete guide to configuring Model Context Protocol (MCP) servers with Claude Code setups.

## What Are MCP Servers?

MCP (Model Context Protocol) servers extend Claude Code with external tools and data sources. They run as separate processes and provide capabilities like:

- **Neural search** (Exa) - Find relevant content across the web using semantic search
- **Web scraping** (Firecrawl) - Extract clean content from websites
- **Journaling** (Day One) - Integrate with Day One journal app

**Key Point**: MCP servers are **optional enhancements**. All setups work perfectly fine without them, but they can significantly improve capabilities for research-heavy workflows.

## Which Setups Use MCP Servers?

| Setup | MCP Servers | Purpose |
|---|---|---|
| **general_ai** | Exa, Firecrawl, Day One | Multi-source research, web content, journaling |
| **deep_research** | Exa, Firecrawl | Academic/market research, evidence gathering |
| **osint_ai** | Exa, Firecrawl | OSINT investigations, background research |
| **science_ai** | Exa, Firecrawl | Scientific literature search, web sources |
| **finance_ai** | Exa, Firecrawl | Financial research, market data |
| **code_ai** | (Optional: Exa) | Code search, technical documentation |
| **ppt_builder** | - | No MCP servers needed |
| **bookkeeping_ai** | - | No MCP servers needed |

## Prerequisites

Before configuring MCP servers:

1. **Node.js installed** (v18 or higher)
   ```bash
   node --version
   ```
   If not installed: [https://nodejs.org/](https://nodejs.org/)

2. **API Keys** (for paid MCP servers)
   - Exa API key from [https://exa.ai/](https://exa.ai/)
   - Firecrawl API key from [https://firecrawl.dev/](https://firecrawl.dev/)
   - Day One: No API key needed (uses local app)

3. **Claude Desktop** (MCP servers are configured in Claude Desktop, not Claude Code CLI)

## Configuration Location

MCP servers are configured in:

```
~/Library/Application Support/Claude/claude_desktop_config.json
```

**Important**: This file is for **Claude Desktop**, not the Claude Code CLI. Claude Code will inherit the MCP configuration from Claude Desktop.

## Step-by-Step Setup

### Step 1: Create Configuration File

If the file doesn't exist, create it:

```bash
# Create directory if needed
mkdir -p ~/Library/Application\ Support/Claude/

# Create config file
touch ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

### Step 2: Configure MCP Servers

Edit the configuration file with your preferred editor:

```bash
nano ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

Use the appropriate configuration for your needs:

#### Option A: Exa Only (Neural Search)

```json
{
  "mcpServers": {
    "exa": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-exa"],
      "env": {
        "EXA_API_KEY": "your-exa-api-key-here"
      }
    }
  }
}
```

#### Option B: Exa + Firecrawl (Full Research Stack)

```json
{
  "mcpServers": {
    "exa": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-exa"],
      "env": {
        "EXA_API_KEY": "your-exa-api-key-here"
      }
    },
    "firecrawl": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-firecrawl"],
      "env": {
        "FIRECRAWL_API_KEY": "your-firecrawl-api-key-here"
      }
    }
  }
}
```

#### Option C: Full Setup (Including Day One)

```json
{
  "mcpServers": {
    "exa": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-exa"],
      "env": {
        "EXA_API_KEY": "your-exa-api-key-here"
      }
    },
    "firecrawl": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-firecrawl"],
      "env": {
        "FIRECRAWL_API_KEY": "your-firecrawl-api-key-here"
      }
    },
    "dayone": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-dayone"]
    }
  }
}
```

### Step 3: Get API Keys

#### Exa (Neural Search)

1. Visit [https://exa.ai/](https://exa.ai/)
2. Sign up for an account
3. Navigate to API settings
4. Generate an API key
5. Copy the key and paste into `claude_desktop_config.json`

**Pricing**: Free tier available, paid plans for higher usage

#### Firecrawl (Web Scraping)

1. Visit [https://firecrawl.dev/](https://firecrawl.dev/)
2. Create an account
3. Go to API keys section
4. Generate a new API key
5. Copy the key and paste into `claude_desktop_config.json`

**Pricing**: Free tier available, paid plans for higher volume

#### Day One (Journaling)

No API key needed. Ensure Day One app is installed on your Mac:

```bash
# Check if Day One is installed
ls /Applications/Day\ One.app
```

If not installed, download from [https://dayoneapp.com/](https://dayoneapp.com/)

### Step 4: Validate Configuration

Check that your JSON is valid:

```bash
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | jq .
```

If you see an error, fix any JSON syntax issues (missing commas, quotes, etc.).

### Step 5: Restart Claude Desktop

For the changes to take effect:

1. Quit Claude Desktop completely (Cmd+Q)
2. Restart Claude Desktop
3. The MCP servers will start automatically

### Step 6: Test MCP Servers

Start a Claude Code session and try MCP-powered tasks:

```bash
cd ~/your-project
claude
```

**Test Exa (Neural Search):**
```
"Use Exa to find recent articles about quantum computing breakthroughs"
```

**Test Firecrawl (Web Scraping):**
```
"Use Firecrawl to extract the main content from https://example.com/article"
```

**Test Day One (Journaling):**
```
"Create a Day One entry about today's research findings"
```

If working correctly, Claude Code will use the MCP servers automatically.

## Security Best Practices

### 1. Protect API Keys

**DO**:
- Store API keys only in `claude_desktop_config.json`
- Set restrictive file permissions: `chmod 600 ~/Library/Application\ Support/Claude/claude_desktop_config.json`
- Use environment variables for shared systems

**DON'T**:
- Commit API keys to git repositories
- Share `claude_desktop_config.json` publicly
- Store keys in plain text in other locations

### 2. Use Environment Variables (Advanced)

For better security, use environment variables:

1. Add keys to your shell profile (`~/.zshrc` or `~/.bashrc`):
   ```bash
   export EXA_API_KEY="your-exa-api-key"
   export FIRECRAWL_API_KEY="your-firecrawl-api-key"
   ```

2. Reference in config file:
   ```json
   {
     "mcpServers": {
       "exa": {
         "command": "npx",
         "args": ["-y", "@modelcontextprotocol/server-exa"],
         "env": {
           "EXA_API_KEY": "${EXA_API_KEY}"
         }
       }
     }
   }
   ```

3. Restart terminal and Claude Desktop

## Troubleshooting

### MCP servers not responding

**Symptoms**: Claude Code doesn't use MCP servers, or errors about servers not found.

**Solutions**:
1. Verify config file exists and is valid JSON:
   ```bash
   cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | jq .
   ```

2. Check Node.js is installed:
   ```bash
   node --version
   ```

3. Restart Claude Desktop completely (Cmd+Q, then reopen)

4. Check Claude Desktop console for errors (Help → Developer → Toggle Developer Tools)

### API key errors

**Symptoms**: "Invalid API key" or "Authentication failed" errors.

**Solutions**:
1. Verify API keys are correct (no extra spaces, complete key copied)
2. Check API key hasn't expired
3. Verify account has sufficient credits/quota
4. Test API key directly:
   ```bash
   curl -H "Authorization: Bearer YOUR_API_KEY" https://api.exa.ai/v1/search
   ```

### npx command not found

**Symptoms**: Error about `npx` not being recognized.

**Solutions**:
1. Install Node.js from [nodejs.org](https://nodejs.org/)
2. Verify installation: `which npx`
3. Restart terminal
4. Update npm: `npm install -g npm@latest`

### Day One not accessible

**Symptoms**: Can't create Day One entries or read journals.

**Solutions**:
1. Verify Day One app is installed
2. Open Day One and ensure it's configured
3. Check Day One permissions (System Preferences → Privacy)
4. Restart Claude Desktop

### Performance issues

**Symptoms**: Claude Code is slow when using MCP servers.

**Solutions**:
1. Check internet connection (MCP servers make API calls)
2. Monitor API rate limits (Exa, Firecrawl have usage caps)
3. Consider upgrading to paid plans for better performance
4. Disable unused MCP servers to reduce overhead

## Cost Optimization

### Exa Cost Tips

1. **Use specific searches**: More targeted queries = fewer API calls
2. **Cache results**: Don't repeat the same search
3. **Monitor usage**: Check your Exa dashboard regularly
4. **Free tier first**: Test with free tier before upgrading

### Firecrawl Cost Tips

1. **Selective scraping**: Only scrape when you need clean content
2. **Direct URLs**: Use WebFetch for simple pages, Firecrawl for complex ones
3. **Batch requests**: Scrape multiple pages in one session if possible
4. **Monitor quota**: Track usage in Firecrawl dashboard

### General Optimization

- **Disable for simple tasks**: Not every task needs MCP servers
- **Switch setups**: Use code_ai (no MCP) for non-research work
- **Local alternatives**: Use WebFetch when Firecrawl isn't needed
- **Review logs**: Check what's actually using MCP (Claude Desktop console)

## Advanced Configuration

### Custom MCP Servers

You can add custom MCP servers beyond the defaults. See [MCP documentation](https://modelcontextprotocol.io/) for:

- Building custom MCP servers
- Integrating proprietary data sources
- Creating domain-specific tools

### Per-Setup MCP Configuration

**Note**: Currently, MCP configuration is global (affects all Claude Desktop sessions). You cannot have different MCP servers per Claude Code setup.

**Workaround**: Manage API keys per-setup using environment variables and shell scripts.

## Verification Checklist

After setup, verify:

- [ ] `claude_desktop_config.json` exists and is valid JSON
- [ ] API keys are set correctly (no typos, complete keys)
- [ ] Node.js is installed (`node --version`)
- [ ] Claude Desktop has been restarted
- [ ] Test searches work in Claude Code
- [ ] No error messages in Claude Desktop console
- [ ] API usage shows in provider dashboards

## Additional Resources

- **Exa Documentation**: [https://docs.exa.ai/](https://docs.exa.ai/)
- **Firecrawl Documentation**: [https://docs.firecrawl.dev/](https://docs.firecrawl.dev/)
- **MCP Specification**: [https://modelcontextprotocol.io/](https://modelcontextprotocol.io/)
- **Claude Desktop Help**: [https://claude.com/docs](https://claude.com/docs)

## When to Use Which MCP Server

| Task | Recommended MCP | Why |
|---|---|---|
| Find academic papers | Exa | Semantic search across scholarly sources |
| Scrape article content | Firecrawl | Clean extraction from complex sites |
| Quick URL fetch | WebFetch | Built-in, no API cost |
| Code search | Exa | Neural understanding of code context |
| Market research | Exa + Firecrawl | Discovery + deep content extraction |
| OSINT | Exa + Firecrawl | Find leads + extract data |
| Journal reflection | Day One | Personal notes and insights |

## Remember

- **MCP servers are optional** - All setups work without them
- **Global configuration** - MCP servers affect all Claude Desktop usage
- **Cost awareness** - Monitor API usage to avoid unexpected charges
- **Security first** - Never commit API keys to repositories
- **Start small** - Begin with free tiers, upgrade as needed

## Getting Help

- **Setup issues**: See [GETTING_STARTED.md](GETTING_STARTED.md)
- **Claude Code issues**: Run `/help` in Claude Code
- **MCP issues**: Check Claude Desktop console (Help → Developer Tools)
- **Repository issues**: [GitHub Issues](https://github.com/maynard242/claude_code_setups/issues)

Happy researching with MCP servers!
