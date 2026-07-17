#!/bin/bash
APP_NAME=$1
LINK_GAME="roblox://placeId=97598239454123"

# Beri jeda awal acak agar tidak membebani sistem saat pertama kali dijalankan
sleep $((RANDOM % 30))

while true; do
    # Pengecekan lebih pasif: hanya jika aplikasi benar-benar hilang dari daftar proses
    if ! pidof "com.roblox.$APP_NAME" > /dev/null; then
        echo "[$(date)] $APP_NAME terdeteksi mati, bersiap restart..." >> ~/history.log
        
        su -c "am force-stop com.roblox.$APP_NAME"
        sleep 5
        
        # Buka aplikasi dengan cara yang paling ringan
        su -c "am start -a android.intent.action.VIEW -d '$LINK_GAME' -p com.roblox.$APP_NAME"
        
        # Jeda loading diperpanjang supaya tidak bentrok dengan proses lain
        sleep 60
    fi
    
    # Mode santai: cek lagi 3 menit kemudian
    sleep 180
done
