#!/bin/bash
echo "Sedang mengunduh dan memperbaiki file..."
cd ~
mkdir -p bot_premium
cd bot_premium

# Download file
curl -s -L https://raw.githubusercontent.com/Enrico2146/RejoinRIC/refs/heads/main/bot_manager.sh -o bot_manager.sh
curl -s -L https://raw.githubusercontent.com/Enrico2146/RejoinRIC/refs/heads/main/engine.sh -o engine.sh

# Perintah ini lebih "brutal" untuk menghapus semua karakter yang aneh
tr -d '\r' < bot_manager.sh > temp.sh && mv temp.sh bot_manager.sh
tr -d '\r' < engine.sh > temp.sh && mv temp.sh engine.sh

# Beri izin eksekusi
chmod +x bot_manager.sh engine.sh

echo "Instalasi selesai dan tampilan sudah dibersihkan!"
echo "Jalankan dengan: ./bot_manager.sh"
