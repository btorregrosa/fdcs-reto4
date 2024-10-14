FROM phusion/baseimage:noble-1.0.0

RUN apt update -y \
    && apt install -y \
    ssh \
    iputils-ping \
    net-tools \
    nginx \
    && echo 'root:123456789' | chpasswd \
    && sed -i "s/#PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config \
    && sed -i "s/#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config \
    && echo 'GatewayPorts yes' >> /etc/ssh/sshd_config \
    && mkdir -p /var/run/sshd

#COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 22 80 9000

CMD service nginx start && /usr/sbin/sshd -D
