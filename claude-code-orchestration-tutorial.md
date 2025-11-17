# Claude Code: 10-Step Tutorial for Orchestration & Automation

A comprehensive guide focused on file operations, optimal setup, agents, skills, and orchestration workflows with Claude Code.

---

## Step 1: Understanding Claude Code's Architecture

**Goal:** Learn how Claude Code orchestrates complex tasks

Claude Code is more than a chat interface—it's an orchestration platform that:
- **Delegates to specialized agents** for complex multi-step tasks
- **Uses skills** (specialized prompts) for domain-specific workflows
- **Coordinates tools** (file ops, web research, MCP servers) in parallel
- **Manages state** through todo lists and task tracking

**Key Concepts:**
- **Agents:** Autonomous subprocesses that handle specific task types
- **Skills:** Pre-built workflows for common operations
- **MCP Servers:** External tool integrations (n8n, Firecrawl, Exa)
- **Orchestration:** Running multiple operations in parallel

**Try it:**
```
"Explain the difference between you running a task vs delegating to an agent"
"What skills do you have access to?"
```

---

## Step 2: Optimal Setup & Configuration

**Goal:** Configure Claude Code for maximum effectiveness

### Project Structure
Create a `.claude/` directory in your project:
```
your-project/
├── .claude/
│   ├── commands/          # Custom slash commands
│   │   └── example.md
│   └── config.json        # Configuration (optional)
├── CLAUDE.md              # Project instructions
└── your files...
```

### CLAUDE.md - Project Instructions
This file tells Claude how to work with your project:
```markdown
# Project Guide

## Overview
What this project does and its purpose

## Structure
Key directories and files

## Workflows
Common tasks and how to execute them

## Tools & Integrations
MCP servers, APIs, external services
```

### Custom Commands
Create `.claude/commands/yourcommand.md`:
```markdown
# Command: /yourcommand
Perform a specific workflow:
1. Step one
2. Step two
3. Step three
```

**Try it:**
1. Create a `.claude/` directory
2. Create a `CLAUDE.md` file describing your project
3. Create a custom command for a repetitive task

---

## Step 3: File Operations Mastery

**Goal:** Efficiently read, search, and organize files

### Reading Files
Claude can read multiple files in parallel:
```
"Read package.json, tsconfig.json, and README.md"
```

### Searching Across Files
```
"Find all markdown files in the docs/ directory"
"Search for TODO comments across the entire codebase"
"List all files that contain 'API_KEY'"
```

### Organizing & Batch Operations
```
"Rename all .js files to .ts in the src/ directory"
"Move all test files to a tests/ directory"
"Create a directory structure for a new feature module"
```

### File Patterns (Glob)
```
"Find all TypeScript files: **/*.ts"
"Find all test files: **/*.test.js"
"Find all configs: **/*config*"
```

**Try it:**
1. Ask Claude to find all files matching a pattern
2. Request reading multiple files in parallel
3. Organize files into a new structure

**Pro tip:** For complex searches, Claude will automatically use specialized search agents.

---

## Step 4: Understanding Agent Orchestration

**Goal:** Learn when and how Claude delegates to agents

### Available Agents

**1. general-purpose**
- Complex multi-step research tasks
- File searches requiring multiple attempts
- When the answer isn't immediately obvious

**2. Explore Agent**
- Codebase exploration
- Understanding architecture
- Finding patterns and connections
- **Use for:** "How does X work?", "Where is Y handled?"

**3. Plan Agent**
- Planning complex implementations
- Breaking down large tasks
- Design decisions

**4. web-researcher**
- Current information gathering
- Documentation scraping
- API research
- Finding code examples online

### When Claude Uses Agents
Claude automatically delegates when:
- The task requires multiple search attempts
- Deep codebase exploration is needed
- Web research is required
- Complex multi-step workflows

**Try it:**
```
"Explore how error handling works across the codebase"
"Research the latest n8n workflow patterns and best practices"
"Find all the places where user data is processed"
```

**Watch for:** Claude will say "I'm going to use the [agent-type] agent..."

---

## Step 5: Skills - Pre-Built Workflows

**Goal:** Leverage specialized skills for common tasks

### Available Skills (Document Skills)
- **xlsx:** Spreadsheet creation, editing, analysis
- **docx:** Document creation, editing, tracked changes
- **pptx:** Presentation creation and editing
- **pdf:** PDF manipulation, extraction, form filling

### Available Skills (Creative & Development)
- **skill-creator:** Guide for creating custom skills
- **mcp-builder:** Build MCP servers
- **canvas-design:** Visual art creation
- **algorithmic-art:** Generative art with p5.js
- **webapp-testing:** Testing web applications with Playwright
- **artifacts-builder:** Complex HTML artifacts

### Available Skills (Communication & Automation)
- **internal-comms:** Write internal communications
- **slack-gif-creator:** Create animated GIFs for Slack
- **theme-factory:** Style artifacts with themes
- **brand-guidelines:** Apply brand standards

### Using Skills
```
"Use the xlsx skill to analyze this sales data"
"Use the pdf skill to extract tables from this report"
"Use the web-researcher agent to find current n8n documentation"
```

**Try it:**
1. List all available skills: Ask "What skills do you have?"
2. Use a document skill to create or edit a file
3. Use a creative skill to generate something

---

## Step 6: Web Research Orchestration

**Goal:** Efficiently gather information from the web

### Available Research Tools

**Exa Search (via MCP)**
- `web_search_exa`: General web search with content extraction
- `get_code_context_exa`: Code-specific search for APIs/SDKs

**Firecrawl (via MCP)**
- `firecrawl_scrape`: Extract content from specific URLs
- `firecrawl_search`: Search and scrape in one operation
- `firecrawl_map`: Discover all URLs on a website
- `firecrawl_crawl`: Comprehensive multi-page crawling
- `firecrawl_extract`: LLM-powered structured data extraction

### Research Workflows

**Pattern 1: Quick Research**
```
"Search the web for current best practices in n8n workflow design"
```
Claude uses: `web_search_exa` or `firecrawl_search`

**Pattern 2: Documentation Deep Dive**
```
"Scrape the n8n documentation and summarize webhook setup"
```
Claude uses: `firecrawl_scrape` or `firecrawl_map` + `firecrawl_scrape`

**Pattern 3: Structured Data Extraction**
```
"Extract pricing information from these competitor websites: [urls]"
```
Claude uses: `firecrawl_extract` with JSON schema

**Try it:**
1. Ask Claude to research a technology you're interested in
2. Request scraping documentation from a specific site
3. Extract structured data from multiple web pages

---

## Step 7: MCP Server Integration (n8n Focus)

**Goal:** Understand and use MCP servers for automation

### What is MCP?
Model Context Protocol allows Claude to interact with external services:
- **n8n:** Workflow automation platform
- **Firecrawl:** Web scraping and extraction
- **Exa:** Intelligent web search
- **Custom servers:** Build your own integrations

### n8n MCP Tools Available

**Node Discovery:**
```
"List all n8n trigger nodes"
"Search for webhook-related nodes in n8n"
"Get documentation for the Slack node"
```

**Workflow Management:**
```
"List all my n8n workflows"
"Create a new n8n workflow with a webhook trigger"
"Validate this n8n workflow configuration"
```

**Templates:**
```
"Find n8n templates for Slack automation"
"Search n8n templates for AI workflows"
"Get the most popular n8n templates"
```

### Common n8n Orchestration Patterns

**Pattern 1: Discover → Design → Create**
```
1. "Search for n8n nodes that work with Google Sheets"
2. "Get documentation for the Google Sheets node"
3. "Create a workflow that updates a sheet when webhook receives data"
```

**Pattern 2: Template → Customize → Deploy**
```
1. "Find n8n templates for email automation"
2. "Get template #12345 and show me its structure"
3. "Create a modified version with Slack notifications"
```

**Try it:**
1. Ask Claude to search for n8n nodes
2. Request creating a simple n8n workflow
3. Find and customize an n8n template

---

## Step 8: Parallel Orchestration

**Goal:** Run multiple operations simultaneously

### Why Parallel Execution Matters
- Faster task completion
- Efficient resource usage
- Better user experience

### When Claude Runs Tasks in Parallel

**Automatic Parallelization:**
```
"Read config.json, package.json, and README.md"
```
Claude reads all three files simultaneously.

**Multiple Independent Searches:**
```
"Find all TODO comments and all FIXME comments"
```
Claude runs both searches at once.

**Research + Local Operations:**
```
"Research n8n webhook best practices while organizing my docs folder"
```
Web research and file operations run in parallel.

### Requesting Parallel Agent Execution
```
"Run three agents in parallel:
1. Explore how authentication works
2. Research current JWT best practices
3. Find all API endpoint definitions"
```

**Important:** Explicitly say "in parallel" to ensure parallel execution.

**Try it:**
1. Request reading multiple files
2. Ask for multiple independent searches
3. Explicitly request parallel agent execution

---

## Step 9: Task Planning & Todo Lists

**Goal:** Use todo lists for complex orchestration

### How Todo Lists Work
Claude automatically creates and manages todos for:
- Multi-step tasks (3+ steps)
- Complex non-trivial work
- User-provided task lists

### Todo States
- **⏳ pending:** Not started yet
- **→ in_progress:** Currently working (only ONE at a time)
- **✓ completed:** Finished successfully

### Orchestration Example

**You ask:**
```
"Set up a complete documentation system with:
- Web scraping for competitor research
- Markdown file organization
- N8n workflow for automated updates
- Search functionality"
```

**Claude creates todos:**
```
1. → Research web scraping tools and approaches
2. ⏳ Set up directory structure for documentation
3. ⏳ Create n8n workflow for web scraping
4. ⏳ Organize markdown files
5. ⏳ Implement search functionality
6. ⏳ Test end-to-end workflow
```

### Watching the Orchestration
As Claude works, you'll see:
- Todos update in real-time
- Parallel operations when possible
- Agents being launched for sub-tasks
- Clear progress indicators

**Try it:**
Ask for a complex multi-step project and watch how Claude:
1. Breaks it into todos
2. Delegates to agents
3. Runs parallel operations
4. Tracks completion

---

## Step 10: Advanced Orchestration Patterns

**Goal:** Master complex multi-agent workflows

### Pattern 1: Research → Plan → Execute
```
"I want to build an automated content pipeline using n8n"

Claude's orchestration:
1. 🔍 web-researcher agent → Find n8n content automation examples
2. 📋 Plan agent → Design the pipeline architecture
3. 🔧 general-purpose agent → Create n8n workflow
4. ✅ Validate and test
```

### Pattern 2: Explore → Extract → Transform
```
"Analyze competitor websites and create a comparison spreadsheet"

Claude's orchestration:
1. 🌐 firecrawl_map → Discover all competitor pages
2. 📥 firecrawl_extract (parallel) → Extract structured data
3. 📊 xlsx skill → Create formatted spreadsheet
4. 📈 Generate insights and summary
```

### Pattern 3: Multi-Source Intelligence Gathering
```
"Create a comprehensive report on n8n best practices"

Claude's orchestration:
1. 🔍 web_search_exa → Current articles and discussions
2. 📄 firecrawl_scrape → Official documentation
3. 🎯 get_code_context_exa → Code examples and patterns
4. 📚 Explore agent → Find local examples (if any)
5. 📝 Synthesize into structured report
```

### Pattern 4: Workflow Creation & Validation
```
"Design, create, and validate an n8n workflow for Slack notifications"

Claude's orchestration:
1. 🔍 Search n8n nodes and templates
2. 📋 Plan workflow structure
3. 🔧 Create workflow using n8n MCP
4. ✓ Validate workflow configuration
5. 🧪 Suggest testing approach
```

### Creating Custom Orchestration Commands

Create `.claude/commands/research-report.md`:
```markdown
# Research Report Generator

When I use /research-report [topic], you should:

1. Use web-researcher agent to gather current information
2. Use firecrawl to scrape relevant documentation
3. Use get_code_context_exa if topic is technical
4. Create a structured markdown report
5. Include sources and links
6. Save to ./reports/[topic]-[date].md
```

**Try it:**
1. Design a custom orchestration workflow
2. Create a slash command for it
3. Test with a real use case
4. Refine based on results

---

## Bonus: Real-World Orchestration Examples

### Example 1: Documentation System Setup
```
"Set up a documentation system that:
- Scrapes n8n docs weekly
- Organizes content by category
- Creates searchable index
- Stores in markdown format"

Claude orchestrates:
- firecrawl_map → Discover doc pages
- n8n workflow → Schedule weekly scraping
- File operations → Organize structure
- Create search utility
```

### Example 2: Competitive Intelligence
```
"Monitor competitor websites and alert me of changes"

Claude orchestrates:
- firecrawl_crawl → Initial scrape
- n8n workflow → Scheduled checks
- firecrawl change tracking → Detect changes
- Slack integration → Send alerts
```

### Example 3: Content Aggregation
```
"Aggregate AI news from multiple sources daily"

Claude orchestrates:
- web_search_exa → Find latest AI news
- firecrawl_search → Scrape articles
- xlsx skill → Create tracking spreadsheet
- n8n workflow → Automate daily runs
```

---

## Best Practices for Orchestration

### 1. Be Explicit About Parallelization
❌ "Do task A and task B"
✅ "Do task A and task B in parallel"

### 2. Break Complex Tasks into Phases
❌ "Set up everything for my project"
✅ "First research options, then plan structure, then implement"

### 3. Leverage Agents for Their Strengths
- **Explore:** Understanding existing systems
- **web-researcher:** Current information
- **general-purpose:** Multi-step execution

### 4. Use Skills for Specialized Tasks
- Document manipulation → Document skills
- Web scraping → Firecrawl tools
- Code context → Exa code search

### 5. Monitor Todo Lists
Watch for:
- Tasks stuck in progress
- Unexpected delegation to agents
- Opportunities for parallelization

---

## Practice Projects

### Project 1: Personal Knowledge Base
Build an automated system that:
- Scrapes interesting articles
- Organizes by topic
- Creates searchable index
- Updates via n8n workflow

### Project 2: Competitor Monitor
Create a monitoring system that:
- Tracks competitor websites
- Detects changes
- Extracts pricing data
- Alerts via Slack/email

### Project 3: Research Assistant
Build a workflow that:
- Takes a research topic
- Gathers information from multiple sources
- Creates structured reports
- Maintains citation database

### Project 4: Content Pipeline
Design an automation that:
- Finds relevant content
- Extracts key information
- Transforms to your format
- Distributes via multiple channels

---

## Next Steps

You now understand:
- ✅ File operations and organization
- ✅ Optimal setup with CLAUDE.md and custom commands
- ✅ Agent orchestration and delegation
- ✅ Skills for specialized workflows
- ✅ MCP server integration (n8n, Firecrawl, Exa)
- ✅ Parallel execution patterns
- ✅ Complex multi-agent orchestration

### Continue Learning
1. Experiment with custom slash commands
2. Build a personal automation project
3. Create multi-agent workflows
4. Integrate external services via MCP
5. Share your orchestration patterns

### Resources
- MCP Documentation: https://modelcontextprotocol.io
- n8n Documentation: https://docs.n8n.io
- Claude Code Docs: https://docs.claude.com/claude-code
- Custom Skills Guide: Use the `skill-creator` skill

---

**Remember:** Claude Code is an orchestration platform. Your role is to design workflows, and Claude handles the coordination, delegation, and execution.

Happy orchestrating! 🎯
