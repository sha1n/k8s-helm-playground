#!/usr/bin/env bash

source "./include.sh"

if [ "$1" = "" ]
then
    bold Enter namespace name:
    read NSNAME
else
    NSNAME=$1
fi

bold Creating namespace $NSNAME is created
helm install --name $NSNAME --set namespace.name=$NSNAME packages/namespace-0.1.0.tgz
check_status


bold Deploying echo-server-$NSNAME
helm install --name echo-server-$NSNAME --namespace $NSNAME --set namespace.name=$NSNAME packages/echo-server-0.1.0.tgz
check_status
bold "Running tests for echo-server-$NSNAME..."
helm test --cleanup echo-server-$NSNAME

bold Deploying echo-server-ingress-$NSNAME with ingress enabled
helm install --name echo-server-ingress-$NSNAME --namespace $NSNAME --set config.test=ingress.v1 --set ingress.enabled=true --set namespace.name=$NSNAME packages/echo-server-0.1.0.tgz
check_status


bold Done!
