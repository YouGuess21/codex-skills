#!/usr/bin/env bash

set -e

HERE=false
GLOBAL=false
URL=""

# ---- Help ----
show_help() {
  echo "Usage:"
  echo "  $0 <github-folder-url> [--here] [--global]"
  echo ""
  echo "Options:"
  echo "  --here     Download into ./.codex/skills/<folder>"
  echo "  --global   Download into ~/.codex/skills/<folder>"
  echo "  -h, --help Show this help message"
  echo ""
  echo "Examples:"
  echo "  $0 https://github.com/user/repo/tree/main/folder"
  echo "  $0 <url> --here"
  echo "  $0 <url> --global"
}

# ---- Parse args ----
for arg in "$@"; do
  case "$arg" in
    --here)
      HERE=true
      ;;
    --global)
      GLOBAL=true
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      URL="$arg"
      ;;
  esac
done

# ---- Validate ----
if [[ -z "$URL" ]]; then
  echo "❌ Error: Missing GitHub folder URL"
  echo ""
  show_help
  exit 1
fi

if $HERE && $GLOBAL; then
  echo "❌ Error: Use either --here or --global, not both"
  exit 1
fi

# ---- Check svn ----
if ! command -v svn &> /dev/null; then
  echo "❌ 'svn' is required but not installed."
  echo ""
  echo "Install it using:"
  echo "  Ubuntu/Debian: sudo apt install subversion"
  echo "  macOS (brew):  brew install svn"
  echo "  Arch:          sudo pacman -S subversion"
  echo ""
  exit 1
fi

# ---- Convert GitHub URL → SVN URL ----
# https://github.com/user/repo/tree/branch/path
# → https://github.com/user/repo/trunk/path

SVN_URL=$(echo "$URL" | sed -E 's|https://github.com/([^/]+)/([^/]+)/tree/([^/]+)|https://github.com/\1/\2/trunk|')

# Extract folder name
FOLDER_NAME=$(basename "$URL")

# ---- Destination ----
if $HERE; then
  BASE="./.codex/skills"
elif $GLOBAL; then
  BASE="$HOME/.codex/skills"
else
  BASE="."
fi

DEST="$BASE/$FOLDER_NAME"

# Create base directory if needed
mkdir -p "$BASE"

# ---- Prevent overwrite ----
if [[ -e "$DEST" ]]; then
  echo "⚠️  Skipping: '$DEST' already exists."
  echo "   Nothing was modified."
  exit 0
fi

# ---- Download ----
echo "⬇️  Downloading:"
echo "   $URL"
echo "→ $DEST"
echo ""

svn export "$SVN_URL" "$DEST"

echo ""
echo "✅ Done!"
echo "📁 Saved to: $DEST"
