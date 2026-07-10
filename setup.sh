#!/usr/bin/env bash

################################################################################
# Ekshore's Dotfiles Setup Script
# Bootstraps a brand new macOS system and symlinks all configuration files
#
# This script is idempotent - it's safe to run multiple times
# It will update existing packages and install missing software
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/ekshore/dotfiles/main/setup.sh | bash
#
# Or locally:
#   bash ./setup.sh
################################################################################

set -euo pipefail

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/ekshore/dotfiles.git"
DOTFILES_DIR="${HOME}/dotfiles"

################################################################################
# Logging Functions
################################################################################

log_header() {
    echo -e "${BLUE}==>${NC} $*"
}

log_success() {
    echo -e "${GREEN}✓${NC} $*"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $*"
}

log_error() {
    echo -e "${RED}✗${NC} $*" >&2
}

################################################################################
# Check System Requirements
################################################################################

check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        log_error "This setup script requires macOS"
        exit 1
    fi
    log_success "Running on macOS"
}

################################################################################
# Install / Update Homebrew
################################################################################

install_homebrew() {
    if command -v brew &> /dev/null; then
        log_success "Homebrew already installed"
        return 0
    fi

    log_header "Installing Homebrew..."
    
    # Homebrew installation requires curl
    if ! command -v curl &> /dev/null; then
        log_warning "curl not found, installing xcode command line tools..."
        xcode-select --install 2>/dev/null || true
        until command -v curl &> /dev/null; do
            echo "Waiting for xcode-select installation to complete..."
            sleep 5
        done
    fi
    
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for current session (Apple Silicon Macs)
    if [[ -d "/opt/homebrew/bin" ]]; then
        export PATH="/opt/homebrew/bin:$PATH"
    fi
    
    log_success "Homebrew installed"
}

update_homebrew() {
    log_header "Updating Homebrew..."
    brew update
    log_success "Homebrew updated"
}

################################################################################
# Install/Update Core Dependencies
################################################################################

install_core_tools() {
    log_header "Installing core tools (git, curl, stow)..."
    
    # These are idempotent - brew install will skip if already installed
    # and upgrade if a newer version is available
    brew install curl
    brew install git
    brew install stow
    
    log_success "Core tools ready"
}

################################################################################
# Install/Update All Packages
################################################################################

install_packages() {
    log_header "Installing all packages via Homebrew..."
    
    local packages=(
        "ghostty"          # Terminal emulator
        "font-hack-nerd-font"  # Nerd font
        "starship"         # Prompt
        "tmux"             # Terminal multiplexer
        "neovim"           # Text editor
        "zsh-autosuggestions"  # Shell autocompletion
        "zsh-syntax-highlighting"  # Shell syntax highlighting
        "zoxide"           # Fuzzy cd
        "eza"              # Modern ls replacement
        "lazygit"          # Git TUI
    )
    
    # Install all packages (idempotent)
    for package in "${packages[@]}"; do
        if brew list "$package" &>/dev/null; then
            log_warning "$package already installed, upgrading..."
            brew upgrade "$package" 2>/dev/null || log_warning "$package is already up to date"
        else
            log_warning "Installing $package..."
            brew install "$package"
        fi
    done
    
    log_success "All packages ready"
}

install_casks() {
    log_header "Installing cask applications..."
    
    # Add the AeroSpace tap (only needed once, idempotent)
    if ! brew tap | grep -q "nikitabobko/tap"; then
        log_warning "Adding nikitabobko/tap..."
        brew tap nikitabobko/tap
    fi
    
    # Install AeroSpace
    if brew list aerospace &>/dev/null; then
        log_warning "AeroSpace already installed, upgrading..."
        brew upgrade aerospace 2>/dev/null || log_warning "AeroSpace is already up to date"
    else
        log_warning "Installing AeroSpace..."
        brew install --cask nikitabobko/tap/aerospace
    fi
    
    log_success "Cask applications ready"
}

################################################################################
# Clone/Update Dotfiles Repository
################################################################################

clone_or_update_dotfiles() {
    log_header "Setting up dotfiles repository..."
    
    if [[ -d "$DOTFILES_DIR" ]]; then
        log_warning "Dotfiles directory already exists, pulling latest changes..."
        cd "$DOTFILES_DIR"
        git fetch origin
        git reset --hard origin/main
        log_success "Dotfiles repository updated"
    else
        log_warning "Cloning dotfiles repository..."
        git clone "$REPO_URL" "$DOTFILES_DIR"
        log_success "Dotfiles repository cloned"
    fi
}

################################################################################
# Symlink Dotfiles with GNU Stow
################################################################################

symlink_dotfiles() {
    log_header "Symlinking dotfiles with GNU Stow..."
    
    cd "$DOTFILES_DIR"
    
    # Use stow to symlink everything
    # --restow re-links if already linked (idempotent)
    stow --restow .
    
    log_success "Dotfiles symlinked successfully"
}

################################################################################
# Configure Shell (zsh)
################################################################################

configure_shell() {
    log_header "Configuring shell..."
    
    # Ensure zsh is the default shell
    if [[ "$SHELL" != "$(command -v zsh)" ]]; then
        log_warning "Setting zsh as default shell..."
        chsh -s "$(command -v zsh)"
        log_success "Default shell set to zsh (will take effect on next login)"
    else
        log_success "zsh is already the default shell"
    fi
}

################################################################################
# Summary
################################################################################

print_summary() {
    cat <<EOF

${GREEN}════════════════════════════════════════════════════════════════${NC}
${GREEN}✓ Setup Complete!${NC}
${GREEN}════════════════════════════════════════════════════════════════${NC}

Your dotfiles have been installed and configured at: ${YELLOW}${DOTFILES_DIR}${NC}

${BLUE}Next Steps:${NC}

1. ${YELLOW}Restart your terminal${NC} to load the new configuration
   
2. ${YELLOW}Install Tmux Plugin Manager${NC} (if using tmux):
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

3. ${YELLOW}Review configuration${NC} and customize as needed:
   - Shell: ~/.zshrc
   - Neovim: ~/.config/nvim/
   - Tmux: ~/.config/tmux/tmux.conf
   - AeroSpace: ~/.config/aerospace/aerospace.toml
   - Ghostty: ~/.config/ghostty/config

4. ${YELLOW}Launch AeroSpace${NC}:
   - Applications → AeroSpace
   - Or use: open /Applications/AeroSpace.app

5. ${YELLOW}Update dotfiles anytime${NC}:
   cd ${DOTFILES_DIR} && git pull && stow --restow .

${BLUE}Installed Tools:${NC}
  • Homebrew (package manager)
  • Git (version control)
  • Neovim (editor)
  • Tmux (terminal multiplexer)
  • Starship (prompt)
  • AeroSpace (tiling window manager)
  • Ghostty (terminal emulator)
  • Zoxide (fuzzy cd)
  • Eza (ls replacement)
  • Lazygit (git TUI)
  • And more!

${BLUE}Idempotent:${NC}
This script is safe to run multiple times. It will:
  ✓ Update existing packages
  ✓ Install missing software
  ✓ Re-link configuration files
  ✓ Keep your dotfiles in sync

For more information, see: ${YELLOW}${DOTFILES_DIR}/README.md${NC}

${GREEN}════════════════════════════════════════════════════════════════${NC}

EOF
}

################################################################################
# Main Setup Flow
################################################################################

main() {
    echo ""
    log_header "Starting Dotfiles Setup"
    echo ""
    
    check_macos
    install_homebrew
    update_homebrew
    install_core_tools
    install_packages
    install_casks
    clone_or_update_dotfiles
    symlink_dotfiles
    configure_shell
    
    echo ""
    print_summary
}

# Run main function
main "$@"
