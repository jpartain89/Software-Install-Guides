#!/bin/bash

# Deploy Script

## All Variables ##
RSYNC="$(command -v rsync)"
R_OPTS="-r -e 'ssh -p $SSH_PORT' --delete-after --quiet"
R_SOURCE="${TRAVIS_BUILD_DIR}/_build/html/"
R_USERNAME="$SSH_USER"
R_ADDR="$HOST_NAME"
R_DIR="/var/www/html/docs/"
R_DEST="${R_USERNAME}@${R_ADDR}:${R_DIR}"

trap 'echo "The SSH Build seems to have failed, sorry."' SIGUSR1
trap 'echo "The RSYNC part seems to have failed, sorry."' SIGUSR2

function ssh_stuff {
cat << EOF > ~/.ssh/config
Host rpi3
    StrictHostKeyChecking no
    HostName $HOST_NAME
    User $SSH_USER
    Port $SSH_PORT
EOF
  chmod 0600 ~/.ssh/config
  eval "$(ssh-agent -s)"
  mv /tmp/deploy_rsa ~/.ssh/id_rsa
  chmod 600 ~/.ssh/id_rsa
  ssh-add ~/.ssh/id_rsa
}

function r_syncing {
  "$RSYNC" "$R_OPTS" "$R_SOURCE" "$R_DEST"
}

ssh_stuff || exit 30;
r_syncing || exit 31
