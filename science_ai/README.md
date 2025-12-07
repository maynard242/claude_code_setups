# Scientific / Academic Writing Setup

Academic research and scientific writing configuration for Claude Code.

## Use Cases

- Research paper writing (IMRaD format)
- Literature reviews and meta-analyses
- Grant proposal preparation
- Statistical results reporting
- Peer review responses
- Thesis and dissertation chapters

## Features

### Specialized Agent
- **academic-writer**: Scientific writing specialist with proper citation, statistical reporting, and methodology expertise

### Auto-Approved Tools
- WebSearch, WebFetch
- LaTeX: pdflatex, bibtex, pandoc
- Python for analysis
- MCP: Exa (paper search), Firecrawl (content extraction)

### Status Line
Shows academic mode indicator with current directory

## Quick Start

```bash
# Install
cp -r science_ai/.claude ~/

# Or use setup switcher
./switch-setup.sh science_ai

# Test
claude
> "Help me write the methods section for my experiment"
> "Review this statistical reporting for APA compliance"
> "Draft a literature review on [topic]"
```

## Writing Standards

### Statistical Reporting
- Include test statistic, df, exact p-value
- Report effect sizes with confidence intervals
- Provide sample sizes

### Citation Practices
- Cite all claims from others
- Use appropriate density per section
- Follow consistent style (APA, AMA, etc.)

### Document Formats
- **Research Papers**: IMRaD structure
- **Literature Reviews**: Thematic synthesis
- **Grant Proposals**: Aims, Significance, Innovation, Approach

## Common Tasks

- Write/revise paper sections
- Format statistical results
- Create literature synthesis tables
- Respond to peer reviewers
- Convert between document formats
- Generate BibTeX citations

## Best For

- Graduate students writing papers
- Researchers preparing manuscripts
- Grant applicants
- Academic editors
- Scientific communicators
