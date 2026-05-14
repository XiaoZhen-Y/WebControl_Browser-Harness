#!/bin/bash
# 同步 browser-harness 用户定制到 browser-config 仓库
set -e

REPO="$HOME/browser-config"
TARGET="$HOME/browser-harness"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
say() { echo -e "${GREEN}[sync]${NC} $1"; }

push_one() {
  local rel="$1"
  local src="$TARGET/$rel"
  local dst="$REPO/$rel"
  if [ -e "$src" ]; then
    rm -rf "$dst"
    mkdir -p "$(dirname "$dst")"
    cp -r "$src" "$dst"
    say "push: $rel"
  fi
}

pull_one() {
  local rel="$1"
  local src="$REPO/$rel"
  local dst="$TARGET/$rel"
  if [ -e "$src" ]; then
    rm -rf "$dst"
    mkdir -p "$(dirname "$dst")"
    cp -r "$src" "$dst"
    say "pull: $rel"
  fi
}

SYNC_FILES=("agent-workspace/agent_helpers.py")

case "${1:-}" in
  push)
    say "Pushing customizations to repo..."
    for f in "${SYNC_FILES[@]}"; do push_one "$f"; done
    say "Done."
    ;;
  pull)
    say "Pulling customizations to browser-harness..."
    for f in "${SYNC_FILES[@]}"; do pull_one "$f"; done
    say "Done."
    ;;
  *)
    echo "Usage: ./sync.sh push|pull"
    exit 1
    ;;
esac
