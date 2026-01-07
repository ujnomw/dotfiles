#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSHRC_SRC="$DOTFILES_DIR/zshrc"
ZSHRC_DST="$HOME/.zshrc"
ZSH_DIR="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZSH_DIR/custom"

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
# Install Oh My Zsh
# -----------------------------
if [[ ! -d "$ZSH_DIR" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

mkdir -p "$ZSH_CUSTOM/plugins" "$ZSH_CUSTOM/themes"

# -----------------------------
# Parse zshrc declarations
# -----------------------------
mapfile -t OMZ_PLUGINS < <(grep '^# OMZ_PLUGIN:' "$ZSHRC_SRC" | awk '{print $3}')
OMZ_THEME=$(grep '^# OMZ_THEME:' "$ZSHRC_SRC" | awk '{print $3}')

# -----------------------------
# Clone helper function (shallow, read-only, credential-free)
# -----------------------------
clone_repo() {
  local url="$1"
  local target="$2"

  if [[ ! -d "$target" ]]; then
    echo "==> Cloning $url into $target"
    git clone --depth=1 "$url" "$target"
  else
    echo "✔ Already cloned: $target"
  fi
}

# -----------------------------
# Install plugins
# -----------------------------
for plugin in "${OMZ_PLUGINS[@]}"; do
  target="$ZSH_CUSTOM/plugins/$(basename "$plugin")"
  if [[ ! -d "$target" ]]; then
    echo "==> Cloning plugin: $plugin"
    GIT_TERMINAL_PROMPT=0 git clone --depth=1 "https://github.com/$plugin.git" "$target" || \
      echo "⚠ Could not clone plugin $plugin, skipping. Check network or URL."
  else
    echo "✔ Plugin already present: $(basename "$plugin")"
  fi
done

# -----------------------------
# Install theme
# -----------------------------
if [[ -n "$OMZ_THEME" && "$OMZ_THEME" == */* ]]; then
  theme_name="${OMZ_THEME##*/}"
  target="$ZSH_CUSTOM/themes/$theme_name"
  if [[ ! -d "$target" ]]; then
    echo "==> Cloning theme: $OMZ_THEME"
    GIT_TERMINAL_PROMPT=0 git clone --depth=1 "https://github.com/$OMZ_THEME.git" "$target" || \
      echo "⚠ Could not clone theme $OMZ_THEME, skipping. Check network or URL."
  else
    echo "✔ Theme already present: $theme_name"
  fi
fi

# -----------------------------
# Link zshrc
# -----------------------------
if [[ -e "$ZSHRC_DST" && ! -L "$ZSHRC_DST" ]]; then
  echo "Backing up existing ~/.zshrc -> ~/.zshrc.backup"
  mv "$ZSHRC_DST" "$ZSHRC_DST.backup"
fi

ln -sf "$ZSHRC_SRC" "$ZSHRC_DST"

# -----------------------------
# Default shell
# -----------------------------
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
  echo "Setting zsh as default shell"
  chsh -s "$(command -v zsh)"
fi

echo "✅ Done. Restart shell."
