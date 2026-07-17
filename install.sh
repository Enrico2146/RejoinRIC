#!/bin/bash
echo "Sedang mengunduh dan memperbaiki file..."
cd ~
mkdir -p bot_premium
cd bot_premium

# Download file
curl -s -L https://raw.githubusercontent.com/Enrico2146/RejoinRIC/refs/heads/main/bot_manager.sh -o bot_manager.sh
curl -s -L https://raw.githubusercontent.com/Enrico2146/RejoinRIC/refs/heads/main/engine.sh -o engine.sh

# PERINTAH AJAIB: Membersihkan karakter miring otomatis
sed -i 's/\r$//' bot_manager.sh
sed -i 's/\r$//' engine.sh

# Beri izin eksekusi
chmod +x bot_manager.sh engine.sh

echo "Instalasi selesai dan tampilan sudah dibersihkan!"
echo "Jalankan dengan: ./bot_manager.sh"
