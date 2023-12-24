# Getting Started 

## Step 1 - Edit Environment Configuration

1. Rename example config: 

        $ mv example_env_config.json env_config.json

2. Adjust configurations, replacing the `/path/to/` for the actualy path to your project

        {
            "PROJECT_DIR": "/path/to/terraform-deployment",
            "ENVIRONMENTS_DIR": "/path/to/terraform-deployment/environments",
            "ENVIRONMENTS": ["dev", "staging", "prod"]
        }

## Step 2 - Usage

1. Load commands for the terrastarter program
        ```bash
        source .bashrc
        ```

2. Initialize your terraform project; this will create the folder structure for the project so that you can begin work
        ```bash
        terrastarter.init
        ```

## Terraform Project Structure 

    terraform-deployment/
    │
    ├── modules/                    # Reusable Terraform modules
    │   ├── vpc/                    # VPC module
    │   ├── ec2/                    # EC2 module for instances
    │   ├── rds/                    # RDS module for database
    │   └── elb/                    # ELB (Elastic Load Balancer) module
    │
    ├── environments/               # Specific environment configurations
    │   ├── dev/                    # Development environment
    │   │   ├── main.tf             # Main Terraform file for dev
    │   │   ├── variables.tf        # Variables for dev
    │   │   ├── outputs.tf          # Outputs for dev
    │   │   └── terraform.tfvars    # Terraform variables values for dev
    │   │
    │   └── prod/                   # Production environment
    │
    ├── global/                     # Global configurations
    │   ├── iam/                    # IAM configurations
    │   ├── s3/                     # S3 configurations
    │   └── ...
    │
    ├── scripts/                    # Scripts for environment setup and utilities
    │   ├── library/                # Contains various setup and utility scripts
    │   └── utilities/              # Utility scripts for JSON parsing and other tasks
    │
    ├── docs/                       # Further documents automation and structure
    │
    ├── env_config.json             # JSON configuration file for environment variables
    └── README.md                   # Project documentation
