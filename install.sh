#!/bin/bash
mkdir -p ~/sesi_backup
echo "Folder backup sesi berhasil dibuat!"
echo "Sedang mengunduh dan memperbaiki file..."
cd ~
mkdir -p bot_premium
cd bot_premium

# Download file
curl -s -L https://raw.githubusercontent.com/Enrico2146/RejoinRIC/refs/heads/main/bot_manager.sh -o bot_manager.sh
curl -s -L https://raw.githubusercontent.com/Enrico2146/RejoinRIC/refs/heads/main/engine.sh -o engine.sh

# Instal dos2unix dan gunakan untuk membersihkan file
# -y digunakan agar tidak perlu konfirmasi manual saat install
pkg install dos2unix -y > /dev/null 2>&1
dos2unix bot_manager.sh > /dev/null 2>&1
dos2unix engine.sh > /dev/null 2>&1


# Beri izin eksekusi
chmod +x bot_manager.sh engine.sh

echo "Instalasi selesai dan tampilan sudah dibersihkan!"
echo "Jalankan dengan: ./bot_manager.sh"
