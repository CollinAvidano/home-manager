#!/bin/bash
WHEREAMI=$(cat /tmp/whereami)
if [[ $1 ~= "kitty"]]; then
    $1 --cwd "$WHEREAMI"
elif [[ $1 ~= "gnome-terminal"]]; then
    $1 --working-directory="$WHEREAMI"
fi


