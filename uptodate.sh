#!/bin/bash
set -e

DOTFILES_DIR="$HOME/git/dotfiles"
PRIVATE_REPO="$HOME/git/dotfiles-private"
UPGRADE=false

if [[ "$1" == "--upgrade" || "$1" == "-u" ]]; then
  UPGRADE=true
fi

echo "==> Installing dotfiles..."

# 1. Pull latest dotfiles
echo "==> Pulling latest dotfiles..."
git -C "$DOTFILES_DIR" pull --rebase
if [ -d "$PRIVATE_REPO" ]; then
  git -C "$PRIVATE_REPO" pull --rebase
fi

# 2. Install Homebrew
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "==> Homebrew already installed"
fi

# 3. Install brew packages
if $UPGRADE; then
  echo "==> Updating Homebrew and upgrading packages..."
  brew update
  brew upgrade
  brew bundle --file="$DOTFILES_DIR/Brewfile"
else
  echo "==> Running brew bundle..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

# 4. Symlink zsh config
echo "==> Symlinking zsh config..."
ln -sfn "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES_DIR/zsh/zshenv" "$HOME/.zshenv"
ln -sfn "$DOTFILES_DIR/zsh/zprofile" "$HOME/.zprofile"

# 5. Symlink git config
echo "==> Symlinking git config..."
ln -sfn "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"

# 6. Symlink tool-versions
echo "==> Symlinking tool-versions..."
ln -sfn "$DOTFILES_DIR/tool-versions" "$HOME/.tool-versions"

# 7. Install asdf tool versions
asdf plugin add ruby 2>/dev/null || true
asdf plugin add nodejs 2>/dev/null || true
if $UPGRADE; then
  echo "==> Upgrading asdf tool versions to latest..."
  for tool in $(awk '{print $1}' "$DOTFILES_DIR/tool-versions"); do
    latest=$(asdf latest "$tool")
    echo "    $tool -> $latest"
    asdf install "$tool" "$latest"
    asdf set --home "$tool" "$latest"
  done
  # Update tool-versions file and hardcoded nodejs path in zshrc
  nodejs_version=$(asdf latest nodejs)
  sed -i '' "s|/.asdf/installs/nodejs/.*/bin|/.asdf/installs/nodejs/$nodejs_version/bin|" "$DOTFILES_DIR/zsh/zshrc"
else
  echo "==> Installing asdf tool versions..."
  asdf install
fi

# 8. Symlink nvim config
echo "==> Symlinking nvim config..."
ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# 9. Symlink ghostty config
echo "==> Symlinking ghostty config..."
GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
mkdir -p "$GHOSTTY_DIR"
ln -sfn "$DOTFILES_DIR/ghostty/config" "$GHOSTTY_DIR/config"

# 10. Clone dotfiles-private
if [ ! -d "$PRIVATE_REPO" ]; then
  echo "==> Cloning dotfiles-private..."
  git clone git@github.com:dangerous/dotfiles-private.git "$PRIVATE_REPO"
else
  echo "==> dotfiles-private already cloned"
fi

# 11. Symlink Claude config
echo "==> Symlinking Claude config..."
mkdir -p "$HOME/.claude"
ln -sfn "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
ln -sfn "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"

# 12. Install Claude Code
if ! command -v claude &>/dev/null; then
  echo "==> Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | sh
else
  echo "==> Claude Code already installed"
fi

# 13. Configure Claude MCP servers
echo "==> Configuring Claude MCP servers..."
claude mcp add codex -s user -- codex mcp-server -m gpt-5.4-codex -c model_reasoning_effort=high

if $UPGRADE; then
  echo "==> Committing upgrades..."
  git -C "$DOTFILES_DIR" add -A
  if ! git -C "$DOTFILES_DIR" diff --cached --quiet; then
    git -C "$DOTFILES_DIR" commit -m "Upgrade tool versions and brew packages"
    git -C "$DOTFILES_DIR" push
  else
    echo "    No changes to commit"
  fi
fi

echo "==> Done!"
