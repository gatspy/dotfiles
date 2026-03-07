#!/usr/bin/env zsh
set -euo pipefail
[ "$(uname -s)" != "Darwin" ] && exit 0

echo "› sudo softwareupdate -i -a not"
# sudo softwareupdate -i -a
