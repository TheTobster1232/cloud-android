FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    qemu-system-x86 \
    novnc \
    websockify \
    wget \
    supervisor \
    qemu-utils \
    && apt clean

WORKDIR /android

# Download your ISO from GitHub Release Assets
ADD https://github.com/TheTobster1232/cloud-android/releases/download/v1.0/android.iso /android/android.iso

# Create a 4GB virtual disk for Android installation
RUN qemu-img create -f raw /android/android.img 4G

COPY start.sh /start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
