#!/bin/zsh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"
SETTINGS="$CLAUDE_DIR/settings.json"
SNIPPET="$ROOT/assets/claude/settings.json"
THEME_FILE="cursor-dark-midnight.json"

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required. Install with: brew install jq" >&2
  exit 1
fi

mkdir -p "$CLAUDE_DIR/themes"
cp "$ROOT/assets/claude/themes/$THEME_FILE" "$CLAUDE_DIR/themes/$THEME_FILE"
echo "Installed $CLAUDE_DIR/themes/$THEME_FILE"

if [[ -f "$SETTINGS" ]]; then
  BACKUP="$SETTINGS.bak.$(date +%Y%m%d%H%M%S)"
  cp "$SETTINGS" "$BACKUP"
  TMP="$(mktemp)"
  jq -s '.[0] * .[1]' "$SETTINGS" "$SNIPPET" > "$TMP"
  mv "$TMP" "$SETTINGS"
  echo "Merged theme settings into $SETTINGS (backup: $BACKUP)."
else
  cp "$SNIPPET" "$SETTINGS"
  echo "Wrote $SETTINGS."
fi

cat <<EOF

Claude Code theme set to 'custom:cursor-dark-midnight' with syntax highlighting on.

The theme is built on dark-ansi, so syntax colors and diff backgrounds come from
the terminal palette. Run Claude Code in Ghostty with the 'Cursor Dark Midnight'
theme from this repo for the matching look; it redefines the palette slots
Claude Code uses to Cursor's colors.

Restart any running Claude Code sessions to pick up the new theme. Avoid
re-selecting it in /theme: that also saves the syntax highlighting toggle shown there.
EOF
