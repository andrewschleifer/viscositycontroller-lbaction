#!/bin/bash

export CONFIG="$HOME/Library/Application Support/Viscosity/OpenVPN"
test -d "$CONFIG" || exit
cd "$CONFIG"

echo '['

osascript -e 'tell application "Viscosity" to get the name of every connection whose state is "Connected"' | \
    tr , '\n' | sed '/^$/d' | \
    while read NAME; do
        HOST=$(grep ^remote $(grep -l "$NAME" */config.conf) | awk '{print $2}')
        echo $NAME | \
        sed \
            -e 's|^|{ "title": "|' \
            -e 's|$|", "subtitle": "Disconnect from '$HOST'", "icon": "com.viscosityvpn.Viscosity", "action": "disconnect.sh", "actionArgument": "'$NAME'" },|'
    done

osascript -e 'tell application "Viscosity" to get the name of every connection whose state is not "Connected"' | \
    tr , '\n' | sed '/^$/d' | \
    while read NAME; do
        HOST=$(grep ^remote $(grep -l "$NAME" */config.conf) | awk '{print $2}')
        echo $NAME | \
        sed \
            -e 's|^|{ "title": "|' \
            -e 's|$|", "subtitle": "Connect to '$HOST'", "icon": "com.viscosityvpn.Viscosity", "action": "connect.sh", "actionArgument": "'"$NAME"'" },|'
    done

echo ']'
