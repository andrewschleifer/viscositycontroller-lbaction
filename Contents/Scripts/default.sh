#!/bin/bash


echo '['

osascript -e "tell application \"Viscosity\" to get the name of every connection whose state is \"Connected\"" | \
    while read NAME; do
        HOST=$(grep remote "$(grep -rl viscosity\ name\ Anchor ~/Library/Application\ Support/Viscosity/OpenVPN/)" | cut -d\  -f2)
        echo $NAME | \
        sed '
            /^\s*$/d;
            s|^|{ "title": "|;
            s|$|", "subtitle": "Disconnect from '$HOST'", "icon": "com.viscosityvpn.Viscosity", "action": "disconnect.sh", "actionArgument": "'$NAME'" },|
        '
    done

osascript -e "tell application \"Viscosity\" to get the name of every connection whose state is not \"Connected\"" | \
    while read NAME; do
        HOST=$(grep remote "$(grep -rl viscosity\ name\ Anchor ~/Library/Application\ Support/Viscosity/OpenVPN/)" | cut -d\  -f2)
        echo $NAME | \
        sed '
            /^\s*$/d;
            s|^|{ "title": "|;
            s|$|", "subtitle": "Connect to '$HOST'", "icon": "com.viscosityvpn.Viscosity", "action": "connect.sh", "actionArgument": "'$NAME'" },|
        '
    done

echo ']'
