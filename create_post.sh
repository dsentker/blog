#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <post-name>"
  exit 1
fi

# Run the hugo command with the provided argument
hugo new "$1"