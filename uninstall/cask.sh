#!/usr/bin/env bash


for app in $(exec brew cask list); do
    brew cask uninstall $app
done
