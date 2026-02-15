# Changelog

All notable changes to the Claude Code Setups repository.

## [2026-01-23] - v2.3 Streamlined Consolidation

### Changed

- **Consolidated to single streamlined setup**
  - Combines best features from all previous setups

- **Enhanced researcher agent**
  - Merged OSINT/investigator capabilities into researcher
  - Added investigation protocol for background research
  - Added confidence scoring system (90-100%, 70-89%, etc.)
  - Added ethical guidelines for investigations
  - Unified research and investigation output formats

- **Updated MCP servers**
  - Replaced Exa/Firecrawl with Crawl4AI + Perplexity
  - Fixed perplexity package name (`@perplexity-ai/mcp-server`)
  - Added environment variable support for credentials

- **Simplified documentation**
  - README.md rewritten for streamlined-only setup
  - GETTING_STARTED.md simplified
  - QUICK_REFERENCE.md updated
  - CLAUDE.md updated for new structure
  - MCP_SETUP.md rewritten for Crawl4AI + Perplexity

- **Updated switch-setup.sh**
  - Removed 8-setup menu (only streamlined now)
  - Simplified to install/link/restore commands

### Removed

- Interactive 8-setup menu from switch-setup.sh
- References to Exa, Firecrawl, Day One MCP servers
- Separate investigator and web-researcher agents (merged into researcher)

---

## [2026-01-14] - v2.2 Documentation & Improvements

### Added
- **unified setup** - New all-in-one configuration (9th setup)
  - Combines all 9 specialized agents in one setup
  - Includes all 3 slash commands
  - Recommended as default setup for most users

- **GETTING_STARTED.md** - Complete onboarding guide
- **QUICK_REFERENCE.md** - Comprehensive cheat sheet
- **MCP_SETUP.md** - Complete MCP server configuration guide
- **ARCHITECTURE.md** - Deep architectural documentation

### Changed
- README.md - Added Documentation section
- CLAUDE.md - MCP configuration clarifications

---

## [2025-12-07] - Security & MCP Cleanup

### Added
- **SEARCH_TOOLS_GUIDE.md** in general_ai setup
- **SECURITY_REVIEW.md** - Complete security audit

### Changed
- Removed n8n MCP tool permissions
- Added kill/pkill to "ask" permission list for 6 setups
- Removed cat/ls from bookkeeping_ai allow list

### Security
- All settings.json files validated
- All destructive operations gated with "ask" permissions
- No hardcoded credentials
- Security grade upgraded from B to A

---

## Version Summary

| Version | Date | Key Changes |
|---------|------|-------------|
| v2.3 | 2026-01-23 | Streamlined consolidation, Crawl4AI+Perplexity MCP |
| v2.2 | 2026-01-14 | Unified setup, comprehensive docs |
| v2.1 | 2025-12-07 | Security fixes, n8n removal |
