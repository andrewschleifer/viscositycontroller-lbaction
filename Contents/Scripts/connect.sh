#!/bin/sh

osascript -e "tell application \"Viscosity\" to connect \"${1}\""
osascript -e "tell application \"LaunchBar\" to hide"
