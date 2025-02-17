#!/bin/bash
while true; do
    xinput --query-state 12 | grep -q "button[1]=down" && xdotool click 1
    sleep 0.05
done
