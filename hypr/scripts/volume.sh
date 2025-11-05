#!/bin/bash

# Fungsi untuk mengirim notifikasi (Tidak ada perubahan di sini)
send_notification() {
  # Dapatkan volume dan status mute menggunakan wpctl
  STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
  VOLUME=$(echo "$STATUS" | awk '{print int($2 * 100)}')

  # Periksa apakah output mengandung kata "[MUTED]"
  if echo "$STATUS" | grep -q "MUTED"; then
    MUTED="true"
  else
    MUTED="false"
  fi

  # Tentukan ikon berdasarkan status
  if [ "$MUTED" = "true" ]; then
    ICON="🔇"
  elif [ "$VOLUME" -eq 0 ]; then
    ICON="🔈"
  elif [ "$VOLUME" -le 30 ]; then
    ICON="🔉"
  else
    ICON="🔊"
  fi

  # Buat progress bar
  BAR=""
  for i in {1..20}; do
    if [ $i -le $((VOLUME / 5)) ]; then
      BAR="${BAR}█"
    else
      BAR="${BAR}░"
    fi
  done

  # Kirim notifikasi
  notify-send -a "volume-indicator" "${ICON} Volume" "${BAR} ${VOLUME}%" -t 1000 -r 9991
}

# --- BAGIAN UTAMA YANG DIPERBAIKI ---
# Lakukan aksi berdasarkan argumen, lalu tampilkan notifikasi
case $1 in
mute)
  # Toggle (nyalakan/matikan) mute
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  send_notification
  ;;
show)
  # Hanya tampilkan notifikasi tanpa mengubah apa pun
  send_notification
  ;;
*)
  echo "Penggunaan: $0 {up|down|mute|show}"
  exit 1
  ;;
esac
