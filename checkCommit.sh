#!/usr/bin/env bash

USERNAME="$1"

TODAY=$(date -u +"%Y-%m-%d" -d "-3 hours")

# Fetch your most recent events (public only)
EVENTS=$(curl -s "https://raw.githubusercontent.com/ColcheteDAO/streakCounter/main/$USERNAME/contributions/$USERNAME.json")

# Count PushEvents from today
COUNT=$(echo "$EVENTS" \
  | jq --arg TODAY "$TODAY" '
      .[] | select(.date < $TODAY) | .contributionCount
    ')
echo $COUNT
# COMMIT_META=$(($3 - COUNT))
# echo "" > dailyCommit.md
# echo "# Daily commitment info" >> dailyCommit.md
# echo "Total commited today: $COUNT" >> dailyCommit.md

# if [ "$COUNT" -lt $3 ]; then
#   curl --location "$2" --header 'Content-Type: application/json' --data '{"content":"<@464919571304939520> Missing '"$COMMIT_META"' commits"}'
#   echo "Total to commit: $COMMIT_META" >> dailyCommit.md
# elif [ "$COUNT" -gt 0 ]; then
#   echo "Total to commit: 0" >> dailyCommit.md
#   echo "✅ Yes! You committed today ($COUNT push events)."
# else
#   echo "Total to commit: $COMMIT_META" >> dailyCommit.md
#   echo "❌ No commits found for today ($TODAY)."
#   curl --location "$2" --header 'Content-Type: application/json' --data '{"content":"<@464919571304939520> You need to commit soon of a bitch"}'
# fi
