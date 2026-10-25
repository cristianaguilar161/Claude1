# Mejora del Android TV en la red vkg02

1. En el stick: Ajustes > Preferencias del dispositivo > Acerca de > tocar 7 veces "Número de compilación".
2. Activar "Depuración USB" / "Depuración ADB por red" en Opciones de desarrollador.
3. Desde la PC en la misma red: `./mejorar-stick.sh <IP_DEL_STICK>`

Cosas que el script no puede hacer (se hacen a mano):
- Conectar a la banda de 5 GHz (crear `vkg02-5G` en el router).
- Elegir canal libre (36-48 en 5 GHz; 1/6/11 en 2,4 GHz).
- Reservar IP por DHCP para la MAC del stick.
- WPA2/WPA3 y desactivar WPS en el router.
