#!/usr/bin/env bash
# Aplica mejoras de rendimiento y red a un Android TV por ADB.
# Uso: ./mejorar-stick.sh <IP_DEL_STICK>[:5555] [--launcher [archivo.apk]]
# --launcher instala Fran Launcher (https://github.com/Pakvothe/fran-launcher-tv),
# descargando el APK de Releases si no se pasa archivo. Requiere Android TV 10+.
# Requisito: en el stick activar Opciones de desarrollador > Depuración USB/ADB por red.
set -euo pipefail

command -v adb >/dev/null || { echo "Falta adb (instalá platform-tools)"; exit 1; }
[ $# -ge 1 ] || { echo "Uso: $0 <IP_DEL_STICK>[:5555] [--launcher [archivo.apk]]"; exit 1; }

target="$1"
install_launcher=0
apk=""
if [ "${2:-}" = "--launcher" ]; then
  install_launcher=1
  apk="${3:-}"
fi
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

if [ "$install_launcher" -eq 1 ]; then
  echo "== Fran Launcher =="
  sdk=$(sh getprop ro.build.version.sdk | tr -d '\r')
  if [ "$sdk" -lt 29 ]; then
    echo "Android demasiado viejo (SDK $sdk, hace falta 29+): se omite el launcher"
  else
    if [ -z "$apk" ]; then
      apk="$(mktemp -d)/fran-launcher.apk"
      curl -fsSL -o "$apk" https://github.com/Pakvothe/fran-launcher-tv/releases/latest/download/fran-launcher.apk
    fi
    adb -s "$target" install -r "$apk"
    sh cmd package compile -m speed -f pakvothe.franlauncher.tv
    sh cmd package set-home-activity pakvothe.franlauncher.tv/.Home
    # Si Home sigue abriendo el launcher original, se deshabilita (reversible):
    #   adb shell pm enable com.google.android.tvlauncher
    sh pm disable-user --user 0 com.google.android.tvlauncher || true
  fi
fi

echo "Listo. Reiniciá el stick para aplicar todo: adb -s $target reboot"
