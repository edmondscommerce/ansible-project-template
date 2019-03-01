#!/usr/bin/env bash
readonly DIR=$(dirname $(readlink -f "$0"))
cd $DIR;
set -e
set -u
set -o pipefail
standardIFS="$IFS"
IFS=$'\n\t'
echo "
===========================================
$(hostname) $0 $@
===========================================
"

if (( $# < 1 ))
then
    echo "

    Usage ./$(basename $0) ssh_key_prefix

    "
    exit 1
fi

sshKeyPrefix=$1

sshPrivateKeyPath=~/.ssh/${sshKeyPrefix}_rsa
sshPublicKeyPath=~/.ssh/${sshKeyPrefix}_rsa.pub

if [[ -f $sshPrivateKeyPath ]]
then
    echo "
    ERROR - found exiting key at $sshPrivateKeyPath
    "
    exit 1
fi
if [[ -f $sshPublicKeyPath ]]
then
    echo "
    ERROR - found exiting key at $sshPublicKeyPath
    "
    exit 1
fi

usersPassword="$(cd $DIR/../ && ansible joseph -i environment/prod -m debug -a 'var=users_password' | grep 'users_password' | cut -d ':' -f 2 | sed -e 's/^ "//' -e 's/"$//')"

ssh-keygen -t rsa -b 4096 -o -a 100 -f ${sshPrivateKeyPath} -q -N "$usersPassword" -C "info@edmondscommerce.co.uk"

./createVaultedDataFromFile.bash $sshPrivateKeyPath ${sshKeyPrefix}_private_key

./createVaultedDataFromFile.bash $sshPublicKeyPath ${sshKeyPrefix}_public_key
