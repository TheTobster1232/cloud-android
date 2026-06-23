FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    qemu-system-x86 \
    novnc \
    websockify \
    wget \
    supervisor \
    && apt clean

WORKDIR /vm

# Download Ubuntu cloud image (always works)
RUN wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img \
    -O ubuntu.img

COPY start.sh /start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
