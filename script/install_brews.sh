#!/usr/bin/env bash

# Run Homebrew through the Brewfile

set -e

cd "$(dirname "$0")"/..

brew bundle
