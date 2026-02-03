#!/bin/bash
#
# Script Name: 90-run-extensions-scripts.sh
# Description: Run custom mounted scripts to customise the devcontainer for the user
#
# Usage: Executed automatically by post-start.sh
#   bash 90-run-uextensions-scripts.sh --workspace-folder <path>
#
# Arguments:
#   --workspace-folder  The container workspace folder path (required)
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
    echo "Usage: bash 90-run-extensions-scripts.sh --workspace-folder <path>"
    exit 1
fi

DEVCONTAINER_FOLDER="$WORKSPACE_FOLDER/.devcontainer"

# shellcheck disable=SC1091
source "$DEVCONTAINER_FOLDER/run-scripts.sh"

if [ -d "$WORKSPACE_FOLDER/.devcontainer-extensions/post-start.d/" ]; then
    run_scripts_in_folder "$WORKSPACE_FOLDER" "$WORKSPACE_FOLDER/.devcontainer-extensions/post-start.d/" " .. [ user extensions ] "
fi
