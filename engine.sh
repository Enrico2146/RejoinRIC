#!/bin/bash
APP_NAME=$1
# Jeda acak biar tidak "nabrak" barengan
sleep $((RANDOM % 20)) 

while true; do
    if ! pidof "com.roblox.$APP_NAME" > /dev/null; then
        su -c "am force-stop com.roblox.$APP_NAME"
        sleep 10 # Beri napas setelah force-stop
        
        # Buka aplikasinya dulu saja (tanpa langsung join map)
        su -c "monkey -p com.roblox.$APP_NAME -c android.intent.category.LAUNCHER 1"
        sleep 30 # Tunggu loading awal (login/menu)
        
        # Baru setelah login stabil, tembak ke map
        su -c "am start -a android.intent.action.VIEW -d 'roblox://placeId=97598239454123' -p com.roblox.$APP_NAME"
    fi
    sleep 60
done
