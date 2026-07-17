#!/bin/bash
APP_NAME=$1

while true; do
    # Cek apakah bot sedang jalan
    if ! pidof "com.roblox.$APP_NAME" > /dev/null; then
        # Cukup matikan aplikasinya saja, JANGAN hapus data (pm clear)
        su -c "am force-stop com.roblox.$APP_NAME"
        sleep 2
        
        # Jalankan kembali aplikasinya
        su -c "am start -a android.intent.action.VIEW -d 'roblox://' -p com.roblox.$APP_NAME"
        
        # Simpan log
        echo "[$(date)] $APP_NAME direstart (Session Aman)." >> ~/history.log
    fi
    
    sleep 30
done
