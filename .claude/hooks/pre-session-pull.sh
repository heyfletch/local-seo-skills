#!/bin/bash
# Auto-pull latest changes when starting a Claude Code session
# This runs before Claude Code loads the plugin

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$SCRIPT_DIR/.."

# Only pull if there are changes on the remote
if git fetch --dry-run 2>/dev/null | grep -q .; then
  echo "📥 Pulling latest changes..."
  git pull --quiet
  echo "✅ Up to date"
fi
