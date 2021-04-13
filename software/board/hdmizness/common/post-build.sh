#!/bin/bash

# Generate server ssh keys
mkdir -p "${TARGET_DIR}/etc/ssh"
for kind in dsa rsa ecdsa ed25519; do
    key="${TARGET_DIR}/etc/ssh/ssh_host_${kind}_key"
    if [ ! -f "$key" ]; then
        ssh-keygen -q -N "" -t $kind -f "$key"
    fi
done
