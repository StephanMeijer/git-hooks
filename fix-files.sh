#!/bin/bash

BASE="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source "$BASE/functions.sh"

find_cmd jq grep sed xargs echo find perl sha1sum xmllint

EXIT_CODE=0
SECTION_RENDERED=0
FILENAME_RENDERED=0
SECTION="REPLACE ME"

function handle_cmd() {
    OUT="$(bash $1 $2)"
    CODE="$?"

    [ "$CODE" = "1" ] || [ "$EXIT_CODE" = "1" ] && EXIT_CODE=1

    [ "$CODE" = "1" ] && [ "$FILENAME_RENDERED" != "1" ] && [ "$SECTION_RENDERED" != "1" ] && echo -e "\n\033[0mChecks on \033[1m$f"
    [ "$CODE" = "1" ] && [ "$SECTION_RENDERED" != "1" ] && section "$SECTION" && SECTION_RENDERED=1

    [ "$CODE" = "1" ] && echo -e $OUT
}

if [ -d "$PWD/.git" ] && [ "$1" = "git" ]; then
    find_cmd git

    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    MERGE_BASE=$(git merge-base $CURRENT_BRANCH develop 2> /dev/null || git merge-base $CURRENT_BRANCH master 2> /dev/null || git merge-base $CURRENT_BRANCH main 2> /dev/null || >&2 echo "No branch develop, master or main" )
    echo -e "\033[97mCOMPARING $CURRENT_BRANCH TO commit $MERGE_BASE...\n"
    FILES=$(git fetch && git diff --name-only $MERGE_BASE HEAD | grep ".php$" | perl -ne 'chomp(); if (-e $_) {print "$_\n"}')
elif [ "$1" != "" ] && [ "$1" != "git" ]; then
    FILES="$@"
else
    echo -e "\033[97mANALYZING FOLDS src/ AND test/...\n"
    FILES=$(find src tests -name "*.php")
fi

GENERIC_CHECKS_EXT=(php js py yml yaml xml json dist .gitignore ts html css html xhtml rb rss svg atom c cpp go sh)

FILES=$(echo $FILES | xargs find | xargs -I{} find {} -type f ! -name 'Kernel.php' ! -name 'bootstrap.php' | grep -vE '.git' | awk '!a[$0]++' )

for f in $FILES
do
    FILENAME_RENDERED=0
    filename=$(basename "$f")
    ext="${f##*.}"

    if [[ $f == ./config/* ]]; then
        continue;
    fi

    if [[ $f == ./public/* ]]; then
        continue;
    fi

    if [[ $f == ./vendor/* ]]; then
        continue;
    fi

    if [[ $f == ./node_modules/* ]]; then
        continue;
    fi

    if [[ $f == ./var/* ]]; then
        continue;
    fi

    if [[ $f == *.json ]]; then
        SECTION="JSON Checks"
        SECTION_RENDERED=0

        handle_cmd "$BASE/checks/json/format.sh" $f
    fi

    if [[ $f == *.php ]]; then
        SECTION="PHP Checks"
        SECTION_RENDERED=0

        handle_cmd "$BASE/checks/php/syntax.sh" $f
        handle_cmd "$BASE/checks/php/switch.sh" $f
        handle_cmd "$BASE/checks/php/strict_types.sh" $f
        handle_cmd "$BASE/checks/php/typing.sh" $f
        handle_cmd "$BASE/checks/php/mock_builder.sh" $f
        handle_cmd "$BASE/checks/php/whitespace_properties.sh" $f

        if [[ $f == tests/* ]]; then
            SECTION="PHP Test Checks"
            SECTION_RENDERED=0
            handle_cmd "$BASE/checks/php/namespacing.sh" $f
        fi
    fi

    case "${GENERIC_CHECKS_EXT[@]}" in  *"$ext"*)
        SECTION="Generic Checks"
        SECTION_RENDERED=0

        handle_cmd "$BASE/checks/generic/trailing.sh" $f
        handle_cmd "$BASE/checks/generic/empty_lines.sh" $f
    ;; esac;
done

echo -e "\n"

echo -e "\033[97mRESULTS"

if [[ "$EXIT_CODE" = 0 ]]; then
    success "All checks passed" 1
else
    failure "Some checks failed. Please fix them and run again." 1
fi

echo -e "\033[0m"

exit $EXIT_CODE
