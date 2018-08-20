[![Build Status](https://travis-ci.org/sha1n/k8s-helm-playground.svg?branch=master)](https://travis-ci.org/sha1n/k8s-helm-playground)

# k8s Helm Playground

This repo is a k8s helm playground for experimentation  


## Build 
```
docker login --username=XXX
...

# Build go server, docker image and publish
make release

# Package helm chart
helm package charts/echo-server
```

## Install 
```
NSNAME=helm-nsx

# Create kube namespace
helm install --set namespace.name=$NSNAME charts/namespace/namespace-0.1.0.tgz

# upgrade/install chart
helm upgrade --install --set config.test=v1 --set namespace.name=$NSNAME echo-server-$NSNAME charts/echo-server/echo-server-0.1.8.tgz
```
