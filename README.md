# Cursor Dark Midnight Terminal Theme

Portable macOS theme bundle that matches Cursor's `Cursor Dark Midnight` terminal palette and installs add-only profiles for:

- Ghostty
- iTerm2
- Terminal.app

This repo does not change any app's default profile or active theme. It only installs a new selectable theme/profile named `Cursor Dark Midnight`.

## Included

- [assets/ghostty/Cursor Dark Midnight](/Users/victorjaquez/projects/cursor-dark-midnight-terminal-theme/assets/ghostty/Cursor%20Dark%20Midnight)
- [assets/iterm2/Cursor Dark Midnight.itermcolors](/Users/victorjaquez/projects/cursor-dark-midnight-terminal-theme/assets/iterm2/Cursor%20Dark%20Midnight.itermcolors)
- [assets/iterm2/Cursor Dark Midnight.json](/Users/victorjaquez/projects/cursor-dark-midnight-terminal-theme/assets/iterm2/Cursor%20Dark%20Midnight.json)
- [assets/terminal/Cursor Dark Midnight.terminal](/Users/victorjaquez/projects/cursor-dark-midnight-terminal-theme/assets/terminal/Cursor%20Dark%20Midnight.terminal)
- [palette.json](/Users/victorjaquez/projects/cursor-dark-midnight-terminal-theme/palette.json)

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

Ghostty:

1. Add `theme = Cursor Dark Midnight` to `~/.config/ghostty/config`.
2. Restart Ghostty.

iTerm2:

1. Restart iTerm2.
2. Choose the `Cursor Dark Midnight` profile.

Terminal.app:

1. Open `~/terminal-themes/cursor-dark-midnight/Cursor Dark Midnight.terminal`.
2. In `Terminal > Settings > Profiles`, select `Cursor Dark Midnight`.
3. Do not click `Default` unless you explicitly want it as the default later.

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

This removes the installed Ghostty theme, iTerm2 dynamic profile, and copied asset bundle. It does not remove anything you already imported manually inside Terminal.app or change your app defaults.

## Git

This directory is safe to push as a standalone repo. A typical flow:

```bash
git add .
git commit -m "Add Cursor Dark Midnight terminal theme bundle"
```

## License

MIT for the theme bundle and scripts in this repo.
