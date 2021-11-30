
#!/bin/bash

source "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../../functions.sh"

MSG="Use match instead of switch"

if grep  -q -P 'switch' "$1"; then
    failure "$MSG"
    exit 1
else
    success "$MSG"
    exit 0
fi