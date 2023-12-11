#!/bin/bash

# Function to check if a file exists
file_exists() {
    local filename=$1
    [[ -f "$filename" ]]
}

# Check if the environment name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <environment-name>"
    exit 1
fi

# Assuming ENVIRONMENTS_DIR is set in set_environments.sh and it is sourced
# Check if ENVIRONMENTS_DIR is set
if [ -z "$ENVIRONMENTS_DIR" ]; then
    echo "ENVIRONMENTS_DIR is not set. Please set it in set_environments.sh and source it."
    exit 1
fi

# Set environment directory path
ENV_DIR="$ENVIRONMENTS_DIR/$1"

# Check for the existence of each file
if file_exists "$ENV_DIR/main.tf" && \
   file_exists "$ENV_DIR/variables.tf" && \
   file_exists "$ENV_DIR/outputs.tf" && \
   file_exists "$ENV_DIR/terraform.tfvars"; then
    echo "true"
else
    echo "false"
fi
