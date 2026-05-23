#!/usr/bin/env bash
# LibreGameDev-Claude-Code installer.
# Copies the 20 game-dev plugins into your Claude Code plugins directory.
#
# Usage: ./setup.sh [--plugins-dir <path>] [--only <p1,p2,p3>]

set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGINS_SRC="$SCRIPT_DIR/plugins"
PLUGINS_DST="${CLAUDE_PLUGINS_DIR:-$HOME/.claude/plugins}"

ONLY=""

while (( $# )); do
  case "$1" in
    --plugins-dir) PLUGINS_DST="$2"; shift 2;;
    --only)        ONLY="$2"; shift 2;;
    -h|--help)
      cat <<EOF
Usage: $0 [options]

Options:
  --plugins-dir <path>   Plugin destination (default: ~/.claude/plugins)
  --only p1,p2,p3        Install only the named plugins (default: all 20)

Examples:
  $0
  $0 --only godot-development,multiplayer-networking,shader-programming
EOF
      exit 0;;
    *) echo "Unknown arg: $1" >&2; exit 64;;
  esac
done

if [[ ! -d "$PLUGINS_SRC" ]]; then
  echo "ERROR: plugins source not found at $PLUGINS_SRC" >&2
  echo "Run from the repo root." >&2
  exit 1
fi

mkdir -p "$PLUGINS_DST"

if [[ -n "$ONLY" ]]; then
  IFS=',' read -r -a SELECTED <<< "$ONLY"
else
  SELECTED=()
  for d in "$PLUGINS_SRC"/*/; do
    SELECTED+=("$(basename "$d")")
  done
fi

echo "Installing LibreGameDev plugins:"
echo "  Source: $PLUGINS_SRC"
echo "  Target: $PLUGINS_DST"
echo "  Plugins: ${#SELECTED[@]}"
echo ""

count=0
for name in "${SELECTED[@]}"; do
  src="$PLUGINS_SRC/$name"
  dst="$PLUGINS_DST/libre-gamedev-$name"

  if [[ ! -d "$src" ]]; then
    echo "  [skip] $name (not found)"
    continue
  fi

  if [[ -d "$dst" ]]; then
    echo "  [skip] libre-gamedev-$name (already installed)"
    continue
  fi

  cp -r "$src" "$dst"
  echo "  [ok]   libre-gamedev-$name"
  count=$((count + 1))
done

echo ""
echo "Installed $count plugins."
echo ""
echo "Restart Claude Code, then try:"
echo "  /game-arch design an architecture for a 2D platformer"
echo "  /godot create a CharacterBody2D player with WASD movement"
echo "  /multiplayer add rollback netcode to my fighting game"
echo ""
echo "Documentation: README.md, QUICK_START.md, docs/, learning-paths/"
