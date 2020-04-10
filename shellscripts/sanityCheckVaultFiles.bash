#!/usr/bin/env bash

readonly DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${DIR}/../;
set -e
set -u
set -o pipefail
standardIFS="$IFS"
IFS=$'\n\t'

# Redirect output to stderr.
exec 1>&2
EXIT_STATUS=0

# Check that all changed *.vault files are encrypted
# read: -r do not allow backslashes to escape characters; -d delimiter
for file in $(find ./ \( -name "vault.yml" -o -name "vault.yaml" \) -type f );
do
	head -1 "$file" | grep --quiet '^\$ANSIBLE_VAULT;' || {
		echo "ERROR: non-encrypted *.vault file: $file"
		EXIT_STATUS=1
	}
done

exit ${EXIT_STATUS}

echo "
----------------
$(hostname) $0 completed
----------------
"
