#!/bin/bash
set -e
if ! command -v docker >/dev/null 2>&1; then
    dnf install -y docker
fi
systemctl enable --now docker
mkdir -p /opt/student-app
echo "Docker installation and startup completed."
