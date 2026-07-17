#!/bin/bash
APP_NAME=$1

while true; do
    # Cek apakah bot sedang jalan
    if ! pidof "com.roblox.$APP_NAME" > /dev/null; then
        # Hapus cache dan jalankan kembali
        su -c "pm clear com.roblox.$APP_NAME"
        sleep 2
        su -c "am start -a android.intent.action.VIEW -d 'roblox://' -p com.roblox.$APP_NAME"
        
        # Simpan log ke history.log
        echo "[$(date)] $APP_NAME direstart." >> ~/history.log
    fi
    
    # Tunggu 30 detik sebelum cek lagi
    sleep 30
done
