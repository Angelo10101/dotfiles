#!/bin/bash
# Wait for the X session to fully initialize
sleep 1

# Reset keyboard settings
setxkbmap -option

# Remap Caps Lock to Escape
xmodmap -e 'clear Lock' -e 'keycode 66 = Escape'

# Start xbindkeys
pkill xbindkeys
xbindkeys -f ~/.xbindkeysrc
