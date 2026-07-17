#!/bin/bash
# Nama paket diambil dari argumen pertama saat skrip dijalankan
APP_NAME=$1
LINK_GAME="roblox://placeId=97598239454123"

# Jeda acak 1-60 detik saat pertama kali jalan agar tidak menumpuk saat startup
sleep $((RANDOM % 60))

while true; do
    # Menggunakan pidof: cara paling enteng buat cek aplikasi jalan atau tidak
    if ! pidof "com.roblox.$APP_NAME" > /dev/null; then
        echo "[$(date)] $APP_NAME mati, restart..." >> ~/history.log
        
        su -c "am force-stop com.roblox.$APP_NAME"
        sleep 5
        
        # Buka aplikasi dengan mode "nice" agar RAM tidak meledak (tidak diprioritaskan)
        su -c "nice -n 19 am start -a android.intent.action.VIEW -d '$LINK_GAME' -p com.roblox.$APP_NAME"
        
        # Tunggu loading cukup lama agar bot lain tidak terganggu
        sleep 60
    fi
    
    # Cek berkala tiap 3 menit (180 detik)
    sleep 180
done
