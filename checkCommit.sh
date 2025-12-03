#!/usr/bin/env bash

USERNAME="$1"

TODAY=$(date -u +"%Y-%m-%d" -d "-3 hours")

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
  curl --location "$2" --header 'Content-Type: application/json' --data '{"content":"<@464919571304939520> You need to commit soon of a bitch"}'
fi
