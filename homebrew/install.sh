#!/usr/bin/env zsh
set -euo pipefail
#
# Homebrew Installation Script
#
# This installs Homebrew if not already present.
# See https://brew.sh for official installation instructions.

# Source common functions
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
source "${DOTFILES}/script/lib.sh" 2>/dev/null || true

log_info "Checking Homebrew installation..."

# Check for Homebrew
if command_exists brew; then
  log_success "Homebrew is already installed"
  brew --version
  exit 0
fi

log_info "Installing Homebrew..."

# Install Homebrew for the current OS type
if is_macos; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  log_success "Homebrew installed on macOS"
elif is_linux; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  log_success "Homebrew installed on Linux"
else
  log_error "Unsupported OS: $(uname -s)"
  exit 1
fi

log_info "Homebrew installation complete"
log_info "Please run 'brew --version' to verify"
