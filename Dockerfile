FROM everydayhero/ubuntu:16.04

EXPOSE 22
ENV BANNER="Welcome to the tunnel" USER=tunnel SHELL=/bin/bash PASSWORD="" AUTHORIZED_KEY=""

ENTRYPOINT ["/var/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

RUN apt-get update && \
  apt-get install -y openssh-server && \
  mkdir /var/run/sshd && \
  touch /var/log/lastlog && \
  rm /etc/ssh/ssh_host_*

ADD sshd_config /etc/ssh/
ADD entrypoint.sh /var/