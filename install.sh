#!/bin/zsh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
ASSET_BUNDLE_DIR="$HOME/terminal-themes/cursor-dark-midnight"
GHOSTTY_DIR="$HOME/.config/ghostty/themes"
ITERM_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"

mkdir -p "$ASSET_BUNDLE_DIR"
mkdir -p "$GHOSTTY_DIR"
mkdir -p "$ITERM_DIR"

cp "$ROOT/assets/ghostty/Cursor Dark Midnight" "$GHOSTTY_DIR/Cursor Dark Midnight"
cp "$ROOT/assets/iterm2/Cursor Dark Midnight.json" "$ITERM_DIR/Cursor Dark Midnight.json"
cp "$ROOT/assets/iterm2/Cursor Dark Midnight.itermcolors" "$ASSET_BUNDLE_DIR/Cursor Dark Midnight.itermcolors"
cp "$ROOT/assets/iterm2/Cursor Dark Midnight.json" "$ASSET_BUNDLE_DIR/Cursor Dark Midnight.iTermProfile.json"
cp "$ROOT/assets/terminal/Cursor Dark Midnight.terminal" "$ASSET_BUNDLE_DIR/Cursor Dark Midnight.terminal"
cp "$ROOT/palette.json" "$ASSET_BUNDLE_DIR/palette.json"
cp "$ROOT/README.md" "$ASSET_BUNDLE_DIR/README.md"

if [[ ! -f "$HOME/Library/Fonts/BerkeleyMono-Bold.otf" && ! -f "$HOME/Library/Fonts/BerkeleyMono-Bold.ttf" ]]; then
  cat <<EOF
Warning:
- Berkeley Mono Bold does not appear to be installed in ~/Library/Fonts.
- The theme will still install, but apps may fall back to another monospace font.
EOF
fi

cat <<EOF
Installed add-only Cursor Dark Midnight theme assets:

- Ghostty theme: $GHOSTTY_DIR/Cursor Dark Midnight
- iTerm2 dynamic profile: $ITERM_DIR/Cursor Dark Midnight.json
- Local bundle: $ASSET_BUNDLE_DIR

Nothing was set as default automatically.

Next steps:
- Ghostty: add 'theme = Cursor Dark Midnight' to ~/.config/ghostty/config and restart Ghostty.
- iTerm2: restart iTerm2 and choose the 'Cursor Dark Midnight' profile.
- Terminal.app: open "$ASSET_BUNDLE_DIR/Cursor Dark Midnight.terminal" and select the imported profile.
EOF
