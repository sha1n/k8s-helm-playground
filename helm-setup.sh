#!/usr/bin/env bash

kubectl create -f k8s-predef/tiller-rbac-model.yaml

helm init --wait --service-account tiller
