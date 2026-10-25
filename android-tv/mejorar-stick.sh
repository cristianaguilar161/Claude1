#!/usr/bin/env bash
# Aplica mejoras de rendimiento y red a un Android TV por ADB.
# Uso: ./mejorar-stick.sh <IP_DEL_STICK>[:5555]
# Requisito: en el stick activar Opciones de desarrollador > Depuración USB/ADB por red.
set -euo pipefail

command -v adb >/dev/null || { echo "Falta adb (instalá platform-tools)"; exit 1; }
[ $# -eq 1 ] || { echo "Uso: $0 <IP_DEL_STICK>[:5555]"; exit 1; }

target="$1"
[[ "$target" == *:* ]] || target="$target:5555"
adb connect "$target" >/dev/null
sh() { adb -s "$target" shell "$@"; }

echo "== Estado actual de WiFi =="
sh dumpsys wifi | grep -m1 "mWifiInfo" || true

echo "== Animaciones reducidas (menos lag en la interfaz) =="
for k in window_animation_scale transition_animation_scale animator_duration_scale; do
  sh settings put global "$k" 0.5
done

echo "== DNS privado rápido (Cloudflare) =="
sh settings put global private_dns_mode hostname
sh settings put global private_dns_specifier one.one.one.one

echo "== Wifi siempre activo =="
sh settings put global wifi_sleep_policy 2 || true
sh settings put global wifi_networks_available_notification_on 0 || true

echo "== Limpieza de caché de apps =="
sh pm trim-caches 999G || true

echo "== Espacio libre =="
sh df /data | tail -1

echo "Listo. Reiniciá el stick para aplicar todo: adb -s $target reboot"
