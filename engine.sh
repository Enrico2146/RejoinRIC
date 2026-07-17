#!/bin/bash
# 1. Terima argumen dari bot_manager.sh
# Jika bot_manager mengirim 'corihood', maka $1 = 'corihood'
B_NAME=$(echo "$1" | sed 's/com.roblox.//')

# 2. Definisikan paket dan file log
PACKAGE="com.roblox.$B_NAME"
LOG_FILE="/sdcard/Delta/GAG_LOG_${B_NAME}.txt"
LINK="roblox://placeId=97598239454123"

# 3. Variabel untuk deteksi freeze
LAST_CONTENT=""

echo "[DEBUG] Memulai engine untuk: $PACKAGE"

while true; do
    # A. Cek apakah aplikasi jalan
    if pidof "$PACKAGE" > /dev/null; then
        # B. Cek file log untuk deteksi freeze
        if [ -f "$LOG_FILE" ]; then
            CURRENT_CONTENT=$(tail -n 5 "$LOG_FILE")
            
            if [ "$CURRENT_CONTENT" == "$LAST_CONTENT" ] && [ ! -z "$CURRENT_CONTENT" ]; then
                echo "[$(date)] $B_NAME FREEZE terdeteksi (Log statis). Restarting..." >> ~/history.log
                su -c "am force-stop $PACKAGE"
                sleep 5
                su -c "monkey -p $PACKAGE -c android.intent.category.LAUNCHER 1"
                sleep 60
            else
                LAST_CONTENT="$CURRENT_CONTENT"
            fi
        fi
    else
        # C. Jika aplikasi mati total
        echo "[$(date)] $B_NAME mati. Memulai ulang..." >> ~/history.log
        su -c "monkey -p $PACKAGE -c android.intent.category.LAUNCHER 1"
        sleep 60
    fi
    sleep 60
done
