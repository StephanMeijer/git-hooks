#!/bin/bash

source "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../../functions.sh"

MSG="No Trailing Whitespace"

if grep -q '[[:blank:]]$' "$1"; then
    failure "$MSG"
    sed -i 's/[ \t]*$//' "$1"
    fixed
    exit 1
else
    success "$MSG"
    exit 0
fi