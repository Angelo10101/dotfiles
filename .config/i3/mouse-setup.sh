#!/bin/bash

mouse_id=$(xinput | grep "ZOWIE" | awk -F 'id=' '{print $2}' | awk '{print $1}')
xinput --set-prop "$mouse_id" "libinput Natural Scrolling Enabled" 0
