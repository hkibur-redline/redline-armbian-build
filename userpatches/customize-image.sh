#!/bin/bash

# Install dependencies
apt update
apt install meson cmake python3-pip xorg -y
pip install flask flask-cors ctypesgen

cp -r /tmp/overlay /home/soft
(cd /home/soft/brake_machine && ./build.sh && find .. -name bm_host-*.deb -exec bash -c "dpkg -i \"{}\"" \;)

# Install brake machine software packages
BM_APP_PATH=$(find /home/soft -name bm-app-*.deb -maxdepth 1)
dpkg -i $BM_APP_PATH
apt install --fix-broken -y
dpkg -i $BM_APP_PATH

# Boot logo stuff
echo "bootlogo=true" >> /boot/armbianEnv.txt
echo "console=serial" >> /boot/armbianEnv.txt
rm /root/.not_logged_in_yet