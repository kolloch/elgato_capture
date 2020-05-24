FFMPEG=../ffmpeg-build/result/bin/ffmpeg
V4L_DEVICE=/dev/v4l/by-id/usb-Elgato_Cam_Link_4K_0004550EAA000-video-index0
# Alsa had audio sync issues!!
ALSA_DEVICE=sysdefault:CARD=C4K
PULSE_DEVICE=alsa_input.usb-Elgato_Cam_Link_4K_0004550EAA000-03.analog-stereo
AUDIO_INPUT="-f pulse -i $PULSE_DEVICE"
SYS_DIR=$(./find-elgato4k-sys-dir.sh)
