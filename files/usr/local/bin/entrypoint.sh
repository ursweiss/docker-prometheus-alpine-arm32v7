#!/bin/sh
set -ex

echo "*** Set volume permissions ***"
chown -R prometheus:prometheus /prometheus

exec su-exec prometheus prometheus "$@"
