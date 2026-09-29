#!/bin/zsh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"
CONFIG="$CODEX_DIR/config.toml"
THEME_NAME="cursor-dark-midnight"

mkdir -p "$CODEX_DIR/themes"
cp "$ROOT/assets/codex/themes/$THEME_NAME.tmTheme" "$CODEX_DIR/themes/$THEME_NAME.tmTheme"
echo "Installed $CODEX_DIR/themes/$THEME_NAME.tmTheme"

if [[ -f "$CONFIG" ]]; then
  BACKUP="$CONFIG.bak.$(date +%Y%m%d%H%M%S)"
  cp "$CONFIG" "$BACKUP"
  echo "Backed up $CONFIG to $BACKUP"
fi
touch "$CONFIG"

# Set `theme` under [tui]: replace an existing value, add it to an existing [tui] table, or append the table.
python3 - "$CONFIG" "$THEME_NAME" <<'EOF'
import re
import sys

path, name = sys.argv[1], sys.argv[2]
lines = open(path).read().splitlines()
line = f'theme = "{name}"'
start = next((i for i, l in enumerate(lines) if l.strip() == "[tui]"), None)
if start is None:
    if lines and lines[-1].strip():
        lines.append("")
    lines += ["[tui]", line]
else:
    end = next((i for i in range(start + 1, len(lines)) if re.match(r"\s*\[", lines[i])), len(lines))
    existing = next((i for i in range(start + 1, end) if re.match(r"\s*theme\s*=", lines[i])), None)
    if existing is None:
        lines.insert(start + 1, line)
    else:
        lines[existing] = line
open(path, "w").write("\n".join(lines) + "\n")
EOF

cat <<EOF
Set [tui] theme = "$THEME_NAME" in $CONFIG.

Restart Codex to pick it up. You can also switch themes with /theme inside Codex.
EOF
