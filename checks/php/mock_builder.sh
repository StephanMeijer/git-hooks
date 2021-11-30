
#!/bin/bash

source "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../../functions.sh"

MSG="Use createMock(...) instead of getMockBuilder(...)->disableOriginalConstructor()->getMock()"

if grep  -q -P '\$this->getMockBuilder\(([a-zA-z]+)::class\)->disableOriginalConstructor\(\)->getMock\(\)' "$1"; then
    failure "$MSG"
    fixed
    sed -E -i 's/\$this->getMockBuilder\(([A-Za-z]+)::class\)->disableOriginalConstructor\(\)->getMock\(\)/\$this->createMock\(\1::class\)/g' $1
    exit 1
else
    success "$MSG"
    exit 0
fi