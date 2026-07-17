#!/bin/bash
get_bots() { pm list packages | grep "com.roblox." | sed 's/package:com.roblox.//'; }

while true; do
    clear
    echo "=================================="
    echo "    BOT MANAGER (PREMIUM LOGIC)   "
    echo "=================================="
    BOTS=($(get_bots))
    for i in "${!BOTS[@]}"; do
        echo "$((i+1))) ${BOTS[$i]}"
    done
    
    echo "----------------------------------"
    echo "A) Start All | 3) Log | S) Stop All | Q) Keluar"
    echo "=================================="
    read -p "Pilihan: " PILIH

    case $PILIH in
        [0-9]*)
            SELECTED=${BOTS[$((PILIH-1))]}
            tmux new-session -d -s "bot_$SELECTED" "./engine.sh $SELECTED"
            echo "Bot $SELECTED started!" && sleep 2
            ;;
        A)
            for b in "${BOTS[@]}"; do
                tmux new-session -d -s "bot_$b" "./engine.sh $b"
                sleep 5
            done
            echo "All bots started!" && sleep 2
            ;;
        3)
            clear
            echo "Memantau log aktivitas (Tekan Ctrl+C untuk kembali)..."
            echo "--------------------------------------------------------"
            tail -n 20 -f ~/history.log
            ;;
        S)
            tmux kill-server
            echo "Semua bot dihentikan." && sleep 2
            ;;
        Q) break ;;
        *) echo "Pilihan tidak valid!" && sleep 1 ;;
    esac
done
