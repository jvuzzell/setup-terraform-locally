#!/bin/bash

# Define AWS Region and Bucket Name
AWS_REGION="us-east-1" # Change this to your preferred region
BUCKET_NAME="my-terraform-test-bucket-$(date +%s)" # Unique bucket name with timestamp
PROFILE="terra_test"

# Check if a cached SSO file exists
if [ -d "$HOME/.aws/sso/cache" ] && [ -n "$(ls -A $HOME/.aws/sso/cache)" ]; then
    echo "SSO cache found. Checking for valid credentials..."

    # Replace 'aws s3 ls' with a lightweight command that suits your use case
    if aws s3 ls --profile "$PROFILE" &> /dev/null; then
        echo "You are logged in with AWS SSO."
    else
        echo "Your session has expired or credentials are invalid."
        aws sso login --profile "${PROFILE}"
    fi
else
    echo "No AWS SSO cache found. You are not logged in."
    aws sso login --profile "${PROFILE}"
fi

# Create Terraform configuration
mkdir terraform-test
cd terraform-test

cat <<EOF >main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "${AWS_REGION}"
  profile = "${PROFILE}"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "${BUCKET_NAME}"
}
EOF

# Initialize and apply Terraform
terraform init
terraform apply -auto-approve

# Check if the bucket was created
aws s3 ls "s3://${BUCKET_NAME}" --profile "${PROFILE}" &> /dev/null

if [ $? -eq 0 ]; then
    echo "S3 bucket created successfully."
else
    echo "Failed to create S3 bucket."
fi

# Clean up resources
echo "Destroying created resources..."
terraform destroy -auto-approve
cd ..
rm -rf terraform-test

# qqM48(]' 
# -fTliB5KRFB-r0YOdD17_oFN@Hz8Q
