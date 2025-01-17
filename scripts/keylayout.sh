#!/bin/bash

current=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')


notify-send "Keyboard Layout" "<b>${current}</b>"
