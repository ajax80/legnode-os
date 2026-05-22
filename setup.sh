#!/bin/sh
# legnode-os setup — run as root on a fresh Alpine 3.23 i386 install
# target: HP Compaq nx6110, Pentium M, Intel 915GM

set -e

# enable community repo
sed -i 's|#http://mirrors.edge.kernel.org/alpine/v3.23/community|http://mirrors.edge.kernel.org/alpine/v3.23/community|' /etc/apk/repositories
apk update

# core packages
apk add sudo python3 py3-pip py3-numpy git dbus alsa-utils \
    pulseaudio pulseaudio-utils eudev \
    xorg-server xf86-video-intel xf86-input-libinput \
    openbox netsurf terminus-font \
    py3-fastapi py3-rich py3-aiofiles gcc python3-dev musl-dev

# uvicorn via pip (not in apk)
pip3 install uvicorn websockets --break-system-packages

# udev at boot
rc-update add udev sysinit
rc-update add udev-trigger sysinit

# sudo for wheel
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# clone mishmaath
git clone https://github.com/ajax80/mishmaath /opt/mishmaath

# install OpenRC service
cp services/mishmaath /etc/init.d/mishmaath
chmod +x /etc/init.d/mishmaath
rc-update add mishmaath default

# openbox autostart
OBOX_DIR=/home/ajax80/.config/openbox
mkdir -p "$OBOX_DIR"
cp openbox/autostart "$OBOX_DIR/autostart"
chmod +x "$OBOX_DIR/autostart"
chown -R ajax80:ajax80 /home/ajax80/.config

echo ""
echo "legnode ready. reboot and mishmaath starts at boot."
echo "dashboard: http://localhost:8765"
