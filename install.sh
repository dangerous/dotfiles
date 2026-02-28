#!/bin/bash
set -e

DOTFILES_DIR="$HOME/git/dotfiles"
PRIVATE_REPO="$HOME/git/dotfiles-private"

echo "==> Installing dotfiles..."

# 1. Install Homebrew
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "==> Homebrew already installed"
fi

# 2. Install brew packages
echo "==> Running brew bundle..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# 3. Symlink zsh config
echo "==> Symlinking zsh config..."
ln -sfn "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES_DIR/zsh/zshenv" "$HOME/.zshenv"

# 4. Symlink nvim config
echo "==> Symlinking nvim config..."
ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# 5. Clone dotfiles-private
if [ ! -d "$PRIVATE_REPO" ]; then
  echo "==> Cloning dotfiles-private..."
  git clone git@github.com:dangerous/dotfiles-private.git "$PRIVATE_REPO"
else
  echo "==> dotfiles-private already cloned"
fi

# 6. Symlink CLAUDE.md
echo "==> Symlinking CLAUDE.md..."
mkdir -p "$HOME/.claude"
ln -sfn "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"

# 7. Install Claude Code
if ! command -v claude &>/dev/null; then
  echo "==> Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | sh
else
  echo "==> Claude Code already installed"
fi

echo "==> Done!"
