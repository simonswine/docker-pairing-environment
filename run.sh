#!/usr/bin/env bash

set -euo pipefail

set -x

# reinstall openssh if no config provided
test -e /etc/ssh/sshd_config || { dpkg --purge openssh-server; apt-get install -y openssh-server; }

# home directory won't exsist on first boot since the user was created during docker file build
# before the volume is mounted
if [[ ! -e /home/pair ]]; then
    mkdir -p /home/pair
    chown -R pair:pair /home/pair
fi

exec /lib/systemd/systemd
