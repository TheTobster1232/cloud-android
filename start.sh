#!/bin/bash

# Start noVNC
websockify --web=/usr/share/novnc/ 8080 localhost:5901 &

# Run QEMU in pure text mode for stable Android-x86 install
qemu-system-x86_64 \
  -m 2048 \
  -smp 2 \
  -machine accel=tcg \
  -nographic \
  -vga none \
  -hda /android/android.img \
  -cdrom /android/android.iso \
  -boot d \
  -net nic \
  -net user \
  -serial mon:stdio
