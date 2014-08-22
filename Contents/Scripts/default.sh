#!/bin/bash


echo '['

osascript -e "tell application \"Viscosity\" to get the name of every connection whose state is \"Connected\"" | \
    while read NAME; do
        echo $NAME | \
        sed '
            /^\s*$/d;
            s|^|{ "title": "|;
            s|$|", "subtitle": "Disconnect", "icon": "com.viscosityvpn.Viscosity", "action": "disconnect.sh", "actionArgument": "'$NAME'" },|
        '
    done

osascript -e "tell application \"Viscosity\" to get the name of every connection whose state is not \"Connected\"" | \
    while read NAME; do
        echo $NAME | \
        sed '
            /^\s*$/d;
            s|^|{ "title": "|;
            s|$|", "subtitle": "Connect", "icon": "com.viscosityvpn.Viscosity", "action": "connect.sh", "actionArgument": "'$NAME'" },|
        '
    done

echo ']'
