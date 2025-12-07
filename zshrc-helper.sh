#!/usr/bin/env zsh
# Claude Code Setup Switcher - ZSH Helper Functions
# Add this to your ~/.zshrc file
#
# Usage:
#   source /path/to/claude_code_setups/zshrc-helper.sh
#   Or copy functions to ~/.zshrc

# Configuration
export CLAUDE_SETUPS_DIR="${CLAUDE_SETUPS_DIR:-$HOME/data/Setups/claude_code_setups}"
export CLAUDE_CONFIG_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

# Main function - switch Claude Code setup
claude-setup() {
    local setup_name="$1"
    local action="${2:-switch}"

    # If no arguments, show help
    if [[ -z "$setup_name" ]]; then
        _claude_setup_help
        return 0
    fi

    # Handle special commands
    case "$setup_name" in
        -h|--help|help)
            _claude_setup_help
            return 0
            ;;
        -l|--list|list)
            _claude_setup_list
            return 0
            ;;
        -c|--current|current)
            _claude_setup_current
            return 0
            ;;
        -b|--backup|backup)
            _claude_setup_backup
            return 0
            ;;
    esac

    # Validate setup exists
    if [[ ! -d "$CLAUDE_SETUPS_DIR/$setup_name" ]]; then
        echo "❌ Setup not found: $setup_name"
        echo ""
        _claude_setup_list
        return 1
    fi

    # Perform the switch
    if [[ "$action" == "link" ]]; then
        _claude_setup_symlink "$setup_name"
    else
        _claude_setup_copy "$setup_name"
    fi
}

# List available setups
_claude_setup_list() {
    echo "Available Claude Code setups:"
    echo ""

    local setups=(
        "general_ai:General-purpose assistant (research, docs, creativity)"
        "code_ai:Python/ML/AI development (PyTorch, testing, MLOps)"
        "deep_research:Research specialist (academic, market analysis)"
        "ppt_builder:PowerPoint builder (presentations, pitch decks)"
        "osint_ai:OSINT/Investigative research (background checks)"
        "science_ai:Scientific/Academic writing (papers, grants)"
        "finance_ai:Financial/Investment research (stocks, valuation)"
        "bookkeeping_ai:Bookkeeping/Personal finance (statements, expenses)"
    )

    for setup in "${setups[@]}"; do
        local name="${setup%%:*}"
        local desc="${setup#*:}"

        if [[ -d "$CLAUDE_SETUPS_DIR/$name" ]]; then
            printf "  %-20s - %s\n" "$name" "$desc"
        fi
    done

    echo ""
    echo "Usage:"
    echo "  claude-setup <name>              # Copy setup to ~/.claude"
    echo "  claude-setup <name> link         # Symlink setup (auto-updates)"
    echo "  claude-setup --current           # Show current setup"
    echo "  claude-setup --backup            # Backup current setup"
}

# Show current setup
_claude_setup_current() {
    if [[ ! -d "$CLAUDE_CONFIG_DIR" ]]; then
        echo "⚠️  No Claude Code setup found at: $CLAUDE_CONFIG_DIR"
        return 1
    fi

    if [[ -L "$CLAUDE_CONFIG_DIR" ]]; then
        local target=$(readlink "$CLAUDE_CONFIG_DIR")
        echo "📍 Current setup (symlinked):"
        echo "   $target"
    else
        echo "📍 Current setup (copied):"
        echo "   $CLAUDE_CONFIG_DIR"

        # Try to detect which setup
        if [[ -f "$CLAUDE_CONFIG_DIR/settings.json" ]]; then
            local setup_id=$(grep -o '"setupId"[[:space:]]*:[[:space:]]*"[^"]*"' "$CLAUDE_CONFIG_DIR/settings.json" 2>/dev/null | sed 's/.*"setupId"[[:space:]]*:[[:space:]]*"\([^"]*\)"/\1/')
            if [[ -n "$setup_id" ]]; then
                echo "   Detected: $setup_id"
            else
                echo "   Detected: Unknown (add 'setupId' to settings.json)"
            fi
        fi
    fi
}

# Backup current setup
_claude_setup_backup() {
    if [[ ! -d "$CLAUDE_CONFIG_DIR" ]]; then
        echo "⚠️  No setup to backup"
        return 1
    fi

    local backup_dir="${CLAUDE_CONFIG_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    echo "💾 Backing up to: $backup_dir"

    if [[ -L "$CLAUDE_CONFIG_DIR" ]]; then
        # If it's a symlink, just note it
        local target=$(readlink "$CLAUDE_CONFIG_DIR")
        echo "   (Current setup is a symlink to: $target)"
        echo "   No backup needed for symlinks"
    else
        mv "$CLAUDE_CONFIG_DIR" "$backup_dir"
        echo "✅ Backup created"
    fi
}

# Copy setup to ~/.claude
_claude_setup_copy() {
    local setup_name="$1"
    local setup_path="$CLAUDE_SETUPS_DIR/$setup_name/.claude"

    echo "🔄 Switching to: $setup_name (copy mode)"

    # Backup current if exists
    if [[ -d "$CLAUDE_CONFIG_DIR" ]] || [[ -L "$CLAUDE_CONFIG_DIR" ]]; then
        _claude_setup_backup
    fi

    # Copy new setup
    cp -r "$setup_path" "$CLAUDE_CONFIG_DIR"

    echo "✅ Setup switched to: $setup_name"
    echo ""
    echo "🚀 Restart Claude Code to apply changes"
}

# Symlink setup to ~/.claude
_claude_setup_symlink() {
    local setup_name="$1"
    local setup_path="$CLAUDE_SETUPS_DIR/$setup_name/.claude"

    echo "🔗 Linking to: $setup_name (symlink mode)"

    # Backup current if exists
    if [[ -d "$CLAUDE_CONFIG_DIR" ]] || [[ -L "$CLAUDE_CONFIG_DIR" ]]; then
        _claude_setup_backup
    fi

    # Create symlink
    ln -s "$setup_path" "$CLAUDE_CONFIG_DIR"

    echo "✅ Symlink created: $CLAUDE_CONFIG_DIR -> $setup_path"
    echo "   Changes to setup will be reflected immediately"
    echo ""
    echo "🚀 Restart Claude Code to apply changes"
}

# Help message
_claude_setup_help() {
    cat << 'EOF'
Claude Code Setup Switcher

Usage:
  claude-setup <name>              Switch to a setup (copy mode)
  claude-setup <name> link         Switch to a setup (symlink mode)
  claude-setup --list              List available setups
  claude-setup --current           Show current setup
  claude-setup --backup            Backup current setup
  claude-setup --help              Show this help

Examples:
  claude-setup general_ai          # General-purpose assistant
  claude-setup code_ai link        # Python/ML dev (auto-updates)
  claude-setup --current           # Show what's active

Setup Modes:
  Copy mode:    Setup is copied to ~/.claude (won't auto-update)
  Symlink mode: Setup is symlinked (auto-updates when repo changes)

Environment Variables:
  CLAUDE_SETUPS_DIR    Path to setups repo (default: ~/data/Setups/claude_code_setups)
  CLAUDE_CONFIG_DIR    Path to Claude config (default: ~/.claude)
EOF
}

# Shell completion for ZSH
_claude_setup_completion() {
    local -a setups
    setups=(
        'general_ai:General-purpose assistant'
        'code_ai:Python/ML development'
        'deep_research:Research specialist'
        'ppt_builder:PowerPoint builder'
        'osint_ai:OSINT research'
        'science_ai:Scientific writing'
        'finance_ai:Financial analysis'
        'bookkeeping_ai:Bookkeeping'
        '--list:List available setups'
        '--current:Show current setup'
        '--backup:Backup current setup'
        '--help:Show help'
    )

    _describe 'claude-setup' setups
}

compdef _claude_setup_completion claude-setup

# Aliases for convenience
alias cs='claude-setup'
alias csl='claude-setup --list'
alias csc='claude-setup --current'
alias csb='claude-setup --backup'

echo "✅ Claude Code setup functions loaded"
echo "   Type 'claude-setup --help' for usage"
