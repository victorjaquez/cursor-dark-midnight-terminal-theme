#!/bin/zsh
set -euo pipefail

rm -f "$HOME/.config/ghostty/themes/Cursor Dark Midnight"
rm -f "$HOME/Library/Application Support/iTerm2/DynamicProfiles/Cursor Dark Midnight.json"
rm -rf "$HOME/terminal-themes/cursor-dark-midnight"

cat <<EOF
Removed:

- ~/.config/ghostty/themes/Cursor Dark Midnight
- ~/Library/Application Support/iTerm2/DynamicProfiles/Cursor Dark Midnight.json
- ~/terminal-themes/cursor-dark-midnight

Manual cleanup still left to you:
- Remove the imported 'Cursor Dark Midnight' profile from Terminal.app if you imported it.
- Remove any 'theme = Cursor Dark Midnight' line from ~/.config/ghostty/config if you added it.
EOF
