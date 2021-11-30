
#!/bin/bash

source "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../../functions.sh"

MSG="Correct namespacing"

if grep -q "namespace Tests" "$1"; then
    success "$MSG"
elif grep -q "namespace App\\\Tests" "$1"; then
    success "$MSG"
else
    failure "$MSG"
    exit 1
fi

exit 0