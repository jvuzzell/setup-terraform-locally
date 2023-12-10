#!/bin/bash

# Script to configure AWS CLI with AWS SSO

echo "Starting AWS CLI SSO configuration..."

# Check if AWS CLI v2 is installed
if ! aws --version | grep "aws-cli/2" &> /dev/null; then
    echo "AWS CLI version 2 is required for SSO. Please install it first."
    exit 1
fi

# Prompt for SSO details
read -p "Enter your AWS SSO URL (e.g., https://my-sso-portal.awsapps.com/start): " sso_url
read -p "Enter your AWS SSO Region (e.g., us-west-2): " sso_region
read -p "Enter your AWS SSO Account ID (e.g., 123456789012): " sso_account_id
read -p "Enter your AWS SSO Role Name (e.g., MySSORole): " sso_role_name

# Start AWS CLI SSO configuration
aws configure sso --sso-start-url $sso_url --sso-region $sso_region

echo "Follow the instructions in the browser to log in to your AWS SSO account."

# Prompt for profile name
read -p "Enter a name for this AWS CLI SSO profile: " profile_name

# Set the profile name
aws configure set profile.$profile_name.sso_start_url $sso_url
aws configure set profile.$profile_name.sso_region $sso_region
aws configure set profile.$profile_name.sso_account_id $sso_account_id
aws configure set profile.$profile_name.sso_role_name $sso_role_name

echo "AWS CLI is configured with SSO. Use the profile by specifying --profile $profile_name in your AWS CLI commands."

# Test the configuration
echo "Testing the configuration by listing available AWS regions..."
if aws ec2 describe-regions --profile $profile_name --output text; then
    echo "Configuration test successful."
else
    echo "Configuration test failed. Please check your setup."
fi
