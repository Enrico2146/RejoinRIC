#!/bin/bash
APP_NAME=$1

sleep $((RANDOM % 10))

while true; do
    # Cek apakah aplikasi bot sedang berjalan
    if ! pidof "com.roblox.$APP_NAME" > /dev/null; then
        echo "[$(date)] Mendeteksi $APP_NAME mati, bersiap restart..." >> ~/history.log
        
        # Matikan paksa aplikasi (Sesi login kamu tetap aman)
        su -c "am force-stop com.roblox.$APP_NAME"
        sleep 3
        
        # Jalankan aplikasi dan langsung tembak ke MAP menggunakan link kamu
        # Catatan: Menggunakan 'placeId' (huruf d kecil) agar sesuai dengan sistem Android Roblox
        su -c "am start -a android.intent.action.VIEW -d 'roblox://placeId=97598239454123' -p com.roblox.$APP_NAME"
        
        echo "[$(date)] $APP_NAME berhasil dibuka langsung menuju map." >> ~/history.log
    fi
    
    # Tunggu 30 detik sebelum melakukan pengecekan ulang
    sleep 30
done
