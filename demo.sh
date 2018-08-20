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

bold Enter namespace name:

read NSNAME

bold Going to create namespace $NSNAME
sleep 1
helm install --name $NSNAME --set namespace.name=$NSNAME charts/namespace/namespace-0.1.0.tgz
check_status


bold Creating deployment for echo-server
sleep 1
helm upgrade --install --set namespace.name=$NSNAME echo-server-$NSNAME charts/echo-server/echo-server-0.1.8.tgz
check_status
