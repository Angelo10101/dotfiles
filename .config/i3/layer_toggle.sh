#!/bin/bash
if xmodmap | grep -q 'Hyper_L'; then
    xmodmap ~/.config/i3/modmap
else
    xmodmap -e "keycode 66 = Hyper_L"
fi
