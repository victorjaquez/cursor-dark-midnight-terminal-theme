#!/bin/zsh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

plutil -lint "$ROOT/assets/terminal/Cursor Dark Midnight.terminal"
plutil -lint "$ROOT/assets/iterm2/Cursor Dark Midnight.itermcolors"
jq empty "$ROOT/assets/iterm2/Cursor Dark Midnight.json"
jq empty "$ROOT/palette.json"

echo "Validation passed."
