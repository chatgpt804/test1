#!/bin/bash

# Start X server and window manager
Xvfb :1 -screen 0 1024x768x16 &
fluxbox &

# Start QEMU without KVM
qemu-system-x86_64 \
    -m 4096 \
    -smp 2 \
    -drive file="$DISK_FILE",format=qcow2 \
    -cdrom "$ISO_FILE" \
    -boot d \
    -vga std \
    -device usb-tablet \
    -net nic \
    -net user \
    -display vnc=127.0.0.1:0 \
    -daemonize

# Start noVNC for remote access
websockify --web /usr/share/novnc/ 6080 localhost:5900
