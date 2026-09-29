#!/bin/zsh
set -euo pipefail

SETTINGS="$HOME/.claude/settings.json"
THEME_PATH="$HOME/.claude/themes/cursor-dark-midnight.json"

rm -f "$THEME_PATH"
echo "Removed $THEME_PATH"

if [[ ! -f "$SETTINGS" ]]; then
  echo "$SETTINGS does not exist, nothing else to do."
  exit 0
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required. Install with: brew install jq" >&2
  exit 1
fi

CURRENT="$(jq -r '.theme // empty' "$SETTINGS")"
if [[ "$CURRENT" != "custom:cursor-dark-midnight" && "$CURRENT" != "dark-ansi" ]]; then
  echo "theme in $SETTINGS is '$CURRENT', not this repo's theme. Leaving it alone."
  exit 0
fi

BACKUP="$SETTINGS.bak.$(date +%Y%m%d%H%M%S)"
cp "$SETTINGS" "$BACKUP"
TMP="$(mktemp)"
jq 'del(.theme)' "$SETTINGS" > "$TMP"
mv "$TMP" "$SETTINGS"

echo "Removed 'theme' from $SETTINGS (backup: $BACKUP)."
