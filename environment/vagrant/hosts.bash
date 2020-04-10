#!/bin/bash

readonly DIR=$(dirname $(readlink -f "$0"))
cd ${DIR};
set -e
set -u
set -o pipefail
standardIFS="$IFS"
IFS=$'\n\t'

## You need to update these variables

# Setup information about the container and how ansible will use it
# This is the group that the container will be added to
ANSIBLE_GROUP_NAME="vagrant"
# This is the host name ansible will use for the container
ANSIBLE_HOST_NAME="vagrant-machine"

## You shouldn't need to change anything below this line

# Get information dynamically about the container
VAGRANT_SSH_CONFIG=$(sudo vagrant ssh-config)
# Pull out the relevant information
VAGRANT_IP_ADDRESS=$(echo "${VAGRANT_SSH_CONFIG}" | grep 'HostName ' | awk '{print $NF}')
VAGRANT_SSH_KEY=$(echo "${VAGRANT_SSH_CONFIG}" | grep 'IdentityFile ' | awk '{print $NF}')
VAGRANT_SSH_PORT=$(echo "${VAGRANT_SSH_CONFIG}" | grep 'Port ' | awk '{print $NF}')
VAGRANT_SSH_USER=$(echo "${VAGRANT_SSH_CONFIG}" | grep 'User ' | awk '{print $NF}')

# Make sure we can read the generated SSH key - only change permissions if we have to
CURRENT_USER=$(whoami)
if [[ ${CURRENT_USER} != $(stat -c '%U' ${VAGRANT_SSH_KEY}) ]]
then
    sudo chown ${CURRENT_USER}:${CURRENT_USER} ${VAGRANT_SSH_KEY}
fi

# Provide the dynamic inventory, only the list option seems to get used
if [[ "$1" == "--list" ]]; then
    cat << EOF
{
    "${ANSIBLE_GROUP_NAME}": {
        "hosts": [
            "${ANSIBLE_HOST_NAME}"
        ],
        "vars": {
            "ansible_port": "${VAGRANT_SSH_PORT}",
            "ansible_user": "${VAGRANT_SSH_USER}",
            "ansible_host": "${VAGRANT_IP_ADDRESS}",
            "ansible_ssh_common_args": "-o StrictHostKeyChecking=no",
            "ansible_ssh_private_key_file": "${VAGRANT_SSH_KEY}"
        }
    },
    "_meta": {
        "hostvars": {

        }
    }
}
EOF
elif [[ "$1" == "--host" ]]; then
    echo '{"_meta": {"hostvars": {}}}'
else
    echo "{ }"
fi
