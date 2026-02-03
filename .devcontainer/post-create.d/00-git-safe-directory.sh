#!/bin/bash
#
# Script Name: 00-git-safe-directory.sh
# Description: Configure git safe directory for container workspace
#
# Usage: Executed automatically by post-create.sh
#   bash 00-git-safe-directory.sh --workspace-folder <path>
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
    echo "Usage: bash 00-git-safe-directory.sh --workspace-folder <path>"
    exit 1
fi

git config --add safe.directory "$WORKSPACE_FOLDER"
