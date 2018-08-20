#!/usr/bin/env bash

source "./include.sh"

if [ "$1" = "" ]
then
    bold Enter namespace name:
    read NSNAME
else
    NSNAME=$1
fi

bold Creating global objects
helm upgrade globals packages/global-0.1.0.tgz
check_status

bold Deploying global prometheus server...
helm upgrade --namespace kube-system prometheus stable/prometheus


bold Creating namespace $NSNAME is created
helm upgrade --set namespace.name=$NSNAME $NSNAME packages/namespace-0.1.0.tgz
check_status


bold Deploying echo-server-$NSNAME
helm upgrade --namespace $NSNAME --set namespace.name=$NSNAME echo-server-$NSNAME packages/echo-server-0.1.0.tgz
check_status

bold Deploying echo-server-ingress-$NSNAME with ingress enabled
helm upgrade --namespace $NSNAME --set config.test=ingress.v1 --set ingress.enabled=true --set namespace.name=$NSNAME echo-server-ingress-$NSNAME packages/echo-server-0.1.0.tgz
check_status


bold Done!
