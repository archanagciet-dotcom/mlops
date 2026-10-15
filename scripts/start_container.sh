#!/bin/bash
set -Eeuo pipefail
AWS_REGION="ap-south-1"
ECR_REPOSITORY_URI="ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com/archanagciet"
CONTAINER_NAME="archanagciet"
IMAGE_TAG="${IMAGE_TAG:-latest}"
APP_PORT="${APP_PORT:-5000}"
echo "Logging in to Amazon ECR"
aws ecr get-login-password --region "$AWS_REGION" \
  | docker login --username AWS --password-stdin "$ECR_REPOSITORY_URI"
echo "Pulling application image"
docker pull "${ECR_REPOSITORY_URI}:${IMAGE_TAG}"
echo "Replacing old container"
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true
echo "Starting application container"
docker run -d \
  --name "$CONTAINER_NAME" \
  --restart unless-stopped \
  -p "80:${APP_PORT}" \
  "${ECR_REPOSITORY_URI}:${IMAGE_TAG}"
echo "Container started"
