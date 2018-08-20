#!/usr/bin/env bash

NOCOL="\x1b[0m"
GREEN="\x1b[32;01m"
RED="\x1b[31;01m"
YELLOW="\x1b[33;01m"
BOLD="\x1b[1m"

success() {
    echo -e "-- $GREEN$@$NOCOL"
}

failure() {
    echo -e "-- $RED$@$NOCOL"
}

bold() {
    echo -e "-- $BOLD$@$NOCOL"
}

check_status() {
    if [ "$?" = "0" ]
    then
        success Success!
    else
        failure "[ERROR] Last command returned code $?. (see details above)"
    fi
}
