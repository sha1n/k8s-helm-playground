#!/usr/bin/env bash

source "./include.sh"

./helm-package.sh 1.100.13

bold
bold Service charts from ./local_repo
bold

helm serve --repo-path ./local_repo
