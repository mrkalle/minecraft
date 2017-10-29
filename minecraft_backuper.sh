#!/bin/bash

DATE=`date +%Y%m%d`
FILENAME=minecraft_$DATE.tar.gz

echo $FILENAME

tar -zcvf $FILENAME /home/minecraft/gretasvarld

bash /home/pi/dropbox_uploader.sh upload $FILENAME .

rm -rf $FILENAME