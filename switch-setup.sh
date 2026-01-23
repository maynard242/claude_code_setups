#!/usr/bin/env bash
#
# Apply Claude Code Setup
# Installs the streamlined configuration to ~/.claude
#

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Paths
if [ -n "$BASH_SOURCE" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
fi
CLAUDE_DIR="$HOME/.claude"
SETUP_PATH="$SCRIPT_DIR/streamlined/.claude"

print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }

show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help"
    echo "  -l, --link     Symlink instead of copy (auto-updates)"
    echo "  -c, --current  Show current setup"
    echo "  -r, --restore  Restore from backup"
    echo ""
    echo "Examples:"
    echo "  $0             # Apply setup"
    echo "  $0 --link      # Symlink setup"
    echo "  $0 --restore   # Restore previous backup"
}

backup_current() {
    if [ -d "$CLAUDE_DIR" ] || [ -L "$CLAUDE_DIR" ]; then
        BACKUP_DIR="${CLAUDE_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
        print_info "Backing up to: $BACKUP_DIR"
        if [ -L "$CLAUDE_DIR" ]; then
            rm "$CLAUDE_DIR"
        else
            mv "$CLAUDE_DIR" "$BACKUP_DIR"
        fi
        print_success "Backup created"
    fi
}

apply_setup() {
    local use_symlink=${1:-false}

    echo ""
    echo "╔════════════════════════════════════════╗"
    echo "║  Claude Code Setup                     ║"
    echo "╚════════════════════════════════════════╝"
    echo ""

    backup_current

    if [ "$use_symlink" = true ]; then
        print_info "Creating symlink..."
        ln -s "$SETUP_PATH" "$CLAUDE_DIR"
        print_success "Symlinked: $CLAUDE_DIR -> $SETUP_PATH"
    else
        print_info "Copying setup..."
        cp -r "$SETUP_PATH" "$CLAUDE_DIR"
        print_success "Setup installed to $CLAUDE_DIR"
    fi

    echo ""
    print_info "Includes:"
    echo "  • 6 agents: researcher, developer, financial-analyst,"
    echo "              academic-writer, presentation-builder, statement-processor"
    echo "  • 3 commands: /graham, /deep-research, /process-statement"
    echo "  • MCP: Crawl4AI (web scraping) + Perplexity (AI search)"
    echo "  • Tools: Claude → WebSearch → WebFetch → Perplexity → Crawl4AI"
    echo ""
    print_warning "Environment variables needed for MCP:"
    echo "  • PERPLEXITY_API_KEY, CRAWL4AI_URL, CRAWL4AI_TOKEN"
    echo ""
    print_success "Done. Restart Claude Code to apply."
}

show_current() {
    if [ ! -e "$CLAUDE_DIR" ]; then
        print_warning "No setup found at $CLAUDE_DIR"
        return
    fi

    if [ -L "$CLAUDE_DIR" ]; then
        print_info "Current setup (symlinked): $(readlink "$CLAUDE_DIR")"
    else
        print_info "Current setup (copied): $CLAUDE_DIR"
    fi
}

restore_backup() {
    local backups=("$HOME"/.claude.backup.*)
    local count=0

    echo "Available backups:"
    for backup in "${backups[@]}"; do
        if [ -d "$backup" ]; then
            count=$((count + 1))
            echo "  $count) $(basename "$backup" | sed 's/\.claude\.backup\.//')"
        fi
    done

    if [ "$count" -eq 0 ]; then
        print_warning "No backups found"
        exit 1
    fi

    echo ""
    echo -n "Select backup (1-$count) or q to quit: "
    read -r choice

    [ "$choice" = "q" ] && exit 0

    local i=0
    for backup in "${backups[@]}"; do
        if [ -d "$backup" ]; then
            i=$((i + 1))
            if [ "$i" -eq "$choice" ]; then
                [ -e "$CLAUDE_DIR" ] && rm -rf "$CLAUDE_DIR"
                cp -r "$backup" "$CLAUDE_DIR"
                print_success "Restored from $backup"
                return
            fi
        fi
    done

    echo "Invalid choice"
    exit 1
}

case "${1:-}" in
    -h|--help) show_help ;;
    -l|--link) apply_setup true ;;
    -c|--current) show_current ;;
    -r|--restore) restore_backup ;;
    "") apply_setup false ;;
    *) echo "Unknown option: $1"; show_help; exit 1 ;;
esac
