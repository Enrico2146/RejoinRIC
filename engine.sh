#!/bin/bash
# $1 adalah nama bot yang dikirim oleh bot_manager.sh
BOT_NAME=$1
LOG_FILE="/sdcard/Delta/GAG_LOG_${BOT_NAME}.txt"
PACKAGE="com.roblox.$BOT_NAME"
LINK="roblox://placeId=97598239454123"

# Variabel untuk membandingkan isi log
LAST_CONTENT=""

while true; do
    # 1. Pastikan file log ada
    if [ -f "$LOG_FILE" ]; then
        # 2. Ambil isi file log (kita ambil 10 baris terakhir)
        CURRENT_CONTENT=$(tail -n 5 "$LOG_FILE")

        # 3. Bandingkan dengan konten sebelumnya
        if [ "$CURRENT_CONTENT" == "$LAST_CONTENT" ]; then
            # Jika konten sama persis dengan menit lalu, berarti bot FREEZE/ERROR
            echo "[$(date)] $BOT_NAME terdeteksi FREEZE (Log statis), restart..." >> ~/history.log
            
            su -c "am force-stop $PACKAGE"
            sleep 5
            su -c "am start -a android.intent.action.VIEW -d '$LINK' -p $PACKAGE"
            
            # Tunggu 90 detik agar bot masuk game dengan tenang
            sleep 90
        else
            # Jika konten berubah, berarti bot masih aktif farming
            LAST_CONTENT="$CURRENT_CONTENT"
        fi
    else
        echo "[$(date)] File log untuk $BOT_NAME tidak ditemukan!" >> ~/history.log
    fi
    
    # Cek setiap 1 menit (60 detik)
    sleep 60
done
