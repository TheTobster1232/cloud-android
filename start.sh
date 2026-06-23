#!/bin/bash

websockify --web=/usr/share/novnc/ 8080 localhost:5901 &

qemu-system-x86_64 \
  -m 2048 \
  -smp 2 \
  -machine accel=tcg \
  -vga virtio \
  -display vnc=:1 \
  -hda /vm/ubuntu.img \
  -net nic \
  -net user
