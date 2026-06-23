#!/bin/bash

# Start noVNC
websockify --web=/usr/share/novnc/ 8080 localhost:5901 &

# Start QEMU with Android-x86
qemu-system-x86_64 \
  -m 2048 \
  -smp 2 \
  -machine accel=tcg \
  -vga virtio \
  -display vnc=:1 \
  -hda /android/android.img \
  -net nic \
  -net user
