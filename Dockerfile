FROM daocloud.io/library/java:8u40-b09
MAINTAINER JiYun Tech Team <mboss0@163.com>
RUN mkdir -p /var/ww
VOLUME /var/ww
WORKDIR /var/ww
ADD ./sources.list /etc/apt/sources.list
ADD ./ffmpeg-release-amd64-static.tar.xz /var/ww/ffmpeg-release-amd64-static.tar.xz
ADD ./xz-5.2.4.tar.bz2 /var/ww/xz-5.2.4.tar.bz2
RUN set -x && apt-get update && apt-get install -y --no-install-recommends  openssh-server tzdata build-essential bzip2  && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/*
RUN mkdir /var/run/sshd && \
    rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo 'Asia/Shanghai' > /etc/timezone && \
    echo "Port 22" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    rm /etc/ssh/ssh_host_* && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' && \
    ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' && \
    ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''

ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

RUN echo "sshd:ALL" >> /etc/hosts.allow

RUN mkdir -p /var/www
VOLUME /var/www
WORKDIR /var/www

ENTRYPOINT ["/bin/bash", "/start.sh"]
