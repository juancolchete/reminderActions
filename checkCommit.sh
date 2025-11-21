#!/usr/bin/env bash

USERNAME="${1:-YOUR_USERNAME}"

if [ "$USERNAME" = "YOUR_USERNAME" ]; then
  echo "Usage: $0 <github-username>"
  exit 1
fi

TODAY=$(date -u +"%Y-%m-%d")

# Fetch your most recent events (public only)
EVENTS=$(curl -s "https://api.github.com/users/$USERNAME/events")

# Count PushEvents from today
COUNT=$(echo "$EVENTS" \
  | jq --arg TODAY "$TODAY" '
      map(select(.type=="PushEvent" and (.created_at | startswith($TODAY)))) | length
    ')

if [ "$COUNT" -gt 0 ]; then
  echo "✅ Yes! You committed today ($COUNT push events)."
else
  echo "❌ No commits found for today ($TODAY)."
fi
