#!/usr/bin/env zsh
set -euo pipefail
# iTerm2 配置安装脚本

# Source common functions
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
source "${DOTFILES}/script/lib.sh" 2>/dev/null || true

log_info "Configuring iTerm2..."

# Only run on macOS
if ! is_macos; then
  log_warning "iTerm2 is only available on macOS, skipping"
  exit 0
fi

# Generate plist from example (replace hardcoded paths)
if [[ -f "$DOTFILES/iterm/com.googlecode.iterm2.plist.example" ]]; then
  sed "s;/Users/carlos;$HOME;g" \
    "$DOTFILES/iterm/com.googlecode.iterm2.plist.example" \
    > "$DOTFILES/iterm/com.googlecode.iterm2.plist"
  log_info "Generated iTerm2 preferences plist"
fi

# Set iTerm2 to load preferences from custom folder
defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string "$DOTFILES/iterm"
defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true

log_success "iTerm2 configured"
log_info "You may need to restart iTerm2 for changes to take effect"
