#!/bin/bash
set -e
cd /opt/student-app
MODEL_VERSION=$(tr -d '[:space:]' < VERSION)
if [ -z "$MODEL_VERSION" ]; then
    echo "ERROR: VERSION file is empty."
    exit 1
fi
echo "Deploying model version: $MODEL_VERSION"
docker build -t student-app:latest .
docker rm -f student-app 2>/dev/null || true
docker run -d \
    --name student-app \
    --restart unless-stopped \
    -p 80:5000 \
    -e MODEL_VERSION="$MODEL_VERSION" \
    student-app:latest
docker ps --filter "name=student-app"
echo "Deployment completed successfully."
