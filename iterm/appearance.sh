#!/usr/bin/env bash
# Reapply the user's finalized iTerm2 appearance choices.
# Final state ruled 2026-10-27 on M6: theme=Dark, tab bar=Bottom,
# stretch tabs=off. Values captured live from cfprefsd (defaults read),
# so a rebuild reproduces the accepted look byte-for-byte.
# Run once per machine, then fully quit and reopen iTerm2 to apply.
set -euo pipefail

domain="com.googlecode.iterm2"

defaults write "$domain" Theme -string "Dark"
defaults write "$domain" TabStyleWithAutomaticOption -int 6
defaults write "$domain" StretchTabsToFillBar -bool false

echo "OK: appearance keys written to $domain. Quit and reopen iTerm2."
