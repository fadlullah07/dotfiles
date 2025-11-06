#!/usr/bin/env bash

# Mendapatkan status governor yang sedang aktif
CURRENT_GOVERNOR=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)

# Opsi yang akan ditampilkan di menu
# Format: "Ikon Nama Pilihan"
OPTIONS="Logout\nSuspend\nReboot\nShutdown"

CHOSEN=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Power Menu")

case "$CHOSEN" in
"Logout")
  hyprctl dispatch exit
  ;;
"Suspend")
  systemctl suspend
  ;;
"Reboot")
  systemctl reboot
  ;;

"Shutdown")
  systemctl poweroff
  ;;
esac
