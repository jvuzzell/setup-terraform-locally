#!/bin/bash

# Function to create a basic Terraform file
create_file() {
    local filename=$1
    local content=$2
    echo "$content" > "$filename"
}

# Check if ENVIRONMENTS_DIR is set
if [ -z "$ENVIRONMENTS_DIR" ]; then
    echo "ENVIRONMENTS_DIR is not set. Please set it in set_environments.sh and source it."
    exit 1
fi

# Check if the directory name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <environment-name>"
    exit 1
fi

# Create environment directory
ENV_DIR="$ENVIRONMENTS_DIR/$1"
mkdir -p "$ENV_DIR"

# Create basic Terraform files
create_file "$ENV_DIR/main.tf" '# Provider "aws" {} # Specify your provider configuration here'
create_file "$ENV_DIR/variables.tf" '# Declare your variables here'
create_file "$ENV_DIR/outputs.tf" '# Define your outputs here'
create_file "$ENV_DIR/terraform.tfvars" '# Define default values for your variables here'

echo "Environment '$1' created successfully."
