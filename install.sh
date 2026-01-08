#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSHRC_SRC="$DOTFILES_DIR/zshrc"
ZSHRC_DST="$HOME/.zshrc"
ZSH_DIR="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZSH_DIR/custom"
P10K_COMMIT_HASH="4f143b7"

echo "==> Oh My Zsh reproducible setup (credential-free)"

# -----------------------------
# Platform detection + package install
# -----------------------------
install_packages() {
  echo "==> Installing required packages: git, curl, zsh"

  # Detect if we need sudo
  if [[ $EUID -eq 0 ]]; then
    SUDO=""
  else
    SUDO="sudo"
  fi

  if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew >/dev/null; then
      echo "Homebrew not found, installing..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install git curl zsh || true

  elif [[ -f /etc/debian_version ]]; then
    $SUDO apt update
    $SUDO apt install -y git curl zsh

  elif [[ -f /etc/redhat-release ]]; then
    $SUDO yum install -y git curl zsh

  elif [[ -f /etc/alpine-release ]]; then
    $SUDO apk add --no-cache git curl zsh

  else
    echo "⚠ Unsupported OS: $OSTYPE. Please install git, curl, zsh manually."
  fi
}


install_packages

# -----------------------------
# Git aliases
# -----------------------------

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

git config --global alias.hist 'log --oneline --graph --decorate --all'
echo "Set Git aliases"

# -----------------------------
# Install Oh My Zsh
# -----------------------------
if [[ ! -d "$ZSH_DIR" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

mkdir -p "$ZSH_CUSTOM/plugins" "$ZSH_CUSTOM/themes"

# -----------------------------
# Install plugins
# -----------------------------
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "Installed plugins"

# Theme setup 
git clone https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" && \
    cd "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" && \
    git switch --detach $P10K_COMMIT_HASH && cd - 
echo "Set up theme"

# -----------------------------
# Link zshrc
# -----------------------------
if [[ -e "$ZSHRC_DST" && ! -L "$ZSHRC_DST" ]]; then
  echo "Backing up existing ~/.zshrc -> ~/.zshrc.backup"
  mv "$ZSHRC_DST" "$ZSHRC_DST.backup"
fi

ln -sf "$ZSHRC_SRC" "$ZSHRC_DST"


# Link .p10k.zsh
if [[ -f "$DOTFILES_DIR/.p10k.zsh" ]]; then
  ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
  echo "✔ Linked existing powerlevel10k config"
fi

# -----------------------------
# Default shell
# -----------------------------
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
  echo "Setting zsh as default shell"
  chsh -s "$(command -v zsh)"
fi

echo "✅ Done. Restart shell."
