#!/bin/bash
# Skrip instalasi otomatis untuk Bot Premium

echo "Sedang mengunduh file sistem..."
cd ~
mkdir -p bot_premium
cd bot_premium

# Mengunduh file dari link GitHub kamu
curl -s -L https://raw.githubusercontent.com/Enrico2146/RejoinRIC/refs/heads/main/bot_manager.sh -o bot_manager.sh
curl -s -L https://raw.githubusercontent.com/Enrico2146/RejoinRIC/refs/heads/main/engine.sh -o engine.sh

# Memberikan izin eksekusi
chmod +x bot_manager.sh engine.sh

echo "---------------------------------------"
echo "Instalasi sukses! Jalankan dengan:"
echo "cd ~/bot_premium && ./bot_manager.sh"
echo "---------------------------------------"
