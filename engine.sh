#!/bin/bash
APP_NAME=$1
LINK_GAME="roblox://placeId=97598239454123"

while true; do
    # Cek apakah aplikasi sedang fokus di layar (menggunakan logika skrip lama yang stabil)
    REKOR_SISTEM=$(su -c "dumpsys window windows | grep -E 'mCurrentFocus|mFocusedApp'" | tr -d '\r')

    if ! echo "$REKOR_SISTEM" | grep -q "com.roblox.$APP_NAME"; then
        echo "[$(date)] Mendeteksi $APP_NAME tidak aktif/FC. Memulai ulang..." >> ~/history.log
        
        su -c "am force-stop com.roblox.$APP_NAME"
        sleep 2
        
        # Buka aplikasi dengan Intent VIEW
        su -c "am start -a android.intent.action.VIEW -d '$LINK_GAME' -p com.roblox.$APP_NAME"
        
        # Jeda tunggu loading yang dinamis (15-25 detik) agar tidak membebani RAM
        sleep $((15 + RANDOM % 10))
    fi
    
    # Tunggu 30 detik sebelum pengecekan berikutnya
    sleep 30
done
