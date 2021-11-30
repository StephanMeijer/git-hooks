
#!/bin/bash

source "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../../functions.sh"

MSG="Validate & Format JSON"

OUT="$(cat $1 | jq empty 2>&1)"
CODE="$?"

if [ "$CODE" != "0" ]; then
    failure "$MSG: $OUT"
    exit 1
fi

SUM_BEFORE="$(sha1sum "$1" | awk '{print $1}')"

OUT="$(jq . $1 --indent 4)"

echo "$OUT" > "$1"

SUM_AFTER="$(sha1sum "$1" | awk '{print $1}')"

if [ "$SUM_BEFORE" = "$SUM_AFTER" ]; then
    success "$MSG"
    exit 0
else
    failure "$MSG: Formatting"
    fixed
    exit 1
fi