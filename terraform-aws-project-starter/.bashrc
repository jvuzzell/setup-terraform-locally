# .bashrc
# This file is executed by bash for non-login shells.

# Source the global definitions (if any)
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export ENV_CONFIG_PATH="./env_config.json"

# Check if the JSON configuration file exists
if [ ! -f "$ENV_CONFIG_PATH" ]; then
    echo "Configuration file not found: $ENV_CONFIG_PATH"
    exit 1
fi

current_dir=`pwd`
export LIBRARY_DIR="$current_dir/library"
 
# Check if the set_environment.sh file exists
if [ -f $LIBRARY_DIR/set_environments.sh ]; then
    # Terraform Deployment Environment Setup
    source $LIBRARY_DIR/set_environments.sh
    echo "Configuration started"
fi

# Aliases for Terraform Deployment Scripts
alias switchws="$LIBRARY_DIR/switch_workspace.sh"
alias createenv="$LIBRARY_DIR/create_environments.sh"
alias initstruct="$LIBRARY_DIR/initialize_structure.sh"

terrastarter.init() {
    initstruct
}