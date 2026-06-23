FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    qemu-system-x86 \
    novnc \
    websockify \
    xz-utils \
    supervisor \
    && apt clean

WORKDIR /android

# Use the local Android image you upload to the repo
COPY android.img.xz /android/android.img.xz

RUN xz -d android.img.xz

COPY start.sh /start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
