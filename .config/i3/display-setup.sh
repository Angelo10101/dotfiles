
#!/bin/bash
# Reset xrandr before setting up displays
xrandr --auto

# Detect connected monitors
connected_monitors=$(xrandr --query | grep " connected" | awk '{print $1}')

# Initialize monitor variables
primary_monitor=""
right_monitor=""
laptop_monitor=""

# Check if HDMI-0 is connected
if echo "$connected_monitors" | grep -q "HDMI-1"; then
  primary_monitor="HDMI-1"
fi

# Check if DP-0 is connected
if echo "$connected_monitors" | grep -q "DP-0"; then
  right_monitor="DP-0"
fi

# Find laptop display (assuming it's eDP-1 or similar)
for monitor in $connected_monitors; do
  if [[ "$monitor" == eDP* ]]; then
    laptop_monitor="$monitor"
    break
  fi
done

# If HDMI-0 is found, configure it as primary
if [ -n "$primary_monitor" ]; then
  echo "Setting $primary_monitor as primary."
  xrandr --output "$primary_monitor" --primary --mode 1920x1080 --rate 144 --pos 1920x0

  # Position DP-0 to the right if available
  if [ -n "$right_monitor" ]; then
    echo "Positioning $right_monitor to the right of $primary_monitor."
    xrandr --output "$right_monitor" --mode 1366x768 --rate 50 --pos 3840x0 --right-of "$primary_monitor"
  fi

  # Position the laptop display to the left if available
  if [ -n "$laptop_monitor" ]; then
    echo "Positioning $laptop_monitor to the left of $primary_monitor."
    xrandr --output "$laptop_monitor" --mode 1920x1080 --rate 60 --pos 0x0 --left-of "$primary_monitor"
  fi

  # Restore wallpaper using Nitrogen
  nitrogen --restore
else
  echo "HDMI-0 is not connected. No changes made."
fi

