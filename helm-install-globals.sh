#!/usr/bin/env bash

source "./include.sh"

bold Creating global objects...
helm install --name globals local/global-0.1.0.tgz
check_status

bold Deploying global prometheus...
helm install --namespace kube-system --name prometheus stable/prometheus


bold Done!
