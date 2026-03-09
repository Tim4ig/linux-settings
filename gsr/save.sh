#!/usr/bin/env zsh

DIR="$HOME/Videos/replays"
TIMEOUT=5

notify-send "Replay" "Saving replay..."

before=$(ls -1t "$DIR" 2>/dev/null | head -n1)

pkill -SIGUSR1 -f gpu-screen-recorder

elapsed=0
while [ $elapsed -lt $TIMEOUT ]; do
    sleep 1
    after=$(ls -1t "$DIR" 2>/dev/null | head -n1)

    if [ "$after" != "$before" ] && [ -n "$after" ]; then
        notify-send "Replay" "Successfully saved to \"$after\""
        exit 0
    fi

    elapsed=$((elapsed + 1))
done

notify-send -u critical "Replay" "Failed to save replay (timeout)"
exit 1
