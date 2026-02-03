#!/bin/bash
#
# Script Name: run-scripts.sh
# Description: Shared library for executing modular scripts from .d folders
#
# Usage: source this file, then call run_scripts_in_folder <workspace-folder> <scripts-folder>
#
# Dependencies:
#   - bash 4.0+
#   - find, sort
#

# Run all *.sh scripts in a folder (excluding *.skip.sh)
# Arguments:
#   $1 - Workspace folder path to pass to each script
#   $2 - Folder path containing scripts to execute
#   $3 - Context that scripts are executed under - optional
# Returns:
#   0 on success, non-zero on first script failure (fail-fast)
run_scripts_in_folder() {
    local workspace_folder="$1"
    local scripts_folder="$2"
    local context="${3:-""}"
    local script_name
    local scripts_found=0

    # Check if folder exists
    if [[ ! -d "$scripts_folder" ]]; then
        echo "${context}⚠️  Scripts folder not found: $scripts_folder"
        return 0
    fi

    # Find and execute scripts in sorted order
    # - Match *.sh files
    # - Exclude *.skip.sh files
    # - Sort naturally (00- before 10- before 100-)
    while IFS= read -r script; do
        [[ -z "$script" ]] && continue
        
        script_name=$(basename "$script")
        scripts_found=$((scripts_found + 1))

        echo "${context}▶️  Running: $script_name"
        
        # Execute script with fail-fast (errexit propagates)
        if ! bash "$script" --workspace-folder "$workspace_folder"; then
            echo "${context}❌ Failed: $script_name"
            return 1
        fi
        
        echo "${context}✅ Completed: $script_name"
    done < <(find "$scripts_folder" -maxdepth 1 -name '*.sh' ! -name '*.skip.sh' -type f | sort -V)

    if [[ $scripts_found -eq 0 ]]; then
        echo "${context}ℹ️  No scripts found in: $scripts_folder"
    fi

    return 0
}
