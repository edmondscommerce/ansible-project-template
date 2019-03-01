#!/usr/bin/env bash
readonly DIR=$(dirname $(readlink -f "$0"))
cd $DIR;
set -e
set -u
set -o pipefail
standardIFS="$IFS"
IFS=$'\n\t'

printf "\n\n"

readonly varname=${1:-'variable_name'}

readonly password=${2:-'=+'"$(openssl rand -base64 32)"}

readonly passFilePath=./../vault-pass.secret

if [[ ! -f $passFilePath ]]
then
    echo "Vault Pass File not found at $passFilePath, you need to create this first"
    exit 1
fi

echo "

Password is $password

Vaulted variable is:

"

echo -n "$password" | ansible-vault encrypt_string --vault-password-file="$passFilePath" --stdin-name "$varname" | grep -v "Encryption successful"

printf "\n\n"