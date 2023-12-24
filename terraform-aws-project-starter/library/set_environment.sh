#!/bin/bash

source "$LIBRARY_DIR/utilities/extract_json_value.sh"
source "$LIBRARY_DIR/utilities/extract_json_array.sh"

# Use the path from the environment variable, or default to a known location
CONFIG_FILE="${ENV_CONFIG_PATH:-/default/path/to/env_config.json}"

# Check if the JSON configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found: $CONFIG_FILE"
    exit 1
fi

# Load and export the environment variables from the JSON file
export PROJECT_DIR=$(extract_json_value "PROJECT_DIR" "$CONFIG_FILE")
export ENVIRONMENTS_DIR=$(extract_json_value "ENVIRONMENTS_DIR" "$CONFIG_FILE")
ENVIRONMENTS=$(extract_json_array "ENVIRONMENTS" "$CONFIG_FILE")

# Convert space-separated values to bash array
IFS=' ' read -r -a TF_ENVIRONMENTS <<< "$ENVIRONMENTS"

# Export the array
export TF_ENVIRONMENTS
