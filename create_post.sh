#!/bin/bash

# Prompt the user for the post name
read -p "Enter the post name: " post_name

# Check if the post name is empty
if [ -z "$post_name" ]; then
  echo "Post name cannot be empty."
  exit 1
fi

# Run the hugo command with the provided post name
hugo new content "posts/$post_name/index.md"
