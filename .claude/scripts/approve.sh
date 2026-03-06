#!/bin/bash
set -e

PLUGIN_JSON=".claude-plugin/plugin.json"
README="README.md"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$SCRIPT_DIR"

# Read current version
CURRENT_VERSION=$(grep '"version"' "$PLUGIN_JSON" | head -1 | sed 's/.*"version": "\([^"]*\)".*/\1/')

# Parse version parts
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

# Get recent commits (last 10, excluding merge commits)
RECENT_CHANGES=$(git log --oneline -10 --no-merges --pretty=format:"%s" | sed 's/^/- /')

# Determine version bump (rules: patch for tweaks, minor for new skills, major for finalization to 1.0)
# For now, bump patch unless user specifies
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"

# Update plugin.json version
sed -i '' "s/\"version\": \"$CURRENT_VERSION\"/\"version\": \"$NEW_VERSION\"/" "$PLUGIN_JSON"

# Get today's date in YYYY-MM-DD format
DATE=$(date +%Y-%m-%d)

# Create temporary file with new changelog entry
TEMP_FILE=$(mktemp)
cat > "$TEMP_FILE" << EOF

### $NEW_VERSION
$RECENT_CHANGES
EOF

# Find the line with "## Changelog" and insert after it
CHANGELOG_LINE=$(grep -n "^## Changelog" "$README" | cut -d: -f1)

if [ -n "$CHANGELOG_LINE" ]; then
  # Insert after the "## Changelog" line
  awk -v line="$CHANGELOG_LINE" -v temp="$TEMP_FILE" '
    NR == line {
      print $0
      while ((getline < temp) > 0) print $0
      next
    }
    1
  ' "$README" > "$README.tmp" && mv "$README.tmp" "$README"
else
  echo "Warning: Could not find '## Changelog' in $README"
fi

rm -f "$TEMP_FILE"

# Stage, commit, and push
git add "$PLUGIN_JSON" "$README"
git commit -m "chore: bump to $NEW_VERSION

$RECENT_CHANGES"
git push

echo "✅ Version bumped from $CURRENT_VERSION to $NEW_VERSION"
echo "📝 Changelog updated"
echo "🚀 Changes committed and pushed"
