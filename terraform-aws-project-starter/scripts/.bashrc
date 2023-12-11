# .bashrc
# This file is executed by bash for non-login shells.

# Source the global definitions (if any)
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export ENV_CONFIG_PATH="/path/to/your/env_config.json"

# Check if the JSON configuration file exists
if [ ! -f "$ENV_CONFIG_PATH" ]; then
    echo "Configuration file not found: $ENV_CONFIG_PATH"
    exit 1
fi

export SCRIPTS_DIR="/path/to/terraform-deployment/scripts/library"
 
# Check if the set_environment.sh file exists
if [ -f $SCRIPTS_DIR/set_environments.sh ]; then
    # Terraform Deployment Environment Setup
    source $SCRIPTS_DIR/set_environments.sh
fi

# Aliases for Terraform Deployment Scripts
alias switchws="$SCRIPTS_DIR/switch_workspace.sh"
alias createenv="$SCRIPTS_DIR/create_environments.sh"
alias initstruct="$SCRIPTS_DIR/initialize_structure.sh"
alias extract_json_value="$SCRIPTS_DIR/utilities/extract_json_value.sh"
alias extract_json_array="$SCRIPTS_DIR/utilities/extract_json_array.sh"

# Add more user-specific settings, aliases, functions etc. below
