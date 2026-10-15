#!/bin/bash
docker rm -f student-app 2>/dev/null || true
echo "Old student application container stopped."
