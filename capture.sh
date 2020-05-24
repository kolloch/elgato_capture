#!/usr/bin/env bash

cd $(dirname "$0")
. config.sh

# AUDIO_INPUT="-f alsa -thread_queue_size 512 -i $ALSA_DEVICE"
AUDIO_INPUT="-f pulse -i $PULSE_DEVICE"

exec $FFMPEG -y -vaapi_device /dev/dri/renderD128 \
    -f v4l2 -thread_queue_size 512 -input_format nv12 -i $V4L_DEVICE \
    -thread_queue_size 512 $AUDIO_INPUT \
    -vf 'format=nv12,hwupload' \
    -c:v hevc_vaapi -b:v 100M -maxrate:v 120M -acodec copy $*