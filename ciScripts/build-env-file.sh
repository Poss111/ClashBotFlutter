#!/bin/bash

# Check if at least two arguments are provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <key1> <value1> [<key2> <value2> ...]"
    exit 1
fi

# Create the .env file with the given environment name
env_file=".env"

# Overwrite the file if it exists
> "${env_file}"

# Loop through the remaining arguments and add them to the .env file
while [ "$#" -gt 0 ]; do
    key=$1
    value=$2
    echo "${key}=${value}" >> "${env_file}"
    shift 2
done

echo "Environment file ${env_file} created successfully."