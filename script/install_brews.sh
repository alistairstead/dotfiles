#!/usr/bin/env bash

# Run Homebrew through the Brewfile

set -e

cd "$(dirname "$0")"/../src/homebrew

brew bundle
