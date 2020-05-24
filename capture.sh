#!/usr/bin/env bash

ffmpeg=../ffmpeg-build/result/bin/ffmpeg
V4L_DEVICE=/dev/v4l/by-id/usb-Elgato_Cam_Link_4K_0004550EAA000-video-index0
exec $ffmpeg -y -vaapi_device /dev/dri/renderD128 \
    -f v4l2 -thread_queue_size 512 -input_format nv12 -i $V4L_DEVICE \
    -f alsa -thread_queue_size 512 -i sysdefault:CARD=C4K \
    -vf 'format=nv12,hwupload' \
    -c:v hevc_vaapi -b:v 100M -maxrate:v 120M -acodec copy $* output-combined.mkv