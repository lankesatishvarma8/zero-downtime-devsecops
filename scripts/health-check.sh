#!/bin/bash
set -e

URL=$1
if [ -z "$URL" ]; then
  echo "Error: URL not provided."
  exit 1
fi

echo "Running health check on $URL..."

for i in {1..10}; do
  STATUS=$(curl -s -o /dev/null -w '%{http_code}' $URL || true)
  if [ "$STATUS" -eq 200 ]; then
    echo "Health check passed!"
    exit 0
  fi
  echo "Waiting for service to be healthy... ($i/10)"
  sleep 5
done

echo "Health check failed."
exit 1
