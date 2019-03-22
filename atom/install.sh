#!/usr/bin/env bash

if which apm >/dev/null 2>&1; then
  apm install --packages-file ~/.atom/package.list
fi
