#!/bin/bash

successfully() {
	$* || (echo "failed" 1>&2 && exit 1)
}

echo "Fixing permissions ..."
successfully sudo chown -R $(whoami) /usr/local
