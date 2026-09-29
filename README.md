# Cursor Dark Midnight Terminal Theme

Portable macOS theme bundle that matches Cursor's `Cursor Dark Midnight` theme and installs add-only profiles for:

- Ghostty
- iTerm2
- Terminal.app
- Claude Code (opt-in)
- Codex CLI (opt-in)

The base install does not change any app's default profile or active theme. It only installs a new selectable theme/profile named `Cursor Dark Midnight`. The Claude Code and Codex steps are opt-in and run separately because they edit `~/.claude/settings.json` and `~/.codex/config.toml`.

All colors come from Cursor's own theme file (`Cursor.app/Contents/Resources/app/extensions/theme-cursor/themes/cursor-dark-midnight-color-theme.json`) plus Cursor's built-in diff defaults, not from screenshots.

## Included

- `assets/ghostty/Cursor Dark Midnight`: Ghostty theme (palette, selection, diff palette slots)
- `assets/iterm2/Cursor Dark Midnight.itermcolors` and `assets/iterm2/Cursor Dark Midnight.json`: iTerm2 colors and dynamic profile
- `assets/terminal/Cursor Dark Midnight.terminal`: Terminal.app profile
- `assets/claude/themes/cursor-dark-midnight.json`: Claude Code custom theme
- `assets/claude/settings.json`: Claude Code settings merged by the installer
- `assets/codex/themes/cursor-dark-midnight.tmTheme`: Codex syntax theme, converted from Cursor's theme
- `palette.json`: the shared palette

## Install

Run:

```bash
./install.sh
```

The installer copies files to:

- `~/.config/ghostty/themes/Cursor Dark Midnight`
- `~/Library/Application Support/iTerm2/DynamicProfiles/Cursor Dark Midnight.json`
- `~/terminal-themes/cursor-dark-midnight/`

## Activate

### Ghostty

1. Add `theme = Cursor Dark Midnight` to Ghostty's config (`~/.config/ghostty/config`, or `~/Library/Application Support/com.mitchellh.ghostty/config`).
2. Reload with `Cmd+Shift+,` or restart Ghostty.

Besides the 16-color palette, the theme sets:

- Selection: Cursor's `terminal.selectionBackground` (`#434c5e55`), blended onto the background as `#272c36`, with `#d8dee9` text. The Claude Code theme uses the same `selectionBg`. For Cursor's brighter editor selection instead (`#434c5e99`), use `#323946`.
- Diff colors in palette slots 22, 28, 52, 58, 88 and 95. Claude Code uses these for diff backgrounds (see below). Other apps that use these 256-color slots will show these colors too.
- Bright colors 8 and 11–14 remapped to Cursor's syntax colors, because Claude Code's `dark-ansi` syntax highlighting is hardcoded to these slots. This changes bright black, yellow, blue, magenta and cyan for every app in Ghostty. Slot 12 (bright blue) is `#88c0d0` rather than Cursor's purple for numbers, because Claude Code also uses it for inline code in messages.

| Slot | Claude Code uses it for | Color | Cursor scope |
|---|---|---|---|
| 8 | comments | `#5f6c86` | `comment` `#8597BCA6`, blended |
| 11 | function, class and tag names | `#88c0d0` | `entity.name.function` |
| 12 | numbers and literals, inline code | `#88c0d0` | `entity.name.function` (Cursor uses `#b48ead` for numbers) |
| 13 | keywords | `#81a1c1` | `keyword` |
| 14 | `const`/`let`, built-ins, types | `#81a1c1` | `storage` |

### iTerm2

1. Restart iTerm2.
2. Choose the `Cursor Dark Midnight` profile.

### Terminal.app

1. Open `~/terminal-themes/cursor-dark-midnight/Cursor Dark Midnight.terminal`.
2. In `Terminal > Settings > Profiles`, select `Cursor Dark Midnight`.
3. Do not click `Default` unless you explicitly want it as the default later.

### Claude Code

```bash
./scripts/install-claude.sh
```

This copies the theme to `~/.claude/themes/cursor-dark-midnight.json` and merges `assets/claude/settings.json` into `~/.claude/settings.json` (backing up the existing file first). That sets `"theme": "custom:cursor-dark-midnight"` and turns syntax highlighting on. Restart Claude Code afterwards.

How the theme works:

- It is built on `dark-ansi`, so syntax highlighting uses the terminal's ANSI palette (the Nord-style colors above).
- Accents, message backgrounds, the prompt border and the selection are set to Cursor Dark Midnight hex colors.
- With a `dark-ansi` base, Claude Code converts hex diff colors to the nearest of the 256 standard terminal colors, which turns Cursor's dark reds and greens gray. So the theme points the diff colors at palette slots instead (`ansi256(22)` and so on), and the Ghostty theme redefines those slots to Cursor's exact diff colors. In other terminals, diffs fall back to the standard colors for those slots.

Diff colors, blended onto `#191c22`:

| Claude Code key | Slot | Color | Source |
|---|---|---|---|
| `diffAdded` | 22 | `#424c39` | inserted line `rgba(155,185,85,.2)` + inserted text `#a3be8c22` |
| `diffRemoved` | 52 | `#572026` | removed line `rgba(255,0,0,.2)` + removed text `#bf616a22` |
| `diffAddedWord` | 28 | `#4f5b44` | one more inserted text layer |
| `diffRemovedWord` | 88 | `#65292f` | one more removed text layer |
| `diffAddedDimmed` | 58 | `#333b2c` | inserted line layer only |
| `diffRemovedDimmed` | 95 | `#47161b` | removed line layer only |

Gotchas:

- Picking a theme in `/theme` also saves the syntax highlighting state shown on that screen, and `Ctrl+T` there toggles it. If code blocks lose their colors, check that `~/.claude/settings.json` has `"syntaxHighlightingDisabled": false`.
- Don't switch the base to `dark`. That gives exact hex diffs, but it brings in Claude Code's Monokai syntax colors and purple accents.
- With `"tui": "fullscreen"`, Claude Code draws its own text selection using the theme's `selectionBg`. Without it, Ghostty's selection colors apply.

To remove it, run `./scripts/uninstall-claude.sh`.

### Codex CLI

```bash
./scripts/install-codex.sh
```

This copies the syntax theme to `~/.codex/themes/cursor-dark-midnight.tmTheme` and sets `theme = "cursor-dark-midnight"` under `[tui]` in `~/.codex/config.toml`, backing up the existing file first. Restart Codex afterwards, or pick the theme with `/theme` inside Codex.

Codex doesn't draw its own selection, so selecting text in Codex uses the Ghostty theme's selection colors.

To regenerate the `.tmTheme` from a newer Cursor release:

```bash
./scripts/generate-codex-tmtheme.py
```

To remove it, run `./scripts/uninstall-codex.sh`.

## Font Note

This theme targets `Berkeley Mono Bold 14` because that matches your current Cursor terminal setup.

This repo does not bundle Berkeley Mono because the font itself is not part of this theme package. If Berkeley Mono is not installed on the target machine, the apps may fall back to another monospace font until you install it manually.

## Validate

Run:

```bash
./scripts/validate.sh
```

## Remove

Run:

```bash
./uninstall.sh
```

This removes the installed Ghostty theme, iTerm2 dynamic profile, and copied asset bundle. It does not remove anything you already imported manually inside Terminal.app or change your app defaults. Remove the Claude Code and Codex themes with their own uninstall scripts.

## License

MIT for the theme bundle and scripts in this repo.
