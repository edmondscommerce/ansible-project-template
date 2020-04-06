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

    Usage ./$(basename $0)ssh_key_prefix (email, defaults to info@edmondscommerce.co.uk)

    "
    exit 1
fi

readonly sshKeyPrefix=$1
if [[ "$sshKeyPrefix" == "" ]]
then
    echo "We need a prefix for this key";
    exit 1;
fi

printf "Enter desired SSH key pass phrase:\n";
read -rs sshKeyPass;
if [[ "$sshKeyPass" == "" ]]
then
    echo "We need a password to generate the SSH keys";
    exit 1;
fi

printf "Confirm passphrase:\n"
read -rs sshKeyPassConfirm;
if [[ "$sshKeyPass" != "$sshKeyPassConfirm" ]]
then
    echo "Passwords do not match, please re run the script";
    exit 1;
fi

readonly sshKeyEmail=${2:-"info@edmondscommerce.co.uk"}
readonly sshPrivateKeyPath=~/.ssh/${sshKeyPrefix}_rsa
readonly sshPublicKeyPath=~/.ssh/${sshKeyPrefix}_rsa.pub

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

ssh-keygen -t rsa -b 4096 -o -a 100 -f ${sshPrivateKeyPath} -q -N "$sshKeyPass" -C "$sshKeyEmail"

./createVaultedDataFromFile.bash $sshPrivateKeyPath ${sshKeyPrefix}_private_key

./createVaultedDataFromFile.bash $sshPublicKeyPath ${sshKeyPrefix}_public_key
