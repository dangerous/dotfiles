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
ln -sfn "$DOTFILES_DIR/zsh/zprofile" "$HOME/.zprofile"

# 4. Symlink git config
echo "==> Symlinking git config..."
ln -sfn "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"

# 5. Symlink tool-versions
echo "==> Symlinking tool-versions..."
ln -sfn "$DOTFILES_DIR/tool-versions" "$HOME/.tool-versions"

# 6. Install asdf tool versions
echo "==> Installing asdf tool versions..."
asdf plugin add ruby 2>/dev/null || true
asdf plugin add nodejs 2>/dev/null || true
asdf install

# 7. Symlink nvim config
echo "==> Symlinking nvim config..."
ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# 8. Symlink ghostty config
echo "==> Symlinking ghostty config..."
GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
mkdir -p "$GHOSTTY_DIR"
ln -sfn "$DOTFILES_DIR/ghostty/config" "$GHOSTTY_DIR/config"

# 9. Clone dotfiles-private
if [ ! -d "$PRIVATE_REPO" ]; then
  echo "==> Cloning dotfiles-private..."
  git clone git@github.com:dangerous/dotfiles-private.git "$PRIVATE_REPO"
else
  echo "==> dotfiles-private already cloned"
fi

# 10. Symlink Claude config
echo "==> Symlinking Claude config..."
mkdir -p "$HOME/.claude"
ln -sfn "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
ln -sfn "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"

# 11. Install Claude Code
if ! command -v claude &>/dev/null; then
  echo "==> Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | sh
else
  echo "==> Claude Code already installed"
fi

# 12. Configure Claude MCP servers
echo "==> Configuring Claude MCP servers..."
claude mcp add codex -s user -- codex mcp-server -m gpt-5.4-codex -c model_reasoning_effort=high

echo "==> Done!"
