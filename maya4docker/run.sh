#!/usr/bin/env bash
set -euo pipefail

export UUID=$(id -u)
export GUID=$(id -g)

# Detect NVIDIA GPU
if command -v nvidia-smi > /dev/null 2>&1 && nvidia-smi > /dev/null 2>&1; then
    COMPOSE_FILE="docker-compose-gpu.yml"
else
    COMPOSE_FILE="docker-compose-cpu.yml"
fi

echo "Using compose file: ${COMPOSE_FILE}"

# Build and start the container in the foreground.
# The container exits when Maya closes.
docker compose -f "${COMPOSE_FILE}" up --build -d
