#!/bin/bash

# Get brake machine host
rm -rf ./userpatches/overlay/brake_machine
git clone git@github.com:Redline-BCLD/brake_machine.git ./userpatches/overlay/brake_machine --recurse-submodules --depth=1

# Get the brake machine interface
rm -rf /tmp/brake_machine_app
git clone git@github.com:Redline-BCLD/brake_machine_app.git /tmp/brake_machine_app/ --depth=1
(cd /tmp/brake_machine_app && npm install && npm run cross)
mv /tmp/brake_machine_app/*.deb ./userpatches/overlay

# Build the image
./compile.sh build BOARD=rockpro64 BRANCH=legacy BUILD_DESKTOP=no BUILD_MINIMAL=no KERNEL_CONFIGURE=no RELEASE=bullseye

