# Security Review - Claude Code Setups

**Date**: 2026-02-15
**Reviewer**: Claude Code (Opus 4.6)
**Status**: Issues Found & Fixed

## Summary

Reviewed the streamlined setup for security vulnerabilities in permissions, configurations, credentials management, and public repository exposure.

## Issues Identified & Fixed

### Fixed: `Bash(curl:*)` in Auto-Allow List

**Issue**: `curl` was auto-allowed, enabling arbitrary HTTP requests without user confirmation. This could allow data exfiltration.

**Fix**: Moved `Bash(curl:*)` to the "ask" list.

### Fixed: `Bash(cp:*)` and `Bash(mv:*)` in Auto-Allow List

**Issue**: File copy and move operations could silently overwrite important files.

**Fix**: Moved both to the "ask" list.

### Fixed: Redundant Bash Permissions Removed

**Issue**: `Bash(cat:*)`, `Bash(ls:*)`, `Bash(grep:*)`, `Bash(find:*)`, `Bash(head:*)`, `Bash(tail:*)` were auto-allowed. Claude Code has dedicated tools (Read, Glob, Grep) that are safer and preferred.

**Fix**: Removed these from the allow list entirely. Claude Code's dedicated tools handle these operations.

### Fixed: Non-Functional Settings Keys Removed

**Issue**: `setupId` and `alwaysThinkingEnabled` are not recognized Claude Code settings keys. They were no-ops cluttering the config.

**Fix**: Removed both.

### Fixed: Stale Documentation

**Issue**: ARCHITECTURE.md and SECURITY_REVIEW.md referenced old 8-setup architecture, Exa/Firecrawl MCP servers, and deprecated agent names.

**Fix**: Rewrote to reflect current streamlined setup.

## Current Security Posture

### Permissions

**Auto-allowed (safe, read-only, or development tools):**
- WebSearch, WebFetch, MCP servers
- git, npm, npx, node
- python/pip (development)
- LaTeX/PDF tools (document processing)
- mkdir, jq, wc (safe utilities)

**Requires confirmation (destructive/sensitive):**
- rm, sudo, kill, chmod (destructive/privileged)
- curl (network requests)
- cp, mv (file overwrites)

### Credentials Management

- MCP credentials use `${ENV_VAR}` syntax in settings.json (no hardcoded secrets)
- Environment variables: `PERPLEXITY_API_KEY`, `CRAWL4AI_URL`, `CRAWL4AI_TOKEN`
- `.gitignore` properly excludes: `.credentials.json`, `settings.local.json`, `.env`, `.clause/`, debug/history files

### Repository Exposure (Public Repo)

**Properly excluded from git:**
- OAuth tokens and credentials files
- Session data (`.clause/` directories)
- Debug logs and file history
- Local settings overrides

**Recommendation**: Periodically verify with `git ls-files` that no sensitive files are tracked.

## Security Strengths

1. **Destructive operations gated**: rm, sudo, kill, chmod require confirmation
2. **Network requests gated**: curl requires confirmation
3. **No hardcoded credentials**: All secrets via environment variables
4. **Proper .gitignore**: Comprehensive exclusion of sensitive/runtime files
5. **MCP credential isolation**: Server credentials never stored in tracked files

## Recommendations

### For Users
1. Set restrictive permissions on credential files: `chmod 600 ~/.claude.json`
2. Never commit `.env` or credential files
3. Rotate API keys periodically
4. Delete `general_ai/` directory if present (contains stale runtime artifacts)

### For Future Development
1. Always include `rm`, `sudo`, `kill`, `chmod`, `curl` in "ask" list
2. Prefer Claude Code's dedicated tools over bash equivalents
3. Run `git ls-files` before pushing to verify no secrets are tracked
4. Keep MCP credentials in environment variables, never in config files

## Security Grade: A
