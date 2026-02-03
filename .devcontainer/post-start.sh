#!/bin/bash
#
# Script Name: post-start.sh
# Description: Orchestrates post-start lifecycle scripts
#
# Usage: Invoked by devcontainer.json postStartCommand
#   bash post-start.sh --workspace-folder <path>
#
# Arguments:
#   --workspace-folder  The container workspace folder path (required)
#
# This script sources the shared runner library and executes
# all scripts in post-start.d/ in sorted order.
#
# To add startup tasks, create scripts in post-start.d/ with
# a numeric prefix for ordering (e.g., 00-env-setup.sh, 10-services.sh).
#
# To disable a script, rename it with .skip.sh suffix.
#

set -euo pipefail

# Parse arguments
WORKSPACE_FOLDER=""
while [[ $# -gt 0 ]]; do
    case $1 in
        --workspace-folder)
            WORKSPACE_FOLDER="$2"
            shift 2
            ;;
        *)
            echo "❌ Unknown argument: $1"
            exit 1
            ;;
    esac
done

# Validate required arguments
if [[ -z "$WORKSPACE_FOLDER" ]]; then
    echo "❌ Error: --workspace-folder is required"
    echo "Usage: bash post-start.sh --workspace-folder <path>"
    exit 1
fi

DEVCONTAINER_FOLDER="$WORKSPACE_FOLDER/.devcontainer"

# shellcheck disable=SC1091
source "$DEVCONTAINER_FOLDER/run-scripts.sh"

echo "🚀 Running post-start setup..."

run_scripts_in_folder "$WORKSPACE_FOLDER" "$DEVCONTAINER_FOLDER/post-start.d"

echo "✅ Post-start setup completed!"
