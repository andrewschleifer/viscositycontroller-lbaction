#!/bin/sh

osascript -e "tell application \"Viscosity\" to disconnect \"${1}\""
osascript -e "tell application \"LaunchBar\" to hide"
