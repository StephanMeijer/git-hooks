#!/bin/bash

source "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../functions.sh"

MSG="File should not containt two empty lines in sequence"

if pcregrep -q -l -M $'\s*\n\s*\n\s*\n' "$1"; then
    failure "$MSG"

    sed -z -E -i 's/\n\n\n+/\n\n/g' "$1"
    fixed

    exit 1
else
    success "$MSG"
    exit 0
fi