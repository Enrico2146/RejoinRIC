#!/bin/bash
B_NAME=$(echo "$1" | sed 's/com.roblox.//')
PACKAGE="com.roblox.$B_NAME"
LOG_FILE="/sdcard/Delta/GAG_LOG_${B_NAME}.txt"

# Variabel untuk deteksi freeze
LAST_CONTENT=""

# UBAH SLEEP KE 480 detik (8 menit) 
# Agar lebih panjang dari cooldown 7 menit bot kamu
CHECK_INTERVAL=480 

while true; do
    if pidof "$PACKAGE" > /dev/null; then
        if [ -f "$LOG_FILE" ]; then
            CURRENT_CONTENT=$(tail -n 5 "$LOG_FILE")
            
            if [ "$CURRENT_CONTENT" == "$LAST_CONTENT" ] && [ ! -z "$CURRENT_CONTENT" ]; then
                echo "[$(date)] $B_NAME Stuck/Freeze (Log tidak berubah). Restarting..." >> ~/history.log
                su -c "am force-stop $PACKAGE"
                sleep 5
                su -c "monkey -p $PACKAGE -c android.intent.category.LAUNCHER 1"
                sleep 120 # Beri waktu lebih lama untuk loading ulang
            else
                LAST_CONTENT="$CURRENT_CONTENT"
            fi
        fi
    else
        echo "[$(date)] $B_NAME mati. Memulai ulang..." >> ~/history.log
        su -c "monkey -p $PACKAGE -c android.intent.category.LAUNCHER 1"
        sleep 120
    fi
    
    # Pengecekan dilakukan 8 menit sekali
    sleep $CHECK_INTERVAL
done
