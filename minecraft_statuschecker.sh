#!/bin/bash

# Check the status
IPADDR=$(ip addr show wlan0 | grep -m 1 "inet" | grep -oE "\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b" | grep -m 1 "")
echo "IPADDR: $IPADDR"

STATUS=1

if [ $IPADDR != "192.168.2.69" ];
then
  STATUS=0
fi

echo "$STATUS"

if [ $STATUS -eq 0 ]
then

   LATESTVERSION=$(curl -G "https://getbukkit.org/download/spigot" | grep "<h2>" | head -1 | sed -e 's/<h2>\(.*\)<\/h2>/\1/')

   echo "LATESTVERSION: >$LATESTVERSION<"

   CURRENTVERSION=$(cat /home/minecraft-start.sh | cut -c58-70 | sed 's/\(.*\).jar.*/\1/' | tr -d '[:space:]')

   echo "CURRENTVERSION: >$CURRENTVERSION<"

   if [ $LATESTVERSION != $CURRENTVERSION ]
   then

      STATUS=0

   fi
fi

# Send status to server
curl -G "https://minecraftstatus.azurewebsites.net/api/MinecraftStoreStatus?code=8LNW2DKPxWIjtekFD0ZwbSMqoCDx0YiiT/TBAatnLUX2TsCUAVe97A==&statusGood=$STATUS"
