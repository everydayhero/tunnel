FROM everydayhero/ubuntu:16.04

EXPOSE 22
ENV BANNER="Welcome to the tunnel" USER=tunnel SHELL=/bin/bash PASSWORD="" AUTHORIZED_KEY=""

HEALTHCHECK --start-period=5s CMD ssh -Q protocol-version 0.0.0.0 | grep 2

CMD ["/usr/bin/tunnel"]

RUN apt-get update && \
  apt-get install -y openssh-server && \
  rm -r /var/lib/apt/lists/* && \
  mkdir /var/run/sshd && \
  touch /var/log/lastlog && \
  rm /etc/ssh/ssh_host_*

ADD sshd_config /etc/ssh/
ADD tunnel /usr/bin/
