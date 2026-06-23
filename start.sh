#!/bin/bash

# Start noVNC
websockify --web=/usr/share/novnc/ 8080 localhost:5901 &

# Boot QEMU with ISO + virtual disk
qemu-system-x86_64 \
  -m 2048 \
  -smp 2 \
  -machine accel=tcg \
  -vga virtio \
  -display vnc=:1 \
  -hda /android/android.img \
  -cdrom /android/android.iso \
  -boot d \
  -net nic \
  -net user
