#!/bin/bash
get_bots() { pm list packages | grep "com.roblox." | sed 's/package:com.roblox.//'; }
while true; do
    clear
    echo "=================================="
    echo "    BOT MANAGER (PREMIUM LOGIC)   "
    echo "=================================="
    BOTS=($(get_bots))
    for i in "${!BOTS[@]}"; do echo "$((i+1))) ${BOTS[$i]}"; done
    echo "----------------------------------"
    echo "A) Start All | 3) Log | S) Stop All | Q) Keluar"
    echo "B) Backup Sesi | R) Restore Sesi"
    echo "=================================="
    read -p "Pilihan: " PILIH

    case $PILIH in
        [0-9]*)
            SELECTED=${BOTS[$((PILIH-1))]}
            tmux new-session -d -s "bot_$SELECTED" "./engine.sh $SELECTED"
            echo "Bot $SELECTED started!" && sleep 2 ;;
        A)
            # Jalankan antrean di latar belakang menggunakan fungsi &
            (
                JEDA=90
                for b in "${BOTS[@]}"; do 
                    tmux new-session -d -s "bot_$b" "./engine.sh $b"
                    sleep $JEDA
                done
            ) &
            echo "Antrean bot dijalankan di latar belakang." && sleep 2 ;;
        3)
            clear
            echo "Memantau log aktivitas (Tekan Ctrl+C untuk kembali)..."
            tail -n 20 -f ~/history.log ;;
        S)
           S)
            echo "🛑 Menghentikan semua bot..."
            # 1. Matikan semua sesi tmux agar engine.sh berhenti
            tmux kill-server
            
            # 2. Force stop semua paket aplikasi yang mengandung nama roblox
            # Ini akan menyapu bersih semua aplikasi roblox yang sedang jalan
            su -c "pm list packages | grep 'roblox' | sed 's/package://' | xargs -L1 am force-stop"
            
            echo "✅ Semua bot berhasil dihentikan!"
            sleep 2 ;;
        B)
            read -p "Masukkan nama bot (contoh: client1): " B_NAME
            mkdir -p ~/sesi_backup/$B_NAME
            su -c "cp -r /data/data/com.roblox.$B_NAME/files/* ~/sesi_backup/$B_NAME/"
            echo "Sesi $B_NAME berhasil di-backup!" && sleep 2 ;;
        R)
            read -p "Masukkan nama bot untuk di-restore (contoh: client1): " R_NAME
            if [ -d "~/sesi_backup/$R_NAME" ]; then
                su -c "cp -r ~/sesi_backup/$R_NAME/* /data/data/com.roblox.$R_NAME/files/"
                echo "Sesi $R_NAME berhasil dikembalikan!"
            else
                echo "Folder backup tidak ditemukan!"
            fi
            sleep 2 ;;
        Q) break ;;
        *) echo "Pilihan tidak valid!" && sleep 1 ;;
    esac
done
