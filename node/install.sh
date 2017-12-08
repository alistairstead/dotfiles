#!/usr/bin/env bash

if test "$(which nvm)"; then
	nvm install stable
	nvm alias default stable
fi
