
#!/bin/bash

source "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../../functions.sh"

MSG="Functions should have typing"
RESULT=$(grep -P "function ([a-zA-z]+)\(.*\)\s*$"  "$1" | grep -v "__construct")

if [ -z "$RESULT" ] ; then
    success "$MSG"
    exit 0
else
    failure "$MSG: \`$RESULT\`"
    exit 1
fi