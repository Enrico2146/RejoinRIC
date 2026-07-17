#!/bin/bash
APP_NAME=$1
# Pastikan APP_NAME yang masuk adalah nama paket lengkap (misal: client1)

while true; do
    # Cek apakah proses aplikasi dengan nama paket tersebut benar-benar mati
    if ! pidof "com.roblox.$APP_NAME" > /dev/null; then
        # Gunakan nama paket lengkap untuk force-stop agar tidak menyerempet bot lain
        su -c "am force-stop com.roblox.$APP_NAME"
        sleep 10
        
        # Buka aplikasi spesifik
        su -c "monkey -p com.roblox.$APP_NAME -c android.intent.category.LAUNCHER 1"
        sleep 30
        
        # Join map
        su -c "am start -a android.intent.action.VIEW -d 'roblox://placeId=97598239454123' -p com.roblox.$APP_NAME"
    fi
    sleep 60
done
