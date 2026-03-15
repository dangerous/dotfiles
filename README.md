# dotfiles

My macOS dotfiles, managed with symlinks and Homebrew.

## What's included

- **zsh** — prompt theme, aliases, history, completions
- **nvim** — Neovim configuration
- **git** — global gitconfig with opinionated defaults
- **ghostty** — terminal emulator config
- **claude** — Claude Code global settings
- **Brewfile** — Homebrew packages
- **tool-versions** — asdf runtime versions (Ruby, Node.js)

## Setup

```sh
git clone git@github.com:dangerous/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles
./uptodate.sh
```

`uptodate.sh` is idempotent — run it again anytime to sync changes.

## How it works

Everything is symlinked from `~/git/dotfiles/` into the home directory. Private or sensitive config lives in a separate `dotfiles-private` repo.
