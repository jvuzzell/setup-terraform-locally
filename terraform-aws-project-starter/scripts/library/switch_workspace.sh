#!/bin/bash

# Function to check if a workspace exists and create it if not
create_and_switch_workspace() {
    if terraform workspace list | grep -qw "$1"; then
        echo "Switching to workspace: $1"
    else
        echo "Creating and switching to workspace: $1"
        terraform workspace new "$1"
    fi
    terraform workspace select "$1"
}

switch_workspace() {
# Ensure Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "Terraform is not installed. Please install Terraform to use this script."
    exit 1
fi

# Initialize Terraform (safe to run multiple times)
echo "Initializing Terraform..."
terraform init -reconfigure

# Load the environments from the environment variable
if [ -z "${TF_ENVIRONMENTS+set}" ]; then
    echo "No environments found in TF_ENVIRONMENTS. Please set environments using set_environments.sh."
    exit 1
fi

# Convert the environment variable to an array
IFS=' ' read -r -a environments <<< "${TF_ENVIRONMENTS[@]}"

# Append 'Quit' option to the array
environments+=("Quit")

# Prompt user for environment selection
echo "Select an environment:"
select opt in "${environments[@]}"; do
    case $opt in
        "Quit")
            exit 0
            ;;
        *)
            if [[ " ${environments[*]} " =~ " ${opt} " ]]; then
                create_and_switch_workspace "$opt"
                break
            else
                echo "Invalid option $REPLY. Please select a valid environment."
            fi
            ;;
    esac
done

# Remind user to plan before applying changes
echo "Remember to run 'terraform plan' to review changes before applying."
echo "Workspace '$opt' is now active."
}
