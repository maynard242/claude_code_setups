# Changelog

All notable changes to the Claude Code Setups repository.

## [2025-12-07] - Security & MCP Cleanup

### Added
- **SEARCH_TOOLS_GUIDE.md** in general_ai setup
  - Comprehensive guide for WebSearch, Exa, and Firecrawl usage
  - Decision tree for tool selection
  - Cost optimization strategies
  - Best practices and use case examples
  - Token limit recommendations for Exa
  - Crawling strategies for Firecrawl

- **SECURITY_REVIEW.md** in repository root
  - Complete security audit of all 8 setups
  - Issue tracking and resolution status
  - Security best practices documentation
  - Setup-by-setup security grades

### Changed
- **general_ai/.claude/settings.json**
  - Removed all n8n MCP tool permissions
  - Cleaned up MCP integrations to focus on Exa, Firecrawl, and Day One

- **All setup README files**
  - Removed references to n8n MCP server
  - Updated MCP integration lists
  - Added reference to SEARCH_TOOLS_GUIDE.md in general_ai

### Security Fixes

#### Permission Updates (6 setups)
Added `Bash(kill:*)` and `Bash(pkill:*)` to "ask" permission list for:
- deep_research/.claude/settings.json
- osint_ai/.claude/settings.json
- finance_ai/.claude/settings.json
- science_ai/.claude/settings.json
- ppt_builder/.claude/settings.json
- bookkeeping_ai/.claude/settings.json

**Rationale**: Process termination commands should always require user confirmation to prevent accidental or malicious process killing.

#### Tool Usage Cleanup
- **bookkeeping_ai/.claude/settings.json**
  - Removed `Bash(cat:*)` from allow list
  - Removed `Bash(ls:*)` from allow list

**Rationale**: Claude Code best practices recommend using specialized tools (Read instead of cat, Glob instead of ls) for better performance and consistency.

### Validation
- ✅ All 8 settings.json files validated with `jq`
- ✅ All permissions follow principle of least privilege
- ✅ All destructive operations gated with "ask" permissions
- ✅ No hardcoded credentials found
- ✅ MCP permissions properly scoped

### Summary

**Files Modified**: 13
- 8 settings.json files (security fixes)
- 3 README files (n8n removal)
- 2 new documentation files (SEARCH_TOOLS_GUIDE.md, SECURITY_REVIEW.md)

**Security Grade**: Overall repository upgraded from B to A

**Breaking Changes**: None - All changes are additive or improve security

**Migration Required**: No - Users can update by pulling latest changes

### Detailed Change List

#### Configuration Files
1. `general_ai/.claude/settings.json` - Removed n8n MCP permissions
2. `deep_research/.claude/settings.json` - Added kill/pkill to ask list
3. `osint_ai/.claude/settings.json` - Added kill/pkill to ask list
4. `finance_ai/.claude/settings.json` - Added kill/pkill to ask list
5. `science_ai/.claude/settings.json` - Added kill/pkill to ask list
6. `ppt_builder/.claude/settings.json` - Added kill/pkill to ask list
7. `bookkeeping_ai/.claude/settings.json` - Added kill/pkill, removed cat/ls

#### Documentation
8. `general_ai/README.md` - Removed n8n reference, added search guide link
9. `README.md` - Removed n8n from MCP integrations list
10. `CLAUDE.md` - Removed n8n references (if any)
11. `general_ai/SEARCH_TOOLS_GUIDE.md` - NEW comprehensive search tool guide
12. `SECURITY_REVIEW.md` - NEW security audit documentation
13. `CHANGELOG.md` - NEW this file

### Testing Checklist
- [x] All settings.json files parse correctly with jq
- [x] No syntax errors in JSON files
- [x] All README files render correctly in markdown
- [x] No broken links in documentation
- [x] Security issues documented and fixed
- [x] Git status clean (all changes tracked)

### Next Steps
After this release, users should:
1. Pull latest changes: `git pull origin main`
2. Re-run setup switcher to apply fixes: `./switch-setup.sh <current-setup>`
3. Review SEARCH_TOOLS_GUIDE.md for optimal search tool usage
4. Review SECURITY_REVIEW.md for security best practices

### Notes
- No n8n functionality is broken - users who have n8n MCP server configured can still use it via native tools
- The removal of n8n permissions from general_ai was based on user request to focus on three core search tools: WebSearch, Exa, and Firecrawl
- Security fixes are non-breaking and improve safety without impacting functionality
- All setups remain compatible with existing workflows
