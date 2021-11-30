#!/bin/bash

function success() {
    [[ "$2" -ne "1" ]]  && tab="\t"
    echo -e "$tab\033[92m\u2714 \033[1m$1";
}

function failure() {
    [[ "$2" -ne "1" ]]  && tab="\t"
    echo -e "$tab\033[91m\u274c \033[1m$1";
}

function fixed() {
    echo -e "\t\t\u270e \033[0mFix applied";
}

function section() {
    echo -e "\n\033[0m\033[1m$1";
}

function find_cmd() {
    for cmd in "$@"; do
        if ! command -v $cmd &> /dev/null
        then
            failure "Command \`$cmd\` could not be found" 1
            exit 1
        fi
    done
}