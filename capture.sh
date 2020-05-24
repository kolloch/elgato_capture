#!/usr/bin/env bash

cd $(dirname "$0")
. config.sh

# AUDIO_INPUT="-f alsa -thread_queue_size 512 -i $ALSA_DEVICE"
AUDIO_INPUT="-f pulse -i $PULSE_DEVICE"
VIDEO_INPUT="-f v4l2 -input_format nv12 -i $V4L_DEVICE"

set -x
exec $FFMPEG -y -vaapi_device /dev/dri/renderD128 \
    -thread_queue_size 512 $VIDEO_INPUT \
    -thread_queue_size 512 $AUDIO_INPUT \
    -vf 'format=nv12,hwupload' \
    -c:v hevc_vaapi -b:v 100M -maxrate:v 120M \
    -acodec copy \
    $1-hevc-uhd2160.mkv


# Dump some jpeg images
    # -filter_complex 'format=nv12,hwupload,split[vid][pic]' \
    # -map [vid] \
    # -c:v hevc_vaapi -b:v 100M -maxrate:v 120M -acodec copy \
    # $1-hevc-uhd2160.mkv \
    # -map [pic] \
    # -r 1/3 -c:v mjpeg_vaapi -global_quality 90 -f image2 \
    # $1-%03d.jpeg

# exec $FFMPEG -y -vaapi_device /dev/dri/renderD128 \
#     -f v4l2 -thread_queue_size 512 -input_format nv12 -i $V4L_DEVICE \
#     -thread_queue_size 512 $AUDIO_INPUT \
#     -vf 'format=p010,hwupload' \
#     -c:v hevc_vaapi -b:v 15M -acodec copy $1-hevc-uhd2160.mkv \
    # -vf 'format=nv12,hwupload' \
    # -r 1/3 -c:v mjpeg_vaapi -global_quality 90 -f image2 $1%03d.jpeg
    # -vf 'scale=hd720:flags=fast_bilinear,format=nv12' \
    # -c:v h264 -preset:v veryfast -acodec copy $1-h264-hd720.mkv \
    # -vf 'scale=hd1080:flags=fast_bilinear,format=nv12,hwupload' \
    # -c:v h264_vaapi -b:v 20M -maxrate:v 22M -acodec copy $1-h264-hd1080.mkv \
    # -vf 'format=nv12,hwupload' \
    # -c:v hevc_vaapi -b:v 100M -maxrate:v 120M -acodec copy $1-hevc-uhd2160.mkv \
    # -vf 'scale=hd1080:flags=fast_bilinear' \
    # -c:v libvpx-vp9 -row-mt 1 -pix_fmt yuv420p -acodec copy $1-vp9-hd.mkv
    # -vf 'scale=hd1080:flags=fast_bilinear,format=nv12' \
    # -c:v h264 -preset:v ultrafast -acodec copy $1-h264-hd.mkv \
