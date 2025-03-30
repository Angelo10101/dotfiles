#!/bin/bash

# Get device IDs based on partial name matches
ASUS_MOUSE_ID=$(xinput --list | grep -i "ASUSTeK TUF GAMING M4 AIR" | head -n 1 | awk -F'id=' '{print $2}' | awk '{print $1}')
ZOWIE_MOUSE_ID=$(xinput --list | grep -i "ZOWIE" | awk -F'id=' '{print $2}' | awk '{print $1}')
TOUCHPAD_ID=$(xinput --list | grep -i "ASUP1205:00 093A:2003 Touchpad" | awk -F'id=' '{print $2}' | awk '{print $1}')

# Function to set natural scrolling
set_natural_scrolling() {
    local DEVICE_ID=$1
    local VALUE=$2
    if [ -n "$DEVICE_ID" ]; then
        xinput --set-prop "$DEVICE_ID" "libinput Natural Scrolling Enabled" "$VALUE"
    fi
}

# Apply settings
set_natural_scrolling "$ASUS_MOUSE_ID" 0
set_natural_scrolling "$ZOWIE_MOUSE_ID" 0
set_natural_scrolling "$TOUCHPAD_ID" 1
echo "ID's:"
echo "$ASUS_MOUSE_ID"
echo "tp"
echo "$TOUCHPAD_ID"
