#!/bin/bash

export UUID=$(id -u)
export GUID=$(id -g)

# Build and start the container in the foreground.
# The container exits when Maya closes.
docker compose up --build -d
