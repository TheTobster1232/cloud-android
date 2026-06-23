FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    qemu-system-x86 \
    novnc \
    websockify \
    wget \
    unzip \
    xz-utils \
    supervisor \
    && apt clean

WORKDIR /android

# Download Android-x86 with certificate checks disabled (Railway requires this)
RUN wget --no-check-certificate -O android.img.xz https://dl.android-x86.org/releases/9.0-r2/android-x86_64-9.0-r2.img.xz \
    && xz -d android.img.xz \
    && mv android-x86_64-9.0-r2.img android.img

COPY start.sh /start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
