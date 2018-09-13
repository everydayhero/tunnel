#!/usr/bin/env bash

set -euo pipefail

echo "${BANNER:-}" > /etc/issue.net

if [ -n "${RSA_HOST_KEY:-}" ]; then
  echo "Setting host RSA key"
  echo "$RSA_HOST_KEY" > /etc/ssh/ssh_host_rsa_key
else
  echo "Generating random host RSA key"
  ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
fi

echo "Creating user $USER"
useradd --no-log-init --create-home --shell "$SHELL" --user-group "$USER"
su "$USER" -c 'touch ~/.hushlogin'

if [ -n "$PASSWORD" ]; then
  echo "Setting password"
  echo -e "${PASSWORD}\n${PASSWORD}" | passwd "$USER" 2> /dev/null
fi

if [ -n "$AUTHORIZED_KEY" ]; then
  echo "Associating public key"
  su "$USER" -c 'mkdir ~/.ssh'
  echo "$AUTHORIZED_KEY" | su "$USER" -c 'tee ~/.ssh/authorized_keys' > /dev/null
fi

exec "$@"
