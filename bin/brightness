#!/bin/bash

# Fungsi untuk mengirim notifikasi
send_notification() {
  # METODE BARU: Langsung dapatkan angka persentase dari brightnessctl
  # Ini lebih andal daripada menghitung manual
  PERCENTAGE=$(brightnessctl -m | awk -F',' '{print substr($4, 0, length($4)-1)}')

  # Buat progress bar
  BAR=""
  for i in {1..20}; do
    # Setiap bar mewakili 5%
    if [ $i -le $((PERCENTAGE / 5)) ]; then
      BAR="${BAR}█" # Blok terisi
    else
      BAR="${BAR}░" # Blok kosong
    fi
  done

  # Kirim notifikasi menggunakan flag -a yang benar untuk Mako
  notify-send -a "brightness-indicator" "Brightness" "${BAR} ${PERCENTAGE}%" -t 1000
}

# Periksa argumen yang diberikan ke script
case $1 in
up)
  # Naikkan kecerahan sebesar 5%
  brightnessctl set +5% >/dev/null
  send_notification
  ;;
down)
  # Turunkan kecerahan sebesar 5%
  brightnessctl set 5%- >/dev/null
  send_notification
  ;;
*)
  echo "Penggunaan: $0 {up|down}"
  exit 1
  ;;
esac
