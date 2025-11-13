#!/bin/bash

# Check if the external monitor is connected
if xrandr --query | grep "HDMI-A-1 connected"; then
  # If connected, apply the dual-monitor setup
  hyprctl keyword monitor "HDMI-A-1,1920x1080@100,0x0,1"
  hyprctl keyword monitor "eDP-1,1366x768@60,1920x312,1"
else
  # If not connected, use only the laptop screen
  hyprctl keyword monitor "eDP-1,1366x768@60,auto,1"
fi
