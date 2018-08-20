[![Build Status](https://travis-ci.org/sha1n/k8s-helm-playground.svg?branch=master)](https://travis-ci.org/sha1n/k8s-helm-playground)

# k8s Helm Playground

This repo is a k8s helm playground for experimentation  

## Build Binaries 
```bash
docker login --username=$DOCKERHUB_USER
...

# Build and publish test server docker image
make release
```

## Helm Setup
```bash
minikube start

# Setup helm and tiller
./helm-setup.sh
```

## Deployment Demo
```bash
# Package helm charts (local) 
make package-charts

# Install global objects
./helm-install-globals.sh

# Install namespace objects
./helm-install-namespace.sh demo

# Upgrade all demo charts (doesn't really do anything) 
./helm-upgrade-all.sh demo

```
