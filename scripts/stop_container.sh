#!/bin/bash
set -e
CONTAINER_NAME="archanagciet"
echo "Stopping existing application container"
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true
echo "Old container stopped"
