#!/usr/bin/env bash

kubectl create -f k8s-predef/tiller-rbac-model.yaml

helm init --wait --history-max 5 --replicas 2 --service-account tiller
