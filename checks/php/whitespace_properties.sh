#!/bin/bash

source "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../../functions.sh"

MSG="File should not contain empty line between properties"

#if pcregrep -q -M $'.*(private|protected|public).*\$\w+.*;\s*\n\s*\n\s*(private|protected|public).*\$\w+.*;' "$1"; then
#    failure "$MSG"
#    exit 1
#else
#    success "$MSG"
#    exit 0
#fi