#!/bin/zsh
set -euo pipefail

CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"
CONFIG="$CODEX_DIR/config.toml"
THEME_NAME="cursor-dark-midnight"

rm -f "$CODEX_DIR/themes/$THEME_NAME.tmTheme"
echo "Removed $CODEX_DIR/themes/$THEME_NAME.tmTheme"

if [[ -f "$CONFIG" ]] && grep -q "^theme = \"$THEME_NAME\"$" "$CONFIG"; then
  BACKUP="$CONFIG.bak.$(date +%Y%m%d%H%M%S)"
  cp "$CONFIG" "$BACKUP"
  sed -i '' "/^theme = \"$THEME_NAME\"$/d" "$CONFIG"
  echo "Removed theme = \"$THEME_NAME\" from $CONFIG (backup: $BACKUP)"
fi
