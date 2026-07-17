#!/bin/bash
BOT_NAME=$(echo "$1" | sed 's/com.roblox.//')
PACKAGE="com.roblox.$BOT_NAME"
LINK="roblox://placeId=97598239454123"

echo "[DEBUG] Memulai skrip untuk $PACKAGE"

while true; do
    # Cek apakah aplikasi berjalan
    if pidof "$PACKAGE" > /dev/null; then
        echo "[DEBUG] $PACKAGE sudah berjalan. Memeriksa log..."
        # Logika cek log (seperti sebelumnya)
    else
        echo "[DEBUG] $PACKAGE tidak terdeteksi! Mencoba menjalankan..."
        # Menggunakan format perintah yang paling standar di Android
        su -c "am start -W -a android.intent.action.VIEW -d '$LINK' -p $PACKAGE"
        
        if [ $? -eq 0 ]; then
            echo "[DEBUG] Perintah buka aplikasi berhasil dikirim."
        else
            echo "[DEBUG] Gagal menjalankan aplikasi. Periksa apakah paket $PACKAGE benar."
        fi
        sleep 60
    fi
    sleep 30
done
