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
  echo "  --here     Install into ./.codex/skills/<folder>"
  echo "  --global   Install into ~/.codex/skills/<folder>"
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

# ---- Check git ----
if ! command -v git &> /dev/null; then
  echo "❌ 'git' is required but not installed."
  echo ""
  echo "Install it using:"
  echo "  Ubuntu/Debian: sudo apt install git"
  echo "  macOS (brew):  brew install git"
  echo "  Arch:          sudo pacman -S git"
  exit 1
fi

# ---- Parse GitHub URL ----
# Format:
# https://github.com/user/repo/tree/branch/path

if [[ "$URL" =~ github.com/([^/]+)/([^/]+)/tree/([^/]+)/(.*) ]]; then
  USER="${BASH_REMATCH[1]}"
  REPO="${BASH_REMATCH[2]}"
  BRANCH="${BASH_REMATCH[3]}"
  PATH_PART="${BASH_REMATCH[4]}"
else
  echo "❌ Invalid GitHub folder URL"
  exit 1
fi

REPO_URL="https://github.com/$USER/$REPO.git"
FOLDER_NAME=$(basename "$PATH_PART")

# ---- Destination ----
ORIG_DIR=$(pwd)

# Build absolute destination
if $HERE; then
  BASE="$ORIG_DIR/.codex/skills"
elif $GLOBAL; then
  BASE="$HOME/.codex/skills"
else
  BASE="$ORIG_DIR"
fi

DEST="$BASE/$FOLDER_NAME"

mkdir -p "$BASE"

# ---- Prevent overwrite ----
if [[ -e "$DEST" ]]; then
  echo " Skipping: '$DEST' already exists."
  echo " Nothing was modified."
  exit 0
fi

# ---- Temp dir ----
TMP_DIR=$(mktemp -d)

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

echo " Downloading:"
echo "   $URL"
echo "→ $DEST"
echo ""

# ---- Sparse clone ----
git clone --depth 1 --filter=blob:none --sparse "$REPO_URL" "$TMP_DIR" >/dev/null 2>&1

cd "$TMP_DIR"
git sparse-checkout set "$PATH_PART" >/dev/null 2>&1
git checkout "$BRANCH" >/dev/null 2>&1

# ---- Move folder ----
mkdir -p "$(dirname "$DEST")"
mv "$TMP_DIR/$PATH_PART" "$DEST"

cd - >/dev/null

echo ""
echo " Done!"
echo " Saved to: $DEST"
