
#!/bin/bash

source "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../../functions.sh"

MSG="Present in file: declare(strict_types=1);"

if grep "declare(strict_types=1);" "$1"; then
    success "$MSG"
    exit 0
else
    failure "$MSG"
    fixed
    sed -E -i 's/<\?php/<\?php\n\ndeclare(strict_types=1);/g' $1
    exit 1
fi