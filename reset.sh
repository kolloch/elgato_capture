#!/usr/bin/env bash

cd $(dirname "$0")
. config.sh

sudo sh -c "echo 0 > $SYS_DIR/authorized"
sudo sh -c "echo 1 > $SYS_DIR/authorized"

echo -n "Wait for device: " >&2
wait_seconds=30
until test $((wait_seconds--)) -eq 0 -o -r "$V4L_DEVICE" ; do 
    echo -n "." >&2
    sleep 1
done
echo " done." >&2

echo "Device reappeared after $((30 - wait_seconds)) seconds." >&2

echo -n "Waiting for audio: " >&2
wait_seconds=30
until test $((wait_seconds--)) -eq 0 ; do
    if ffprobe -f alsa -i $AUDIO_DEVICE > /dev/null 2>&1; then
        break
    fi
    echo -n "." >&2
    sleep 1
done
echo " done." >&2

echo "Audio after $((30 - wait_seconds)) seconds." >&2
