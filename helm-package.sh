#!/usr/bin/env bash

source "./include.sh"

if [ "$1" = "" ]
then
    bold "Enter an appVersion: (we will use one app ver for all releases just for the demo)"
    read APPVER
else
    APPVER=$1
fi


PKG_DIR=local_repo

mkdir $PKG_DIR

bold Packaging charts...

helm package charts/global --app-version $APPVER -d $PKG_DIR
helm package charts/namespace --app-version $APPVER -d $PKG_DIR
helm package charts/echo-server --app-version $APPVER -d $PKG_DIR
helm package charts/nesting-example --app-version $APPVER -d $PKG_DIR
check_status