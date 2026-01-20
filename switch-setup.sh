#!/usr/bin/env bash
#
# Claude Code Setup Switcher
# Easily switch between different Claude Code configurations
# Compatible with bash and zsh
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory (compatible with bash and zsh)
if [ -n "$BASH_SOURCE" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
fi
CLAUDE_DIR="$HOME/.claude"

# Available setups
SETUPS="streamlined"

# Function to get setup description
get_description() {
    case "$1" in
        "streamlined")  echo "Universal setup with 6 agents, 3 commands, Firecrawl + Perplexity MCP" ;;
        *)              echo "Unknown setup" ;;
    esac
}

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Function to validate setup name (security)
validate_setup_name() {
    local name=$1
    if ! echo "$name" | grep -qE '^[a-z_]+$'; then
        print_error "Invalid setup name: $name"
        print_info "Setup names must contain only lowercase letters and underscores"
        exit 1
    fi
}

# Function to display header
show_header() {
    echo ""
    echo "╔════════════════════════════════════════╗"
    echo "║  Claude Code Setup Switcher            ║"
    echo "╚════════════════════════════════════════╝"
    echo ""
}

# Function to display available setups
show_setups() {
    echo "Available setups:"
    echo ""
    local i=1
    for setup in $SETUPS; do
        printf "  %d) %-16s - %s\n" "$i" "$setup" "$(get_description "$setup")"
        i=$((i + 1))
    done
    echo ""
}

# Function to get setup by index (1-based)
get_setup_by_index() {
    local index=$1
    local i=1
    for setup in $SETUPS; do
        if [ "$i" -eq "$index" ]; then
            echo "$setup"
            return
        fi
        i=$((i + 1))
    done
}

# Function to count setups
count_setups() {
    local count=0
    for _ in $SETUPS; do
        count=$((count + 1))
    done
    echo "$count"
}

# Function to check if setup exists
setup_exists() {
    local name=$1
    for setup in $SETUPS; do
        if [ "$setup" = "$name" ]; then
            return 0
        fi
    done
    return 1
}

# Function to list available backups
list_backups() {
    local count=0
    local i=1

    echo "Available backups:"
    echo ""

    for backup in "$HOME"/.claude.backup.*; do
        if [ -d "$backup" ]; then
            local timestamp=$(echo "$backup" | sed 's/.*\.backup\.//')
            local formatted_date=$(echo "$timestamp" | sed 's/_/ /' | sed 's/\([0-9]\{4\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)/\1-\2-\3/')
            printf "  %d) %s\n" "$i" "$formatted_date"
            i=$((i + 1))
            count=$((count + 1))
        fi
    done

    if [ "$count" -eq 0 ]; then
        print_warning "No backups found"
        return 1
    fi

    echo ""
    return 0
}

# Function to restore from backup
restore_backup() {
    local backups=""
    local count=0

    for backup in "$HOME"/.claude.backup.*; do
        if [ -d "$backup" ]; then
            backups="$backups $backup"
            count=$((count + 1))
        fi
    done

    if [ "$count" -eq 0 ]; then
        print_warning "No backups found"
        exit 1
    fi

    list_backups

    echo -n "Select backup to restore (1-$count) or (q)uit: "
    read -r choice

    if [ "$choice" = "q" ] || [ "$choice" = "Q" ]; then
        echo "Cancelled"
        exit 0
    fi

    if ! echo "$choice" | grep -qE '^[0-9]+$' || [ "$choice" -lt 1 ] || [ "$choice" -gt "$count" ]; then
        print_error "Invalid choice"
        exit 1
    fi

    # Get the selected backup
    local i=1
    local selected_backup=""
    for backup in "$HOME"/.claude.backup.*; do
        if [ -d "$backup" ]; then
            if [ "$i" -eq "$choice" ]; then
                selected_backup="$backup"
                break
            fi
            i=$((i + 1))
        fi
    done

    print_info "Restoring from: $selected_backup"

    # Remove current setup if exists
    if [ -d "$CLAUDE_DIR" ] || [ -L "$CLAUDE_DIR" ]; then
        rm -rf "$CLAUDE_DIR"
    fi

    # Restore backup
    cp -r "$selected_backup" "$CLAUDE_DIR"

    print_success "Backup restored successfully"
}

# Function to backup current setup
backup_current() {
    if [ -d "$CLAUDE_DIR" ]; then
        BACKUP_DIR="${CLAUDE_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
        print_info "Backing up current setup to: $BACKUP_DIR"
        mv "$CLAUDE_DIR" "$BACKUP_DIR"
        print_success "Backup created"
    else
        print_info "No existing setup found (first install)"
    fi
}

# Function to switch to a setup
switch_to_setup() {
    local setup=$1

    # Validate input
    validate_setup_name "$setup"

    local setup_path="$SCRIPT_DIR/$setup/.claude"

    if [ ! -d "$setup_path" ]; then
        print_error "Setup not found: $setup"
        exit 1
    fi

    print_info "Switching to: $setup"

    # Backup current setup if exists
    backup_current

    # Copy new setup
    print_info "Installing $setup configuration..."
    cp -r "$setup_path" "$CLAUDE_DIR"

    print_success "Setup switched to: $setup"
    echo ""
    print_info "Setup details:"

    case $setup in
        "streamlined")
            echo "  • 6 Consolidated Agents (all use Opus model):"
            echo "    - researcher: Web, academic, market research + OSINT"
            echo "    - developer: Python + ML/PyTorch development"
            echo "    - financial-analyst: Valuation and investment research"
            echo "    - academic-writer: Research papers, grants, LaTeX"
            echo "    - presentation-builder: PowerPoint design"
            echo "    - statement-processor: Bank statement processing"
            echo "  • 3 Slash Commands: /graham, /deep-research, /process-statement"
            echo "  • MCP Servers: Firecrawl + Perplexity (requires API keys)"
            ;;
    esac

    echo ""
    print_success "Ready to use! Start Claude Code and test your new setup."
}

# Function to create symlink
create_symlink() {
    local setup=$1

    # Validate input
    validate_setup_name "$setup"

    local setup_path="$SCRIPT_DIR/$setup/.claude"

    if [ ! -d "$setup_path" ]; then
        print_error "Setup not found: $setup"
        exit 1
    fi

    print_info "Creating symlink to: $setup"

    # Backup current setup if exists
    backup_current

    # Create symlink
    print_info "Symlinking $setup configuration..."
    ln -s "$setup_path" "$CLAUDE_DIR"

    print_success "Symlink created: $CLAUDE_DIR -> $setup_path"
    print_info "Changes to setup will be reflected immediately"
}

# Function to show current setup
show_current() {
    if [ ! -d "$CLAUDE_DIR" ]; then
        print_warning "No Claude Code setup found at: $CLAUDE_DIR"
        return
    fi

    if [ -L "$CLAUDE_DIR" ]; then
        local target=$(readlink "$CLAUDE_DIR")
        print_info "Current setup (symlinked):"
        echo "  $target"
    else
        print_info "Current setup (copied):"
        echo "  $CLAUDE_DIR"

        # Try to detect which setup
        if [ -f "$CLAUDE_DIR/settings.json" ]; then
            # First try to detect using setupId (preferred)
            local setup_id=$(grep -o '"setupId"[[:space:]]*:[[:space:]]*"[^"]*"' "$CLAUDE_DIR/settings.json" 2>/dev/null | sed 's/.*"setupId"[[:space:]]*:[[:space:]]*"\([^"]*\)"/\1/')
            if [ -n "$setup_id" ]; then
                echo "  Detected: $setup_id"
            else
                # Fallback to status line detection
                if grep -q "research mode" "$CLAUDE_DIR/settings.json"; then
                    echo "  Detected: deep_research (inferred)"
                elif grep -q "presentation mode" "$CLAUDE_DIR/settings.json"; then
                    echo "  Detected: ppt_builder (inferred)"
                elif grep -q "py_ver" "$CLAUDE_DIR/settings.json"; then
                    echo "  Detected: code_ai (inferred)"
                else
                    echo "  Detected: general_ai or custom (inferred)"
                fi
                print_info "Tip: Add setupId to settings.json for reliable detection"
            fi
        fi
    fi
}

# Main script
main() {
    show_header

    # Parse arguments
    case "${1:-}" in
        -h|--help)
            echo "Usage: $0 [OPTIONS] [SETUP]"
            echo ""
            echo "Options:"
            echo "  -h, --help      Show this help message"
            echo "  -l, --link      Create symlink instead of copy"
            echo "  -c, --current   Show current setup"
            echo "  -b, --backup    Backup current setup without switching"
            echo "  -r, --restore   Restore from a previous backup"
            echo "  -L, --list      List available backups"
            echo "  -i, --init-project  Copy CLAUDE.md template to current directory"
            echo ""
            show_setups
            echo "Quick Switch Examples:"
            echo "  $0 streamlined        # Universal setup with all capabilities"
            echo ""
            echo "Other Examples:"
            echo "  $0                    # Interactive menu"
            echo "  $0 --link streamlined # Symlink (auto-updates)"
            echo "  $0 --current          # Show active setup"
            echo "  $0 --restore          # Restore from backup"
            echo ""
            echo "Direct Installation (without this script):"
            echo "  cp -r streamlined/.claude ~/        # Copy setup"
            echo "  ln -s \"\$(pwd)/streamlined/.claude\" ~/  # Symlink setup"
            echo ""
            echo "After switching, restart Claude Code to apply changes."
            ;;
        -c|--current)
            show_current
            ;;
        -b|--backup)
            if [ -d "$CLAUDE_DIR" ]; then
                backup_current
            else
                print_warning "No setup to backup"
            fi
            ;;
        -r|--restore)
            restore_backup
            ;;
        -L|--list)
            list_backups
            ;;
        -i|--init-project)
            local template_path="$SCRIPT_DIR/templates/CLAUDE.md"
            if [ ! -f "$template_path" ]; then
                print_error "Template not found: $template_path"
                exit 1
            fi
            if [ -f "CLAUDE.md" ]; then
                print_warning "CLAUDE.md already exists in current directory"
                exit 1
            fi
            cp "$template_path" "CLAUDE.md"
            print_success "Created CLAUDE.md in current directory"
            ;;
        -l|--link)
            if [ -z "${2:-}" ]; then
                print_error "Please specify a setup to link"
                exit 1
            fi
            create_symlink "$2"
            ;;
        "")
            # Interactive mode
            show_setups
            local num_setups=$(count_setups)
            echo -n "Select setup (1-$num_setups) or (q)uit: "
            read -r choice

            if [ "$choice" = "q" ] || [ "$choice" = "Q" ]; then
                echo "Cancelled"
                exit 0
            fi

            if ! echo "$choice" | grep -qE '^[0-9]+$' || [ "$choice" -lt 1 ] || [ "$choice" -gt "$num_setups" ]; then
                print_error "Invalid choice"
                exit 1
            fi

            switch_to_setup "$(get_setup_by_index "$choice")"
            ;;
        *)
            # Direct setup name provided
            if setup_exists "$1"; then
                switch_to_setup "$1"
            else
                print_error "Unknown setup: $1"
                echo ""
                show_setups
                exit 1
            fi
            ;;
    esac
}

main "$@"
