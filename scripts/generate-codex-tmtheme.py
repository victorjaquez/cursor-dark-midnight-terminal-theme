#!/usr/bin/env python3
"""Regenerate assets/codex/themes/cursor-dark-midnight.tmTheme from Cursor's bundled theme.

Usage: ./scripts/generate-codex-tmtheme.py [path/to/cursor-dark-midnight-color-theme.json]
"""
import json
import plistlib
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DEFAULT_SRC = Path(
    "/Applications/Cursor.app/Contents/Resources/app/extensions/theme-cursor/themes/"
    "cursor-dark-midnight-color-theme.json"
)
OUT = ROOT / "assets/codex/themes/cursor-dark-midnight.tmTheme"
TERMINAL_BACKGROUND = "#191c22"

src = Path(sys.argv[1]) if len(sys.argv) > 1 else DEFAULT_SRC
theme = json.loads(src.read_text())
colors = theme["colors"]

settings = [
    {
        "settings": {
            "background": TERMINAL_BACKGROUND,
            "foreground": colors["editor.foreground"],
            "caret": colors["editorCursor.foreground"],
            "selection": colors["editor.selectionBackground"],
            "lineHighlight": colors["editor.lineHighlightBackground"],
            "invisibles": colors["editorWhitespace.foreground"],
        }
    }
]
for rule in theme["tokenColors"]:
    scope = rule["scope"]
    if isinstance(scope, list):
        scope = ", ".join(scope)
    settings.append({"scope": scope, "settings": rule["settings"]})

OUT.parent.mkdir(parents=True, exist_ok=True)
with OUT.open("wb") as f:
    plistlib.dump(
        {
            "name": "Cursor Dark Midnight",
            "uuid": "5f0b7c2e-8d3a-4b6f-9e1c-2a4d6c8e0f13",
            "settings": settings,
        },
        f,
    )
print(f"Wrote {OUT} ({len(settings)} rules) from {src}")
