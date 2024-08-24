#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Change to the script's directory
cd "$SCRIPT_DIR" || { echo "Failed to change directory to $SCRIPT_DIR"; exit 1; }

DOCKER_CONTAINER="enshrouded-server"
FILE_PATH="/home/steam/enshrouded/savegame/."

# Get current timestamp
CURRENT_TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Create a folder with current timestamp
DEST_FOLDER="./backups/$CURRENT_TIMESTAMP"
mkdir -p "$DEST_FOLDER"

# Copy the save folder from the docker container to the backups directory
docker cp "$DOCKER_CONTAINER:$FILE_PATH" "$DEST_FOLDER" || { echo "Error: Failed to backup save files"; rmdir $DEST_FOLDER; exit 1; }

echo "Enshrouded save files have been successfully backed up to $DEST_FOLDER"
