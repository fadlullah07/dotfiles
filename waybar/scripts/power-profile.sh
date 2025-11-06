#!/usr/bin/env bash

# Mendapatkan status governor yang sedang aktif
CURRENT_GOVERNOR=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)

# Opsi yang akan ditampilkan di menu
# Format: "Ikon Nama Pilihan"
OPTIONS="🔋 Powersave\n⚖️ Balance\n🚀 Performance"

# Buat variabel baru untuk nama yang akan ditampilkan
DISPLAY_NAME=""

# Cek jika governor saat ini adalah "userspace"
if [ "$CURRENT_GOVERNOR" == "userspace" ]; then
  # Jika ya, atur nama tampilan menjadi "Balance"
  DISPLAY_NAME="Balance"
else
  # Jika tidak, gunakan nama governor aslinya
  DISPLAY_NAME="$CURRENT_GOVERNOR"
fi

CHOSEN=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Mode Aktif: $DISPLAY_NAME")

case "$CHOSEN" in
"🔋 Powersave")
  sudo cpupower frequency-set -g powersave
  notify-send -i "power-profile-power-saver-symbolic" "Mode Daya Diubah" "CPU sekarang dalam mode Powersave."

  ;;

"⚖️ Balance")
  bash -c "sudo cpupower frequency-set -f 2.5GHz"
  # Notifikasi jika berhasil
  notify-send -i "power-profile-balanced-symbolic" "Mode Daya Diubah" "CPU sekarang dalam mode Balance (Manual @ 2.5GHz)."

  ;;

"🚀 Performance")
  sudo cpupower frequency-set -g performance
  # Notifikasi jika berhasil
  notify-send -i "power-profile-performance-symbolic" "Mode Daya Diubah" "CPU sekarang dalam mode Performance."

  ;;
esac
