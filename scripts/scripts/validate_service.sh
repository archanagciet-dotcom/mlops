#!/bin/bash
set -Eeuo pipefail
URL="http://127.0.0.1/"
echo "Waiting for application health check"
for attempt in $(seq 1 30); do
  if curl --fail --silent --show-error "$URL" >/dev/null 2>&1; then
    echo "Application health check passed"
    exit 0
  fi
  echo "Attempt $attempt failed; retrying..."
  sleep 2
done
echo "Application health check failed"
docker logs archanagciet || true
exit 1
