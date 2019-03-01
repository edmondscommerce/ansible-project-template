#!/usr/bin/env bash
readonly DIR=$(dirname $(readlink -f "$0"))
cd $DIR;
set -e
set -u
set -o pipefail
standardIFS="$IFS"
IFS=$'\n\t'

if (( $# < 1 ))
then
    echo "

    Usage ./$(basename $0) [path to file] (variable_name, defaults to variable_name)

    "
    exit 1
fi

printf "\n\n"

readonly path="$1"

readonly varname=${2:-'variable_name'}

readonly passFilePath=./../vault-pass.secret

if [[ ! -f $passFilePath ]]
then
    echo "Vault Pass File not found at $passFilePath, you need to create this first"
    exit 1
fi

cat $path | ansible-vault encrypt_string --vault-password-file="$passFilePath" --stdin-name "$varname" | grep -v "Encryption successful"

printf "\n\n"