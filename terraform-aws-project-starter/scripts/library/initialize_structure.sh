#!/bin/bash

# Source the set_environments.sh script to ensure ENVIRONMENTS_DIR and PROJECT_DIR are set
source "$PROJECT_DIR/scripts/library/set_environments.sh"

# Create the base directories for modules and global configurations
mkdir -p "$PROJECT_DIR/modules/vpc" \
         "$PROJECT_DIR/modules/ec2" \
         "$PROJECT_DIR/modules/rds" \
         "$PROJECT_DIR/modules/elb" \
         "$PROJECT_DIR/global/iam" \
         "$PROJECT_DIR/global/s3"

# Function to create and test an environment
create_and_test_environment() {
    local env_name=$1
    "$PROJECT_DIR/scripts/library/create_environments.sh" "$env_name"
    if [ "$("$PROJECT_DIR/scripts/library/test_create_environments.sh" "$env_name")" = "true" ]; then
        echo "Environment '$env_name' created and verified successfully."
    else
        echo "Failed to verify environment: $env_name"
        exit 1
    fi
}

# Create and test 'dev' and 'prod' environments
create_and_test_environment "dev"
create_and_test_environment "prod"

echo "Project structure initialized successfully."