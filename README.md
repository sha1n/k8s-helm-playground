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

## Demo Scripts
```bash
# Package and serve helm charts 
./helm-serve.sh

# Install global objects
./helm-install-globals.sh

#
# Install/upgrade charts bound to the same namespace.
# These scripts demonstrate helm install/upgrade commands with values overriding and basic usage of the helm test functionality.
#
./helm-install-namespace.sh demo
./helm-upgrade-all.sh demo
```

## Nested Charts Example
```bash
# Package and serve helm charts
./helm-serve.sh

helm upgrade --install --set global.namespace.name=nesting-demo nesting-demo local/nesting-example-0.1.0.tgz
```

## Pod AutoScaling Example
```bash
# If you're running on minikube, I would recommend to enable the heapster addon
minikube addons enable heapster
minikube addons open heapster


./helm-serve.sh

./helm-setup-loader.sh hpa
``` 
