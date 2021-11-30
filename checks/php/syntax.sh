
#!/bin/bash

source "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../../functions.sh"

MSG="Syntax"

php_lint_output=`php -l -d display_errors=On $1 2>&1 | grep 'Parse error:'`

if [ -n "$php_lint_output" ]; then
    failure "$MSG"
    exit 1
else
    success "$MSG"
    exit 0
fi