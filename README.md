# Claude Code Specialized Setups

A collection of production-ready Claude Code configurations optimized for different professional workflows. Each setup includes specialized agents, custom commands, and pre-configured permissions for maximum productivity.

## 🎯 Overview

This repository contains seven specialized Claude Code setups for different use cases:

| Setup | Use Case | Key Features |
|-------|----------|--------------|
| **general_ai** | General-purpose assistant | Multi-source research, document creation, talent evaluation |
| **code_ai** | Python/ML/AI development | PyTorch, type safety, testing, MLOps, experiment tracking |
| **deep_research** | Academic & market research | Evidence-based analysis, competitive intelligence, SWOT |
| **ppt_builder** | Presentation creation | PowerPoint design, slide templates, visual storytelling |
| **osint_ai** | OSINT/Investigative research | Background checks, fact-checking, evidence documentation |
| **science_ai** | Scientific/Academic writing | Research papers, grants, statistical reporting, LaTeX |
| **finance_ai** | Financial/Investment research | Stock analysis, valuation models, SEC filings |

## 📋 Quick Start

### Using the Setup Switcher (Recommended)

```bash
# Clone the repository
git clone https://github.com/maynard242/claude_code_setups.git
cd claude_code_setups

# Interactive mode - choose from menu
./switch-setup.sh

# Or specify directly
./switch-setup.sh general_ai

# Use symlink for automatic updates
./switch-setup.sh --link general_ai
```

### Manual Installation

```bash
# Copy your desired setup to Claude's config directory
cp -r general_ai/.claude ~/

# Or symlink for easier updates
ln -s "$(pwd)/general_ai/.claude" ~/.claude
```

### Setup Switcher Commands

```bash
./switch-setup.sh              # Interactive menu
./switch-setup.sh code_ai      # Switch to specific setup
./switch-setup.sh --link NAME  # Symlink instead of copy
./switch-setup.sh --current    # Show current setup
./switch-setup.sh --backup     # Backup without switching
./switch-setup.sh --restore    # Restore from backup
./switch-setup.sh --list       # List available backups
./switch-setup.sh --help       # Show all options
```

The setup switcher automatically creates timestamped backups before switching, validates input for security, and can detect which setup is currently active.

## 🔧 Detailed Setup Guides

### 1. General AI Assistant (`general_ai/`)

**Perfect for:** Research, writing, document creation, general productivity

**Key Capabilities:**
- 🔍 **Advanced Web Research**: Multi-source verification with Exa + Firecrawl
- 📄 **Document Skills**: PDF, DOCX, XLSX, PPTX creation and editing
- 🧠 **Talent Evaluation**: `/graham` command using structured frameworks
- 📊 **Deep Research**: `/deep-research` for comprehensive investigations
- 🎨 **Creative Work**: Art generation, themes, design

**Specialized Agent:**
- **web-researcher**: Intelligent search orchestrator with tool selection decision tree, multi-tool patterns, and cost optimization strategies

**Quick Usage:**
```bash
# Setup
cp -r general_ai/.claude ~/

# Test it
claude
> "What are the latest AI breakthroughs in 2025?"
> /graham "Sam Altman"
> /deep-research "quantum computing applications"
```

**Auto-Approved Tools:**
- WebSearch, WebFetch
- Development: git, gh, npm, pip, docker
- MCP: Exa, Firecrawl, Day One, n8n

[📖 Full Documentation](general_ai/README.md)

---

### 2. Code AI - Python/ML Engineer (`code_ai/`)

**Perfect for:** Python development, machine learning, data science, AI research

**Key Capabilities:**
- 🐍 **Python Expert**: Type safety (mypy), testing (pytest), modern patterns
- 🧠 **ML Engineer**: PyTorch, training loops, distributed training, MLOps
- 📊 **Data Science**: Pandas, NumPy, scikit-learn, visualization
- ⚡ **Experiment Tracking**: Weights & Biases, MLflow, TensorBoard
- 🚀 **Deployment**: TorchScript, ONNX, quantization

**Quick Usage:**
```bash
# Setup
cp -r code_ai/.claude ~/

# Install Python tools
pip install torch pytorch-lightning transformers pandas pytest black ruff mypy wandb

# Test it
claude
> "Review this code for type safety and best practices"
> "Create a PyTorch Lightning training loop with wandb logging"
> "Set up a data pipeline with albumentations augmentation"
```

**Auto-Approved Tools:**
- Python: python, pip, conda, poetry, uv
- Testing: pytest, black, ruff, mypy, pylint
- ML: jupyter, tensorboard, wandb, mlflow
- GPU: nvidia-smi, nvcc

**Status Line:** Shows Python version + git status

[📖 Full Documentation](code_ai/README.md)

---

### 3. Deep Research Specialist (`deep_research/`)

**Perfect for:** Academic research, market analysis, competitive intelligence, due diligence

**Key Capabilities:**
- 📚 **Academic Research**: Literature reviews, paper analysis, citation management
- 📈 **Market Research**: Industry trends, TAM/SAM/SOM, market sizing
- 🔍 **Competitive Intelligence**: SWOT analysis, competitive positioning
- 🏢 **Company Analysis**: Financial filings, strategic assessment
- ✅ **Evidence-Based Reporting**: Multi-source verification, credibility tiers

**Specialized Agent:**
- **researcher**: Comprehensive research analyst with tool selection matrix, verification standards table, and source credibility tiers (Tier 1-4)

**Quick Usage:**
```bash
# Setup
cp -r deep_research/.claude ~/

# Configure MCP servers (optional but recommended)
# Add Exa and Firecrawl API keys to claude_desktop_config.json

# Test it
claude
> "Research the competitive landscape for AI infrastructure startups"
> "Conduct a SWOT analysis of Anthropic"
> "Analyze market trends in autonomous vehicles"
```

**Research Methodologies:**
- Systematic literature reviews
- Multi-source verification (minimum 2-3 sources)
- Source credibility tiers (Tier 1-4 classification)
- Structured reporting templates

**Auto-Approved Tools:**
- WebSearch, WebFetch
- MCP: Exa (neural search), Firecrawl (scraping)
- Utilities: curl, wget, jq

[📖 Full Documentation](deep_research/README.md)

---

### 4. PowerPoint Builder (`ppt_builder/`)

**Perfect for:** Pitch decks, business reports, training materials, presentations

**Key Capabilities:**
- 📊 **Presentation Design**: Professional layouts, visual hierarchy, typography
- 🎨 **Storytelling**: Narrative structure, hook-context-resolution framework
- 📈 **Data Visualization**: Charts, graphs, comparison tables
- 🎯 **Templates**: Pitch decks, business reports, technical presentations
- ✨ **Design Principles**: 6×6 rule, white space, consistent styling

**Quick Usage:**
```bash
# Setup
cp -r ppt_builder/.claude ~/

# Test it
claude
> "Create a 10-slide pitch deck for a SaaS startup"
> "Build a quarterly business review presentation"
> "Design training slides for Python onboarding"
```

**Presentation Types:**
- **Pitch Decks**: Problem, solution, market, traction, team, ask
- **Business Reports**: Performance, metrics, analysis, recommendations
- **Technical**: Architecture, implementation, trade-offs
- **Educational**: Training, workshops, how-to guides

**Auto-Approved Tools:**
- Document skills (PPTX creation)
- WebSearch for research
- Basic dev tools: git, python, node, npm

[📖 Full Documentation](ppt_builder/README.md)

---

### 5. OSINT / Investigative Research (`osint_ai/`)

**Perfect for:** Background investigations, fact-checking, due diligence, public records analysis

**Key Capabilities:**
- 🔎 **Background Research**: Person/company investigation, employment verification
- 🌐 **Digital Footprint**: Social media analysis, domain investigation
- 📋 **Corporate Intelligence**: Business registrations, litigation history
- ✅ **Fact-Checking**: Claim verification, source authentication
- 📅 **Timeline Construction**: Chronological event mapping

**Specialized Agent:**
- **investigator**: OSINT specialist with systematic evidence gathering, confidence scoring, and red flag identification

**Quick Usage:**
```bash
# Setup
cp -r osint_ai/.claude ~/

# Test it
claude
> "Investigate the background of company XYZ Corp"
> "Verify the claims in this article"
> "Build a timeline of events for [subject]"
```

**Auto-Approved Tools:**
- WebSearch, WebFetch
- DNS: whois, dig, nslookup
- MCP: Exa, Firecrawl

[📖 Full Documentation](osint_ai/README.md)

---

### 6. Scientific / Academic Writing (`science_ai/`)

**Perfect for:** Research papers, literature reviews, grant proposals, statistical reporting

**Key Capabilities:**
- 📝 **Research Papers**: IMRaD structure, methodology, results sections
- 📚 **Literature Reviews**: Systematic reviews, synthesis, gap analysis
- 💰 **Grant Proposals**: Specific aims, significance, approach
- 📊 **Statistical Reporting**: Proper p-values, effect sizes, confidence intervals
- 📨 **Peer Review**: Reviewer responses, manuscript revision

**Specialized Agent:**
- **academic-writer**: Scientific writing specialist with citation practices, statistical rigor, and academic conventions

**Quick Usage:**
```bash
# Setup
cp -r science_ai/.claude ~/

# Test it
claude
> "Help me write the methods section for my experiment"
> "Review this statistical reporting for APA compliance"
> "Draft a literature review on [topic]"
```

**Auto-Approved Tools:**
- WebSearch, WebFetch
- LaTeX: pdflatex, bibtex, pandoc
- MCP: Exa, Firecrawl

[📖 Full Documentation](science_ai/README.md)

---

### 7. Financial / Investment Research (`finance_ai/`)

**Perfect for:** Stock analysis, valuation modeling, earnings analysis, portfolio research

**Key Capabilities:**
- 📈 **Financial Analysis**: Income statement, balance sheet, cash flow
- 💵 **Valuation**: DCF, comparables, precedent transactions
- 🏢 **Industry Analysis**: Competitive dynamics, market sizing
- 📋 **Investment Thesis**: Bull/bear cases, catalysts, risk assessment
- 🔢 **Quantitative Screening**: Ratios, growth metrics, quality factors

**Specialized Agent:**
- **financial-analyst**: Investment research specialist with valuation frameworks and financial metrics expertise

**Quick Usage:**
```bash
# Setup
cp -r finance_ai/.claude ~/

# Test it
claude
> "Analyze Apple's latest 10-K filing"
> "Build a DCF model for [company]"
> "Compare valuation multiples for [industry]"
```

**Auto-Approved Tools:**
- WebSearch, WebFetch
- Python for analysis
- MCP: Exa, Firecrawl

[📖 Full Documentation](finance_ai/README.md)

---

## 🚀 Advanced Configuration

### MCP Server Setup (Recommended)

For enhanced research capabilities, configure MCP servers:

```bash
# Edit Claude Desktop config
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

**Get API Keys:**
- **Exa**: https://exa.ai - Neural search and semantic discovery
- **Firecrawl**: https://firecrawl.dev - Advanced web scraping

### Customizing Setups

Each setup can be customized by editing:

```
setup_name/.claude/
├── settings.json          # Permissions and configuration
├── agents/               # Specialized sub-agents
│   └── agent-name.md     # Agent definitions
├── commands/             # Slash commands
│   └── command-name.md   # Command prompts
└── skills/               # Auto-activating skills
    └── skill-name.md     # Skill definitions
```

### Adding New Agents

Create a new agent file:

```bash
nano ~/.claude/agents/my-agent.md
```

Add frontmatter and instructions:

```markdown
---
name: my-agent
description: Brief description of when to use this agent
model: sonnet  # or haiku, opus
color: blue    # visual distinction
---

You are an expert in [domain]...
[Agent instructions]
```

### Adding New Commands

Create a new command file:

```bash
nano ~/.claude/commands/my-command.md
```

Add frontmatter and prompt:

```markdown
---
description: Brief description of what this command does
---

[Command instructions and expected output format]
```

Use with `/my-command` in Claude Code.

## 📊 Comparison Matrix

| Feature | general_ai | code_ai | deep_research | ppt_builder | osint_ai | science_ai | finance_ai |
|---------|-----------|---------|---------------|-------------|----------|------------|------------|
| **Web Research** | ✅ Advanced | ⚠️ Basic | ✅ Expert | ⚠️ Basic | ✅ Expert | ⚠️ Basic | ✅ Advanced |
| **Code Development** | ⚠️ Basic | ✅ Expert | ❌ None | ❌ None | ❌ None | ⚠️ Basic | ⚠️ Basic |
| **Document Creation** | ✅ All formats | ⚠️ Basic | ⚠️ Reports | ✅ PPTX | ⚠️ Reports | ✅ LaTeX/Papers | ⚠️ Reports |
| **Data Analysis** | ⚠️ Basic | ✅ Expert | ⚠️ Research | ❌ None | ⚠️ Basic | ✅ Statistical | ✅ Financial |
| **ML/AI Development** | ❌ None | ✅ Expert | ❌ None | ❌ None | ❌ None | ❌ None | ❌ None |
| **Investigation** | ⚠️ Basic | ❌ None | ⚠️ Basic | ❌ None | ✅ Expert | ❌ None | ⚠️ Due diligence |
| **Academic Writing** | ⚠️ Basic | ❌ None | ⚠️ Capable | ❌ None | ❌ None | ✅ Expert | ❌ None |
| **Financial Analysis** | ❌ None | ❌ None | ⚠️ Basic | ❌ None | ⚠️ Corporate | ❌ None | ✅ Expert |
| **Thinking Mode** | ✅ On | ✅ On | ✅ On | ✅ On | ✅ On | ✅ On | ✅ On |
| **MCP Integration** | ✅ Full | ❌ None | ✅ Full | ❌ None | ✅ Full | ✅ Full | ✅ Full |

Legend: ✅ Expert | ⚠️ Capable | ❌ Not focused

## 🎓 Best Practices

### For General AI
- Use `/deep-research` for comprehensive multi-source investigations
- Use `/graham` for talent evaluation with structured frameworks
- Enable MCP servers (Exa, Firecrawl) for best research results
- Leverage document skills for creating professional outputs

### For Code AI
- Always request type hints and tests
- Use experiment tracking (wandb/mlflow) for ML projects
- Request code reviews before major changes
- Leverage PyTorch Lightning for production training
- Use `uv` or `poetry` for dependency management

### For Deep Research
- Request source credibility assessments
- Ask for multi-source verification on critical claims
- Use structured report templates for consistency
- Specify research depth needed (quick vs. comprehensive)
- Request confidence levels for findings

### For PPT Builder
- Specify presentation type (pitch deck, report, training)
- Provide target audience information
- Request specific slide count
- Ask for narrative structure before slide creation
- Iterate on design and content separately

### For OSINT Research
- Define investigation scope and objectives clearly
- Request confidence levels for all findings
- Ask for source documentation with timestamps
- Request red flag identification
- Specify legal/ethical boundaries

### For Science/Academic
- Specify target journal or style guide (APA, AMA, etc.)
- Request proper statistical reporting (effect sizes, CIs)
- Ask for citation verification
- Request methodology critique
- Specify section being written (methods, results, etc.)

### For Finance Research
- Specify analysis type (equity research, valuation, screening)
- Request multiple valuation methods
- Ask for bull/bear case scenarios
- Request risk assessment
- Specify time horizon and investment style

## 🔧 Troubleshooting

### Setup Not Loading
```bash
# Verify file location
ls -la ~/.claude/

# Check settings.json syntax
cat ~/.claude/settings.json | jq .

# Restart Claude Code
```

### MCP Servers Not Working
```bash
# Verify MCP config
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Test npx command
npx -y @modelcontextprotocol/server-exa --version

# Check API keys are set
echo $EXA_API_KEY
```

### Permissions Issues
```bash
# Check settings.json permissions configuration
cat ~/.claude/settings.json | jq .permissions

# Add missing tool to allow list
# Edit ~/.claude/settings.json
```

### Python Version Not Showing (code_ai)
```bash
# Verify Python is in PATH
which python3
python3 --version

# Restart Claude Code to refresh status line
```

## 📚 Resources

### Documentation
- [Claude Code Official Docs](https://docs.claude.com/en/docs/claude-code)
- [MCP Documentation](https://modelcontextprotocol.io)
- [Anthropic Agent Skills](https://github.com/anthropics/anthropic-agent-skills)

### Tools & APIs
- [Exa API](https://exa.ai) - Neural search
- [Firecrawl](https://firecrawl.dev) - Web scraping
- [PyTorch](https://pytorch.org) - Deep learning framework
- [Weights & Biases](https://wandb.ai) - Experiment tracking

### Community
- [Claude Code GitHub](https://github.com/anthropics/claude-code)
- [MCP Servers](https://github.com/modelcontextprotocol/servers)

## 🤝 Contributing

Improvements and new setups welcome!

1. Fork the repository
2. Create your setup in a new directory
3. Add comprehensive README
4. Test thoroughly
5. Submit pull request

### Creating New Setups

When creating a new specialized setup:

1. **Define clear use case** - What specific workflow does this optimize?
2. **Configure permissions** - Allow only necessary tools
3. **Create specialized agents** - Domain experts for complex tasks
4. **Add useful commands** - Common workflows as slash commands
5. **Write comprehensive README** - Installation, usage, examples
6. **Test thoroughly** - Verify all features work as expected

## 📄 License

MIT License - See [LICENSE](LICENSE) file for details.

## 🆘 Support

For issues or questions:
1. Check the [Troubleshooting](#troubleshooting) section
2. Review individual setup READMEs
3. Consult [Claude Code documentation](https://docs.claude.com/en/docs/claude-code)
4. Open an issue on GitHub

---

## 📋 Quick Reference

### Setup Installation Commands

```bash
# General AI
cp -r general_ai/.claude ~/

# Code AI (Python/ML)
cp -r code_ai/.claude ~/

# Deep Research
cp -r deep_research/.claude ~/

# PowerPoint Builder
cp -r ppt_builder/.claude ~/

# OSINT / Investigative
cp -r osint_ai/.claude ~/

# Science / Academic
cp -r science_ai/.claude ~/

# Finance / Investment
cp -r finance_ai/.claude ~/
```

### Essential Files

```
~/.claude/
├── settings.json          # Core configuration
├── agents/               # Specialized agents
├── commands/             # Slash commands
└── skills/               # Auto-activating skills
```

### Common Commands by Setup

**general_ai:**
- `/graham [person]` - Talent evaluation
- `/deep-research [topic]` - Comprehensive research

**code_ai:**
- (Use agents automatically for code tasks)

**deep_research:**
- (Researcher agent auto-activates for research tasks)

**ppt_builder:**
- (Presentation-builder agent auto-activates for slides)

---

**Version**: 2.0
**Last Updated**: 2025-11-22
**Tested On**: macOS, Linux (Claude Code Desktop + CLI)
**Maintained By**: [maynard242](https://github.com/maynard242)

**Happy building with Claude Code!** 🚀
