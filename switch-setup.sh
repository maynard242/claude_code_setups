#!/bin/bash
#
# Claude Code Setup Switcher
# Easily switch between different Claude Code configurations
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

# Available setups
SETUPS=("general_ai" "code_ai" "deep_research" "ppt_builder")

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
    echo "  1) general_ai      - General-purpose assistant (research, docs, creativity)"
    echo "  2) code_ai         - Python/ML/AI development (PyTorch, testing, MLOps)"
    echo "  3) deep_research   - Research specialist (academic, market analysis)"
    echo "  4) ppt_builder     - PowerPoint builder (presentations, pitch decks)"
    echo ""
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
        "general_ai")
            echo "  • Multi-source web research"
            echo "  • Document creation (PDF, DOCX, XLSX, PPTX)"
            echo "  • Commands: /graham, /deep-research"
            ;;
        "code_ai")
            echo "  • Python 3.10+ development"
            echo "  • PyTorch & ML engineering"
            echo "  • Agents: python-expert, ml-engineer"
            ;;
        "deep_research")
            echo "  • Academic & market research"
            echo "  • Competitive intelligence"
            echo "  • Agent: researcher (evidence-based analysis)"
            ;;
        "ppt_builder")
            echo "  • PowerPoint presentation design"
            echo "  • Agent: presentation-builder"
            echo "  • Templates: pitch decks, reports, training"
            ;;
    esac

    echo ""
    print_success "Ready to use! Start Claude Code and test your new setup."
}

# Function to create symlink
create_symlink() {
    local setup=$1
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

        # Try to detect which setup based on status line
        if [ -f "$CLAUDE_DIR/settings.json" ]; then
            if grep -q "research mode" "$CLAUDE_DIR/settings.json"; then
                echo "  Detected: deep_research"
            elif grep -q "presentation mode" "$CLAUDE_DIR/settings.json"; then
                echo "  Detected: ppt_builder"
            elif grep -q "py_ver" "$CLAUDE_DIR/settings.json"; then
                echo "  Detected: code_ai"
            elif grep -q "general" "$CLAUDE_DIR/settings.json"; then
                echo "  Detected: general_ai (likely)"
            else
                echo "  Detected: custom or general_ai"
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
            echo ""
            show_setups
            echo "Examples:"
            echo "  $0                    # Interactive mode"
            echo "  $0 code_ai            # Switch to code_ai"
            echo "  $0 --link general_ai  # Symlink to general_ai"
            echo "  $0 --current          # Show current setup"
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
            echo -n "Select setup (1-4) or (q)uit: "
            read -r choice

            case $choice in
                1) switch_to_setup "general_ai" ;;
                2) switch_to_setup "code_ai" ;;
                3) switch_to_setup "deep_research" ;;
                4) switch_to_setup "ppt_builder" ;;
                q|Q) echo "Cancelled"; exit 0 ;;
                *) print_error "Invalid choice"; exit 1 ;;
            esac
            ;;
        *)
            # Direct setup name provided
            if [[ " ${SETUPS[@]} " =~ " ${1} " ]]; then
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
