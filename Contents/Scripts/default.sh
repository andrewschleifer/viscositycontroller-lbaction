#!/bin/bash


echo '['

osascript -e "tell application \"Viscosity\" to get the name of every connection whose state is \"Connected\"" | \
    tr -d '[:blank:]'  | tr ',' '\012' | sed '/^[[:space:]]*$/d'| \
    while read NAME; do
        HOST=$(find ~/Library/Application\ Support/Viscosity/OpenVPN -name config.conf -print0 | xargs -0 grep remote\ $NAME | cut -d\  -f3)
        echo $NAME | \
        sed \
            -e 's|^|{ "title": "|' \
            -e 's|$|", "subtitle": "Disconnect from '$HOST'", "icon": "com.viscosityvpn.Viscosity", "action": "disconnect.sh", "actionArgument": "'$NAME'" },|'
    done

osascript -e "tell application \"Viscosity\" to get the name of every connection whose state is not \"Connected\"" | \
    tr -d '[:blank:]'  | tr ',' '\012' | sed '/^[[:space:]]*$/d'| \
    while read NAME; do
        HOST=$(find ~/Library/Application\ Support/Viscosity/OpenVPN -name config.conf -print0 | xargs -0 grep remote\ $NAME | cut -d\  -f3)
        echo $NAME | \
        sed \
            -e 's|^|{ "title": "|' \
            -e 's|$|", "subtitle": "Connect to '$HOST'", "icon": "com.viscosityvpn.Viscosity", "action": "connect.sh", "actionArgument": "'$NAME'" },|'
    done

echo ']'
