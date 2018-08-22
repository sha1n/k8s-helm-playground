[![Build Status](https://travis-ci.org/sha1n/k8s-helm-playground.svg?branch=master)](https://travis-ci.org/sha1n/k8s-helm-playground)

# k8s Helm Playground
This repo is a k8s helm playground for experimentation  

Tested with: 
* MacOS 10.13.6
* Docker client version 18.06.0-ce
* Kubernetes version 1.10.0 (minikube)
* Helm version 2.9.1
* Go version 1.10.3

## Prerequisites
```bash
brew cask install virtualbox
brew cask install minikube
brew install kubernetes-helm
```

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
./helm-package.sh

# Install global objects
./helm-install-globals.sh

# Install namespace objects
./helm-install-namespace.sh demo

# Upgrade all demo charts (doesn't really do anything) 
./helm-upgrade-all.sh demo
```

## Nested Charts Example
```bash
# Package helm charts (local) 
./helm-package.sh

helm upgrade --install --set global.namespace.name=nesting-demo nesting-demo packages/nesting-example-0.1.0.tgz
```
