#!/bin/bash

# Place the pre_build.sh file in the root directory of your Flutter project.
# Define the environment
ENV=$1

# Copy the correct .env file based on the environment
if [ -z "$ENV" ]; then
  echo "No environment specified. Exiting."
  exit 1
fi

cp ".env.$ENV" ".env"

# Add any other setup tasks here
echo "Environment set to $ENV"
     
# chmod +x pre_build.sh - make the script executable