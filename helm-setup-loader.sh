#!/usr/bin/env bash

source "./include.sh"

if [ "$1" = "" ]
then
    bold Enter namespace name:
    read NSNAME
else
    NSNAME=$1
fi

# create loader namespace
bold Installing namespace
helm install --name=$NSNAME --set namespace.name=$NSNAME local/namespace-0.1.0.tgz
check_status

bold Installing metrics server
# install metrics server public chart
helm upgrade --install --namespace=$NSNAME metrics-server stable/metrics-server
check_status

# install the loader chart in the loader namespace
bold Installing load server
helm upgrade --install --namespace=$NSNAME dummy-loader local_repo/dummy-loader-0.1.0.tgz
check_status

echo
bold "Forward you load-server port to your local machine by running the following command:"
echo "      kubectl --namespace=hpa port-forward svc/dummy-loader 8080:8080"
bold "Then you can generate CPU load by running:"
echo "      curl -v http://localhost:8080/cpu-load?time-sec=120"
