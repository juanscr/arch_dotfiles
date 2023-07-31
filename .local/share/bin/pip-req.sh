#!/usr/bin/env bash

# Get requirement
getRequirement() {
    # Unique lines
    lines=$(echo "$1" | awk '!seen[$0]++')

    # Get the requirement
    requirements=""
    freeze=$(pip freeze)
    while IFS= read -r line; do
        ignore="BEGIN{IGNORECASE=1}"
        requirement=$(echo "$freeze" | awk "$ignore /^$line==/ { print \$0 }")

        # Requirement
        if [ "$requirement" != "" ]; then
            if [ "$requirements" = "" ]; then
                requirements="$requirement"
            else
                requirements="$requirements"$'\n'"$requirement"
            fi
        fi
    done <<< "$lines"

    echo "$requirements"
}

# Separate commands
files=$(find "$1" -name '*.py' -type f -exec cat {} +)
match="match(\$0, \"(import|from) [A-Za-z ,_.]+$\", a)"

# Get imports
imports=$(echo "$files" | awk "{ $match ; print a[0] }" | \
          awk "!/^$/ { print \$2 }")

# Split in dot
imports=$(echo "$imports" | awk '{ split($0, a, "."); print a[1] }')

# Get the requirements
requirements=$(getRequirement "$imports")

echo "$requirements" | awk "!/^$/ { print \$0 }" | sort
