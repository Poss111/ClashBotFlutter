#!/bin/bash

# Place the build.sh file in the root directory of your Flutter project.
# Define the environment
ENV=$1

# Check if the environment argument is provided
if [ -z "$ENV" ]; then
  echo "No environment specified. Usage: ./build.sh <environment>"
  exit 1
fi

# Define file paths
ENV_FILE=".env"
ENV_SPECIFIC_FILE=".env.$ENV"

# Function to check if two files are different
files_are_different() {
  if [ ! -f "$ENV_FILE" ] || [ ! -f "$ENV_SPECIFIC_FILE" ]; then
    return 0
  fi

  if ! cmp -s "$ENV_FILE" "$ENV_SPECIFIC_FILE"; then
    return 0
  fi

  return 1
}

# Copy the environment-specific file to .env
cp "$ENV_SPECIFIC_FILE" "$ENV_FILE"

# Run the pre-build script if it exists
if [ -f "./pre_build.sh" ]; then
  ./pre_build.sh $ENV
else
  echo "Pre-build script not found."
fi

# Check if .env and .env.$ENV are different
if files_are_different; then
  echo "Environment files are different or one of them is missing. Running build_runner clean..."
  dart run build_runner clean
else
  echo "Environment files are the same. Skipping build_runner clean..."
fi

# Run build_runner build
dart run build_runner build --delete-conflicting-outputs