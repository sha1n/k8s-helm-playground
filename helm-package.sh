#!/usr/bin/env bash

PKG_DIR=packages

mkdir $PKG_DIR
helm package charts/global -d $PKG_DIR
helm package charts/namespace -d $PKG_DIR
helm package charts/echo-server -d $PKG_DIR
helm package charts/nesting-example -d $PKG_DIR
