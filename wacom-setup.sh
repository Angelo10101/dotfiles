#!/bin/bash
TABLET_NAME="Wacom Intuos Pro S Pad pad"
TABLET_NAME2="Wacom Intuos Pro S (WL) Pad pad"
STYLUS_NAME="Wacom Intuos Pro S Pen stylus"
STYLUS_NAME2="Wacom Intuos Pro S (WL) Pen stylus"
xsetwacom set "$STYLUS_NAME" rotate half
xsetwacom set "$TABLET_NAME" button 9 key e
xsetwacom set "$TABLET_NAME" button 10 "key ctrl shift z"
xsetwacom set "$TABLET_NAME" button 11 "key ctrl z"
xsetwacom set "$STYLUS_NAME2" rotate half
xsetwacom set "$TABLET_NAME2" button 9 key e
xsetwacom set "$TABLET_NAME2" button 10 "key ctrl shift z"
xsetwacom set "$TABLET_NAME2" button 11 "key ctrl z"
xbindkeys -f ~/.xbindkeysrc
echo "Tablet set up"
